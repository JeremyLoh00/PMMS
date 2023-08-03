import 'package:image_picker/image_picker.dart';

class FeedbackModel {
  int? id;
  String? comment;
  int? rating;
  XFile? feedbackPhotoPath;

  FeedbackModel({this.id, this.comment, this.rating, this.feedbackPhotoPath});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    rating = json['rating'];
    // feedbackPhotoPath = json['feedback_photo_path'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    // data['feedback_photo_path'] = this.feedbackPhotoPath;
    return data;
  }
}
