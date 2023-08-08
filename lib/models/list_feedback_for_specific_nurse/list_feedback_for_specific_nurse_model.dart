class ListFeedbackForSpecificNurseModel {
  int? id;
  String? date;
  String? time;
  int? commentId;
  String? comment;
  int? rating;
  String? feedbackPhotoPath;
  String? profilePicUserFrom;

  ListFeedbackForSpecificNurseModel(
      {this.id,
      this.date,
      this.time,
      this.commentId,
      this.comment,
      this.rating,
      this.feedbackPhotoPath,
      this.profilePicUserFrom});

  ListFeedbackForSpecificNurseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    date = json['date'];
    time = json['time'];
    commentId = json['comment_id'];
    comment = json['comment'];
    rating = json['rating'];
    feedbackPhotoPath = json['feedback_photo_path'];
    profilePicUserFrom = json['profile_pic_user_from'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['date'] = this.date;
    data['time'] = this.time;
    data['comment_id'] = this.commentId;
    data['comment'] = this.comment;
    data['rating'] = this.rating;
    data['feedback_photo_path'] = this.feedbackPhotoPath;
    data['profile_pic_user_from'] = this.profilePicUserFrom;
    return data;
  }
}
