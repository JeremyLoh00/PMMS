
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';

class RejectReasonRequestModel {
  List<ListRejectReasonModel>? rejectReason;

  RejectReasonRequestModel(
      {
      this.rejectReason});

  RejectReasonRequestModel.fromJson(Map<String, dynamic> json) {
 
    if (json['rejected_reason'] != null) {
      rejectReason = <ListRejectReasonModel>[];
      json['rejected_reason'].forEach((v) {
        rejectReason!.add(ListRejectReasonModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
   
    if (rejectReason != null) {
      data['rejected_reason'] = rejectReason!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
