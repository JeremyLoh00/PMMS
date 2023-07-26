import 'dart:convert';

import 'package:private_nurse_for_client/models/service/service_filter_model.dart';
import 'package:private_nurse_for_client/models/service/service_list_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class ServiceResource {
  static Resource getServiceList(ServiceFilterModel serviceFilterModel) {
    return Resource(
        url: 'services',
        // Example
        // data: {
        //   'key': "value",
        // },
        params: {
          // Calculate number page based on offset and take
          'page': ((serviceFilterModel.page! / serviceFilterModel.take!) + 1)
              .toInt()
              .toString(),
          'take': serviceFilterModel.take.toString(),
          if (serviceFilterModel.query != null)
            'search': serviceFilterModel.query,
        },
        parse: (response) {
          return ServiceListResponseModel(json.decode(response.body));
        });
  }
}
