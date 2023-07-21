import 'dart:convert';

import 'package:private_nurse_for_client/models/user/list_user_response_model.dart';
import 'package:private_nurse_for_client/models/nurse/nurse_filter_request_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class NurseResource {
  static Resource getListNurseHistory(
      NurseFilterRequestModel nurseHistoryFilterRequestModel) {
    return Resource(
        url: 'client/nurse-history',
        params: {
          // Calculate number page based on offset and take
          'page': ((nurseHistoryFilterRequestModel.page! /
                      nurseHistoryFilterRequestModel.take!) +
                  1)
              .toInt()
              .toString(),
          'take': nurseHistoryFilterRequestModel.take.toString(),
        },
        parse: (response) {
          return ListUserResponseModel(json.decode(response.body));
        });
  }

  static Resource getListNurseBlocked(
      NurseFilterRequestModel nurseFilterRequestModel) {
    return Resource(
        url: 'client/blocked-nurse',
        params: {
          // Calculate number page based on offset and take
          'page':
              ((nurseFilterRequestModel.page! / nurseFilterRequestModel.take!) +
                      1)
                  .toInt()
                  .toString(),
          'take': nurseFilterRequestModel.take.toString(),
        },
        parse: (response) {
          return ListUserResponseModel(json.decode(response.body));
        });
  }
}
