class UniformFeePaymentRequestModel {
  int? jobId;

  UniformFeePaymentRequestModel({this.jobId});

  UniformFeePaymentRequestModel.fromJson(Map<String, dynamic> json) {
    jobId = json['job[id]'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['job[id]'] = this.jobId;
    return data;
  }
}
