class ListFeedbackForSpecificNurseModel {
  int? id;
  String? date;
  String? time;
  String? commentId;
  String? comment;
  int? rating;
  String? feedbackPhotoUrl;
  String? serviceName;
  int? jobId;
  String? profilePicUserFrom;
  String? nameUserFrom;

  ListFeedbackForSpecificNurseModel(
      {this.id,
      this.date,
      this.time,
      this.commentId,
      this.comment,
      this.rating,
      this.feedbackPhotoUrl,
      this.serviceName,
      this.jobId,
      this.profilePicUserFrom,
      this.nameUserFrom});

  ListFeedbackForSpecificNurseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    commentId = json['comment_id'];
    comment = json['comment'];
    rating = json['rating'];
    feedbackPhotoUrl = json['feedback_photo_url'];
    serviceName = json['service_name'];
    jobId = json['job_id'];
    profilePicUserFrom = json['profile_pic_user_from'];
    nameUserFrom = json['name_user_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['comment_id'] = this.commentId;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['feedback_photo_url'] = this.feedbackPhotoUrl;
    data['service_name'] = this.serviceName;
    data['job_id'] = this.jobId;
    data['profile_pic_user_from'] = this.profilePicUserFrom;
    data['name_user_from'] = this.nameUserFrom;
    return data;
  }
}
