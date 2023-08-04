class ListFeedbackForSpecificNurseModel {
  int? id;
  String? comment;
  int? rating;

  ListFeedbackForSpecificNurseModel({this.id, this.comment, this.rating});

  ListFeedbackForSpecificNurseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    return data;
  }
}
