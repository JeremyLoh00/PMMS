
class ReviewModel {
  int? id;
  String? comment;
  int? rating;

  ReviewModel({this.id, this.comment, this.rating});

  ReviewModel.fromJson(Map<String, dynamic> json) {
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