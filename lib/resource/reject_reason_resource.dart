import 'dart:convert';

import 'package:private_nurse_for_client/models/reject_reason/reject_reason_list_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';


class RejectReasonResource {
  static Resource getListRejectReason() {
    return Resource(
        url: 'reject-reason',
        params: {
        },
        parse: (response) {
          return RejectReasonListResponseModel(json.decode(response.body));
        });
  }

}
