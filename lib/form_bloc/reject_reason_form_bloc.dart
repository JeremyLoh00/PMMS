import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:private_nurse_for_client/bloc/reject_reason_bloc.dart';
import 'package:private_nurse_for_client/models/default_response_model.dart';

import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/list_reject_reason_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/reject_reason_list_response_model.dart';
import 'package:private_nurse_for_client/models/reject_reason/reject_reason_request_model.dart';

class RejectReasonFormBloc extends FormBloc<String, String> {
  JobModel jobModel;
  RejectReasonRequestModel rejectReasonRequestModel;

  final rejectReason = MultiSelectFieldBloc<ListRejectReasonModel, dynamic>();

  // Constructor
  RejectReasonFormBloc(this.jobModel, this.rejectReasonRequestModel) {
    getRejectReasonData();

    addFieldBlocs(fieldBlocs: [rejectReason]);
  }

  @override
  Future<void> onSubmitting() async {
    try {
      rejectReasonRequestModel.rejectReason = rejectReason.value;

      // Declare Bloc
      RejectReasonBloc rejectReasonBloc = RejectReasonBloc();
      // Call API
      DefaultResponseModel responseModel =
          await rejectReasonBloc.rejectNurse(jobModel.id!);

      // Handle response
      if (responseModel.isSuccess) {
        // Emit success
        emitSuccess();
      } else {
        // Emit failure with validation errors
        emitFailure(failureResponse: responseModel.message);
      }
    } catch (exception) {
      emitFailure(failureResponse: exception.toString());
    }
  }

  void getRejectReasonData() async {
    // Call API to get list of outlets
    RejectReasonBloc rejectReasonBloc = RejectReasonBloc();
    RejectReasonListResponseModel rejectReasonListResponseModel =
        await rejectReasonBloc.getListRejectReason();
    if (rejectReasonListResponseModel.isSuccess) {
      for (ListRejectReasonModel reject
          in rejectReasonListResponseModel.data!) {
        rejectReason.addItem(reject);
        if (rejectReasonRequestModel.rejectReason!
            .where((rejectModel) => rejectModel.id == reject.id)
            .isNotEmpty) {
          rejectReason.select(reject);
        }
      }
    }
  }
}
