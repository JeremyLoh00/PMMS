class SubscriptionFilterRequestModel {
  int? take;

  SubscriptionFilterRequestModel({
    this.take = 100000,
  });

  SubscriptionFilterRequestModel.fromJson(Map<String, dynamic> json) {
    take = json['take'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['take'] = this.take;

    return data;
  }
}
