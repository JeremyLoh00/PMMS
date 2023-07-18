import 'dart:convert';

import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/uniform_fee_payment_request_model.dart/uniform_fee_payment_request_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class UniformFeePaymentResource {
  static Resource uniformFeePayment(
      UniformFeePaymentRequestModel requestModel) {
    return Resource(
        url: 'nurse/uniform-fee',
        data: requestModel.toJson(),
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
