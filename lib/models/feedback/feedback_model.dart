class FeedbackModel {
  int? reviewCounts;
  int? averageRatings;

  FeedbackModel({this.reviewCounts, this.averageRatings});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    reviewCounts = json['review_counts'];
    averageRatings = json['average_ratings'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['review_counts'] = this.reviewCounts;
    data['average_ratings'] = this.averageRatings;
    return data;
  }
}