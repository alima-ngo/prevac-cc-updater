class ExcelExporter
  EMPTY_EXCEL_FILENAME = "bin/empty-excel-file.xls"

  MORPHO_FIELDS = {
    name:	"PID",
    nom_prenom: "Full_Name",
    site: "Prefecture",
    zone: "Sub_Prefecture",
    complement_adresse: "Village",
    owner_name: "Sub_Prefecture",
    telephone_1: "Phone_Number_1",
    telephone_2: "Phone_Number_2",
    email: "Email",
    contact_1_nom: "Full_Name_Additional_Contact_1",
    contact_1_info: "Information_Additional_Contact_1",
    contact_1_telephone: "Phone_Number_Additional_Contact_1",
    contact_2_nom: "Full_Name_Additional_Contact_2",
    contact_2_info: "Information_Additional_Contact_2",
    contact_2_telephone: "Phone_Number_Additional_Contact_2",
    mois_naissance: "Month_Of_Birth",
    annee_naissance: "Year_Of_Birth",
    genre: "Gender",
    exclu: "Exclude",
    date_exclusion: "Date_Of_Exclude",
    date_j0_effectuee: "Date_Of_Enrollment"
    #sous_etude: "" # TODO
  }

  VISIT_FIELDS = {
    "j7" => {delta: 7, done_field: "date_j7_effectuee", planned_field: "date_j7_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j14" => {delta: 14, done_field: "date_j14_effectuee", planned_field: "date_j14_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j28" => {delta: 28, done_field: "date_j28_effectuee", planned_field: "date_j28_prevue", window_start: 7, window_end: 7, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j56" => {delta: 56, done_field: "date_j56_effectuee", planned_field: "date_j56_prevue", window_start: 3, window_end: 10, window_unit: "d", delta_unit: "d", relative_to: "j0"},
    "j63" => {delta: 7, done_field: "date_j63_effectuee", planned_field: "date_j63_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j56"},
    "j70" => {delta: 14, done_field: "date_j70_effectuee", planned_field: "date_j70_prevue", window_start: 3, window_end: 3, window_unit: "d", delta_unit: "d", relative_to: "j56"},
    "m3" => {delta: 3, done_field: "date_m3_effectuee", planned_field: "date_m3_prevue", window_start: 14, window_end: 14, window_unit: "d", delta_unit: "m", relative_to: "j0"},
    "m6" => {delta: 6, done_field: "date_m6_effectuee", planned_field: "date_m6_prevue", window_start: 1, window_end: 1, window_unit: "m", delta_unit: "m", relative_to: "j0"},
    "m12" => {delta: 12, done_field: "date_m12_effectuee", planned_field: "date_m12_prevue", window_start: 1, window_end: 1, window_unit: "m", delta_unit: "m", relative_to: "j0"}
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

    Spreadsheet.client_encoding = 'UTF-8'
    book = Spreadsheet.open(EMPTY_EXCEL_FILENAME)
    sheet = book.worksheets.first

    header = MORPHO_FIELDS.keys.map { |k| k.to_s }
    header.concat VISIT_FIELDS.values.map { |k| [k[:done_field], k[:planned_field]]}.flatten
    header.concat ["prochaine_visite", "case_id"]
    sheet.row(0).concat header

    participants.each do |p|
      x = []
      MORPHO_FIELDS.each { |k, v| x.push p.send(v) }
      VISIT_FIELDS.values.each do |v|
        j0 = Date.parse(p.Date_Of_Enrollment)
        x.concat ["", self.compute_visit_planned_date(j0, v)] # [done, planned]
      end
      x.concat ["j7", ""] # prochaine visite, case_id
      sheet.row(sheet.row_count).concat x
    end

    book.write cc_update.new_participants_file_path

    participants
  end

  def self.clean_morpho_data data
    data.each do |d|
      d.Gender.downcase!
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
    d.to_s
  end

end
