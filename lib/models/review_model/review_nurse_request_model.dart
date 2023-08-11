import 'package:image_picker/image_picker.dart';

class ReviewNurseRequestModel {
  XFile? photoPath;
  String? comment;
  String? rating;

  ReviewNurseRequestModel({this.photoPath, this.comment, this.rating});

  ReviewNurseRequestModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();
    data['comment'] = this.comment.toString();
    data['rating'] = this.rating.toString();
    return data;
  }
}
