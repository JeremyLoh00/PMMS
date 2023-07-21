import 'package:private_nurse_for_client/models/feedback/feedback_model.dart';

class NurseModel {
  int? id;
  String? formalPhoto1Path;
  String? formalPhoto2Path;
  String? name;
  String? phoneNo;
  int? points;
  FeedbackModel? feedbacks;

  NurseModel(
      {this.id,
      this.formalPhoto1Path,
      this.formalPhoto2Path,
      this.name,
      this.phoneNo,
      this.points,
      this.feedbacks});

  NurseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    formalPhoto1Path = json['formal_photo_1_path'];
    formalPhoto2Path = json['formal_photo_2_path'];
    name = json['name'];
    phoneNo = json['phone_no'];
    points = json['points'];
    feedbacks = json['feedbacks'] != null
        ? new FeedbackModel.fromJson(json['feedbacks'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['formal_photo_1_path'] = this.formalPhoto1Path;
    data['formal_photo_2_path'] = this.formalPhoto2Path;
    data['name'] = this.name;
    data['phone_no'] = this.phoneNo;
    data['points'] = this.points;
    if (this.feedbacks != null) {
      data['feedbacks'] = this.feedbacks!.toJson();
    }
    return data;
  }
}