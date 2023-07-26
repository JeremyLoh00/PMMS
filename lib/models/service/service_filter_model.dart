class ServiceFilterModel {
  String? query;

  //compalsory
  int? page;
  int? take;

  ServiceFilterModel({this.query, this.page = 1, this.take = 100000000});

  ServiceFilterModel.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    page = json['page'];
    take = json['take'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['query'] = query;
    data['page'] = page;
    data['take'] = take;
    return data;
  }
}