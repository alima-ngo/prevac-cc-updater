class ExcelExporter
  require 'csv'

  STATIC_FIELDS = {
    case_id:                        {value: "", format: "string"},
    prochaine_visite:               {value: "j7", format: "string"},
    confirmation_prochaine_visite:  {value: "non", format: "string"},
    date_dernier_rappel:            {value: "", format: "date"}
  }

  MORPHO_FIELDS = {
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
    date_j0_effectuee:    {morpho_field: "Date_Of_Enrollment", format: "date"}
    #sous_etude: "" # TODO
  }

  VISIT_FIELDS = {
    "j7" =>   {delta: 7, done_field: "date_j7_effectuee", planned_field: "date_j7_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j14" =>  {delta: 14, done_field: "date_j14_effectuee", planned_field: "date_j14_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j28" =>  {delta: 28, done_field: "date_j28_effectuee", planned_field: "date_j28_prevue", window_start: 7, window_end: 7, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j56" =>  {delta: 56, done_field: "date_j56_effectuee", planned_field: "date_j56_prevue", window_start: 3, window_end: 10, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j63" =>  {delta: 7, done_field: "date_j63_effectuee", planned_field: "date_j63_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j56"},
    "j70" =>  {delta: 14, done_field: "date_j70_effectuee", planned_field: "date_j70_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j56"},
    "m3" =>   {delta: 3, done_field: "date_m3_effectuee", planned_field: "date_m3_prevue", window_start: 14, window_end: 14, window_unit: "d", delta_unit: "m", relative_to: "j0"},
    "m6" =>   {delta: 6, done_field: "date_m6_effectuee", planned_field: "date_m6_prevue", window_start: 1, window_end: 1, window_unit: "m", delta_unit: "m", relative_to: "j0"},
    "m12" =>  {delta: 12, done_field: "date_m12_effectuee", planned_field: "date_m12_prevue", window_start: 1, window_end: 1, window_unit: "m", delta_unit: "m", relative_to: "j0"}
  }

  def self.create_new_participants_xls cc_update
    since = CommcareUpdate.last_successful_new_participant_import
    begin
      r = HTTP.get("#{ApplicationController::MQI_URL}/queries/new_participants/2016-01-01") # DEBUG: 2016-01-01 => since
    rescue => e
      cc_update.errors.add(:base, "Erreur pendant la requête \"nouveaux participants (new_participants)\" : #{e}")
      return nil
    end

    participants = self.clean_morpho_data(JSON.parse(r.body, object_class: OpenStruct))
    csv_content = []

    header = STATIC_FIELDS.keys.map { |k| k.to_s }
    header.concat MORPHO_FIELDS.keys.map { |k| k.to_s }
    header.concat VISIT_FIELDS.values.map { |k| [k[:done_field], k[:planned_field]]}.flatten
    csv_content.push header

    participants.each do |p|
      x = []
      STATIC_FIELDS.each { |k, v| x.push v[:value] }
      MORPHO_FIELDS.each { |k, v| x.push p.send(v[:morpho_field]) }
      VISIT_FIELDS.values.each do |v|
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
    system("ssconvert --export-type=Gnumeric_Excel:excel_biff8 #{csv_filename} #{xls_filename}")

    participants
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

  def self.write_csv data

  end

end
