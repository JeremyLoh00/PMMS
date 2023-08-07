import 'package:image_picker/image_picker.dart';

class ReviewNurseRequestModel {
  XFile? photoPath;
  int? id;
  String? comment;
  int? rating;

  ReviewNurseRequestModel({this.id, this.comment, this.rating});

  ReviewNurseRequestModel.fromJson(Map<String, dynamic> json) {
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
