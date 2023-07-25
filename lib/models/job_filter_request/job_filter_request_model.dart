class JobFilterRequestModel {
  //compulsory
  int? page;
  int? take;
  int? tab;
  int? cityId;
  int? divisionId;

  JobFilterRequestModel({
    this.cityId,
    this.divisionId,
    this.page = 1,
    this.take = 100000,
    this.tab,
  });

  JobFilterRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    take = json['take'];
    tab = json['tab'];
    cityId = json['city_id'];
    divisionId = json['division_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['page'] = this.page;
    data['take'] = this.take;
    data['tab'] = this.tab;
    data['city_id'] = this.cityId;
    data['division_id'] = this.divisionId;

    return data;
  }
}
