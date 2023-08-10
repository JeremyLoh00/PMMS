class FeedbackFilterRequestModel {
  //compulsory
  int? take;
  int? page;

  FeedbackFilterRequestModel({
    this.page = 1,
    this.take = 30,
  });

  FeedbackFilterRequestModel.fromJson(Map<String, dynamic> json) {
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
