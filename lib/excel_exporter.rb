class ExcelExporter
  require 'csv'

  EXCEL_EXPORT_FORMAT = "Gnumeric_Excel:excel_biff8"

  NEW_PARTICIPANTS_STATIC_FIELDS = {
    case_id:                        {value: "", format: "string"},
    prochaine_visite:               {value: "j7", format: "string"},
    confirmation_prochaine_visite:  {value: "non", format: "string"},
    date_dernier_rappel:            {value: "", format: "date"}
  }

  NEW_PARTICIPANTS_MORPHO_FIELDS = {
    name:                 {morpho_field: "PID", format: "string"},
    nom_prenom:           {morpho_field: "Full_Name", format: "string"},
    site:                 {morpho_field: "Prefecture", format: "string"}, # FIX
    zone:                 {morpho_field: "Sub_Prefecture", format: "string"}, # FIX
    complement_adresse:   {morpho_field: "Village", format: "string"}, # FIX
    owner_name:           {morpho_field: "Sub_Prefecture", format: "string"}, #FIX
    telephone_1:          {morpho_field: "Phone_Number_1", format: "string"},
    telephone_2:          {morpho_field: "Phone_Number_2", format: "string"},
    email:                {morpho_field: "Email", format: "string"},
    contact_1_nom:        {morpho_field: "Full_Name_Additional_Contact_1", format: "string"},
    contact_1_info:       {morpho_field: "Information_Additional_Contact_1", format: "string"},
    contact_1_telephone:  {morpho_field: "Phone_Number_Additional_Contact_1", format: "string"},
    contact_2_nom:        {morpho_field: "Full_Name_Additional_Contact_2", format: "string"},
    contact_2_info:       {morpho_field: "Information_Additional_Contact_2", format: "string"},
    contact_2_telephone:  {morpho_field: "Phone_Number_Additional_Contact_2", format: "string"},
    mois_naissance:       {morpho_field: "Month_Of_Birth", format: "string"},
    annee_naissance:      {morpho_field: "Year_Of_Birth", format: "string"},
    genre:                {morpho_field: "Gender", format: "string"},
    exclu:                {morpho_field: "Exclude", format: "string"},
    date_exclusion:       {morpho_field: "Date_Of_Exclude", format: "date"},
    date_j0_effectuee:    {morpho_field: "Date_Of_Enrollment", format: "date"},
    #sous_etude: "" # TODO
    external_id:          {morpho_field: :name, format: "string"}
  }

  VISITS = {
    "j7" =>   {delta: 7, done_field: "date_j7_effectuee", planned_field: "date_j7_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j0", reminder: :short},
    "j14" =>  {delta: 14, done_field: "date_j14_effectuee", planned_field: "date_j14_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j0", reminder: :short},
    "j28" =>  {delta: 28, done_field: "date_j28_effectuee", planned_field: "date_j28_prevue", window_start: 7, window_end: 7, window_unit: "d", delta_unit: "d", relative_to: "j0", reminder: :short},
    "j56" =>  {delta: 56, done_field: "date_j56_effectuee", planned_field: "date_j56_prevue", window_start: 3, window_end: 10, window_unit: "d", delta_unit: "d", relative_to: "j0", reminder: :j56},
    "j63" =>  {delta: 7, done_field: "date_j63_effectuee", planned_field: "date_j63_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j56", reminder: :short},
    "j70" =>  {delta: 14, done_field: "date_j70_effectuee", planned_field: "date_j70_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j56", reminder: :short},
    "m3" =>   {delta: 3, done_field: "date_m3_effectuee", planned_field: "date_m3_prevue", window_start: 14, window_end: 14, window_unit: "d", delta_unit: "m", relative_to: "j0", reminder: :medium},
    "m6" =>   {delta: 6, done_field: "date_m6_effectuee", planned_field: "date_m6_prevue", window_start: 1, window_end: 1, window_unit: "m", delta_unit: "m", relative_to: "j0", reminder: :long},
    "m12" =>  {delta: 12, done_field: "date_m12_effectuee", planned_field: "date_m12_prevue", window_start: 1, window_end: 1, window_unit: "m", delta_unit: "m", relative_to: "j0", reminder: :long}
  }

  REMINDER_TYPES = {
    short: ["d-4", "d-1", "d+1", "d+2"],
    medium: ["d-14", "d-7", "d-1", "d+1", "d+7", "d+13"],
    long: ["m-1", "d-14", "d-7", "d-1", "d+1", "d+7", "d+14", "m+1d-1"],
    j56: ["d-10", "d-4", "d-1", "d+1", "d+2", "d+3", "d+4", "d+5", "d+6", "d+7", "d+8", "d+9"]
  }

  NEW_REMINDERS_FIELDS = {
    case_id:      {value: ""},
    parent_type:  {value: "prevac-participant"},
    confirmation: {value: "non"},
    name: {},
    appel_veille: {},
    date_prevue_appel: {},
    type_visite: {},
    date_visite: {},
    external_id: {},
    parent_external_id: {}
  }

  def self.create_new_participants_reminders_xls cc_update
    p_data = self.get_new_participants_data(cc_update)
    self.generate_new_participants_files(cc_update, p_data)
    self.generate_new_reminders_files(cc_update, p_data)
    p_data
  end

  def self.generate_new_participants_files cc_update, p_data
    csv_content = []

    header = NEW_PARTICIPANTS_STATIC_FIELDS.keys.map { |k| k.to_s }
    header.concat NEW_PARTICIPANTS_MORPHO_FIELDS.keys.map { |k| k.to_s }
    header.concat VISITS.values.map { |k| [k[:done_field], k[:planned_field]]}.flatten
    csv_content.push header

    p_data.each do |p|
      x = []
      NEW_PARTICIPANTS_STATIC_FIELDS.each { |k, v| x.push v[:value] }
      NEW_PARTICIPANTS_MORPHO_FIELDS.each { |k, v| x.push p.send(v[:morpho_field].class == Symbol ? NEW_PARTICIPANTS_MORPHO_FIELDS[v[:morpho_field]][:morpho_field] : v[:morpho_field]) }
      VISITS.values.each do |v|
        j0 = Date.parse(p.Date_Of_Enrollment)
        x.concat ["", self.compute_visit_planned_date(j0, v)] # [done, planned]
      end
      csv_content.push x
    end

    csv_filename = cc_update.new_participants_file_path("csv")
    CSV.open(csv_filename, "w+", force_quotes: true, quote_char: '"') do |csv|
      csv_content.each { |r| csv << r }
    end

    xls_filename = cc_update.new_participants_file_path("xls")
    system("ssconvert --export-type=#{EXCEL_EXPORT_FORMAT} #{csv_filename} #{xls_filename}")
  end

  def self.generate_new_reminders_files cc_update, p_data
    csv_content = []

    header = NEW_REMINDERS_FIELDS.keys.map { |k| k.to_s }
    csv_content.push header

    p_data.each do |p|
      VISITS.each do |k, v|
        reminders = REMINDER_TYPES[v[:reminder]]
        reminders.each do |r|
          break if v[:relative_to] != "j0" # No reminders for visits not relative to j0
          x = []
          NEW_REMINDERS_FIELDS.each { |k, v| x.push v[:value] if !v[:value].nil? }
          date_visite = self.compute_visit_planned_date(Date.parse(p.Date_Of_Enrollment), v)
          date_prevue_appel = self.compute_reminder_date(date_visite, r)
          name = external_id = "#{p.PID}_rappel_#{date_prevue_appel}"
          appel_veille = r == "d-1" ? "oui" : "non"
          type_visite = k
          parent_external_id = p.PID

          # Mind the order in which the fields are pushed
          x.push name
          x.push appel_veille
          x.push date_prevue_appel
          x.push type_visite
          x.push date_visite
          x.push external_id
          x.push parent_external_id

          csv_content.push x
        end
      end
    end

    csv_filename = cc_update.new_reminders_file_path("csv")
    CSV.open(csv_filename, "w+", force_quotes: true, quote_char: '"') do |csv|
      csv_content.each { |r| csv << r }
    end

    xls_filename = cc_update.new_reminders_file_path("xls")
    system("ssconvert --export-type=#{EXCEL_EXPORT_FORMAT} #{csv_filename} #{xls_filename}")
  end

  def self.get_new_participants_data cc_update
    since = CommcareUpdate.last_successful_new_participant_import
    begin
      r = HTTP.get("#{ApplicationController::MQI_URL}/queries/new_participants/2016-01-01") # DEBUG: 2016-01-01 => since
    rescue => e
      cc_update.errors.add(:base, "Erreur pendant la requête \"nouveaux participants (new_participants)\" : #{e}")
      return nil
    end
    self.clean_morpho_data(JSON.parse(r.body, object_class: OpenStruct))
  end

  def self.clean_morpho_data data
    data.each do |d|
      d.Gender.downcase!
      d.Sub_Prefecture = "zone-1" # DEBUG
    end
    data
  end

  def self.compute_visit_planned_date j0, visit
    return "" if visit[:relative_to] != "j0" # only dates relative to J0 can be computed
    if visit[:delta_unit] == "d"
      d = j0 + visit[:delta]
    else # == "m"
      d = j0 >> visit[:delta]
    end
    d.strftime("%Y-%m-%d")
  end

  def self.compute_reminder_date visit_date, reminder
    d = Date.parse(visit_date)
    offsets = reminder.scan(/(m|d)(-|\+)([0-9]+)/)
    offsets.each do |o|
      val = "#{o[1]}#{o[2]}".to_i
      d = o[0] == "m" ? d >> val : d + val
    end
    d.strftime("%Y-%m-%d")
  end

end
