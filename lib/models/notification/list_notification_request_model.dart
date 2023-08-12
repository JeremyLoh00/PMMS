class ListNotificationRequestModel {
  //compulsory
  int? take;
  int? page;
 

  ListNotificationRequestModel({
 
    this.page = 1,
    this.take = 30,
  
  });

  ListNotificationRequestModel.fromJson(Map<String, dynamic> json) {
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
