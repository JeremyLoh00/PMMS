import 'dart:convert';

import 'package:private_nurse_for_client/models/job/job_model.dart';
import 'package:private_nurse_for_client/models/job/job_store_response_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class JobResource {
  static Resource storeJob(JobModel jobModel) {
    return Resource(
        url: 'item/item',
        data: jobModel.toJson(),
        parse: (response) {
          return JobStoreResponseModel(json.decode(response.body));
        });
  }
}