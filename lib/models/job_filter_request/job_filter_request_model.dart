class JobFilterRequestModel {
  //compulsory
  int? page;
  int? take;
  int? tab;

  JobFilterRequestModel({
    this.page = 1,
    this.take = 100000,
    this.tab,
  });

  JobFilterRequestModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    take = json['take'];
    tab = json['tab'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['page'] = this.page;
    data['take'] = this.take;
    data['tab'] = this.tab;

    return data;
  }
}
