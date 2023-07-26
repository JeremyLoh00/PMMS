class JobFormErrorModel {
  List<String>? date;
  List<String>? time;
  List<String>? status;
  List<String>? isOpenToCompanyNurse;
  List<String>? serviceId;
  List<String>? medicalHistories;
  List<String>? conditions;
  List<String>? patient;
  List<String>? patientsName;
  List<String>? patientsAge;
  List<String>? patientsIcNo;
  List<String>? patientsIcPhotoPath;
  List<String>? patientsRace;
  List<String>? patientsGender;
  List<String>? patientsNationalityId;
  List<String>? patientsPreferredGender;
  List<String>? patientsPreferredRace;
  List<String>? height;
  List<String>? weight;
  List<String>? patientPhoto1Path;
  List<String>? patientPhoto2Path;
  List<String>? emergencyContact;
  List<String>? emergencyContactName;
  List<String>? emergencyContactPhoneNo;
  List<String>? emergencyContactRelationship;

  JobFormErrorModel(
      {this.date,
      this.time,
      this.status,
      this.isOpenToCompanyNurse,
      this.serviceId,
      this.medicalHistories,
      this.conditions,
      this.patient,
      this.patientsName,
      this.patientsAge,
      this.patientsIcNo,
      this.patientsIcPhotoPath,
      this.patientsRace,
      this.patientsGender,
      this.patientsNationalityId,
      this.patientsPreferredGender,
      this.patientsPreferredRace,
      this.height,
      this.weight,
      this.patientPhoto1Path,
      this.patientPhoto2Path,
      this.emergencyContact,
      this.emergencyContactName,
      this.emergencyContactPhoneNo,
      this.emergencyContactRelationship});

  JobFormErrorModel.fromJson(Map<String, dynamic> json) {
    date = json['date'].cast<String>();
    time = json['time'].cast<String>();
    status = json['status'].cast<String>();
    isOpenToCompanyNurse = json['is_open_to_company_nurse'].cast<String>();
    serviceId = json['service_id'].cast<String>();
    medicalHistories = json['medical_histories'].cast<String>();
    conditions = json['conditions'].cast<String>();
    patient = json['patient'].cast<String>();
    patientsName = json['patients.name'].cast<String>();
    patientsAge = json['patients.age'].cast<String>();
    patientsIcNo = json['patients.ic_no'].cast<String>();
    patientsIcPhotoPath = json['patients.ic_photo_path'].cast<String>();
    patientsRace = json['patients.race'].cast<String>();
    patientsGender = json['patients.gender'].cast<String>();
    patientsNationalityId = json['patients.nationality_id'].cast<String>();
    patientsPreferredGender = json['patients.preferred_gender'].cast<String>();
    patientsPreferredRace = json['patients.preferred_race'].cast<String>();
    height = json['height'].cast<String>();
    weight = json['weight'].cast<String>();
    patientPhoto1Path = json['patient_photo_1_path'].cast<String>();
    patientPhoto2Path = json['patient_photo_2_path'].cast<String>();
    emergencyContact = json['emergency_contact'].cast<String>();
    emergencyContactName = json['emergency_contact.name'].cast<String>();
    emergencyContactPhoneNo = json['emergency_contact.phone_no'].cast<String>();
    emergencyContactRelationship =
        json['emergency_contact.relationship'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['time'] = this.time;
    data['status'] = this.status;
    data['is_open_to_company_nurse'] = this.isOpenToCompanyNurse;
    data['service_id'] = this.serviceId;
    data['medical_histories'] = this.medicalHistories;
    data['conditions'] = this.conditions;
    data['patient'] = this.patient;
    data['patients.name'] = this.patientsName;
    data['patients.age'] = this.patientsAge;
    data['patients.ic_no'] = this.patientsIcNo;
    data['patients.ic_photo_path'] = this.patientsIcPhotoPath;
    data['patients.race'] = this.patientsRace;
    data['patients.gender'] = this.patientsGender;
    data['patients.nationality_id'] = this.patientsNationalityId;
    data['patients.preferred_gender'] = this.patientsPreferredGender;
    data['patients.preferred_race'] = this.patientsPreferredRace;
    data['height'] = this.height;
    data['weight'] = this.weight;
    data['patient_photo_1_path'] = this.patientPhoto1Path;
    data['patient_photo_2_path'] = this.patientPhoto2Path;
    data['emergency_contact'] = this.emergencyContact;
    data['emergency_contact.name'] = this.emergencyContactName;
    data['emergency_contact.phone_no'] = this.emergencyContactPhoneNo;
    data['emergency_contact.relationship'] = this.emergencyContactRelationship;
    return data;
  }
}
