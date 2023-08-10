import 'package:image_picker/image_picker.dart';

class ReviewNurseRequestModel {
  XFile? photoPath;
  String? comment;
  int? rating;

  ReviewNurseRequestModel({this.comment, this.rating});

  ReviewNurseRequestModel.fromJson(Map<String, dynamic> json) {
    comment = json['comment'];
    rating = json['rating'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    return data;
  }
}
