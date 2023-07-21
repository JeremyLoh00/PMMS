class NurseFilterRequestModel {
  //compulsory
  int? page;
  int? take;

  NurseFilterRequestModel({
    this.page = 1,
    this.take = 100000,
  });

  NurseFilterRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    take = json['take'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['page'] = this.page;
    data['take'] = this.take;

    return data;
  }
}
