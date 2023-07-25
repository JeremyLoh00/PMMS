class PatientModel {
  int? id;
  String? name;
  String? age;
  String? icNo;
  String? icFilePath;
  String? race;
  int? raceId;
  String? gender;
  int? genderId;
  String? nationality;
  int? nationalityId;
  String? preferredGender;
  int? preferredGenderId;
  String? preferredRace;
  int? preferredRaceId;

  PatientModel(
      {this.id,
      this.name,
      this.age,
      this.icNo,
      this.icFilePath,
      this.race,
      this.raceId,
      this.gender,
      this.genderId,
      this.nationality,
      this.nationalityId,
      this.preferredGender,
      this.preferredGenderId,
      this.preferredRace,
      this.preferredRaceId});

  PatientModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    age = json['age'];
    icNo = json['ic_no'];
    icFilePath = json['ic_file_path'];
    race = json['race'];
    raceId = json['race_id'];
    gender = json['gender'];
    genderId = json['gender_id'];
    nationality = json['nationality'];
    nationalityId = json['nationality_id'];
    preferredGender = json['preferred_gender'];
    preferredGenderId = json['preferred_gender_id'];
    preferredRace = json['preferred_race'];
    preferredRaceId = json['preferred_race_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['age'] = this.age;
    data['ic_no'] = this.icNo;
    data['ic_file_path'] = this.icFilePath;
    data['race'] = this.race;
    data['race_id'] = this.raceId;
    data['gender'] = this.gender;
    data['gender_id'] = this.genderId;
    data['nationality'] = this.nationality;
    data['nationality_id'] = this.nationalityId;
    data['preferred_gender'] = this.preferredGender;
    data['preferred_gender_id'] = this.preferredGenderId;
    data['preferred_race'] = this.preferredRace;
    data['preferred_race_id'] = this.preferredRaceId;
    return data;
  }
}