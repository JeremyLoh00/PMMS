import 'dart:convert';

import 'package:private_nurse_for_client/models/default_response_model.dart';
import 'package:private_nurse_for_client/models/job/list_job_response_model.dart';
import 'package:private_nurse_for_client/models/job_filter_request/job_filter_request_model.dart';
import 'package:private_nurse_for_client/services/resource.dart';

class JobResource {
  static Resource getListJobs(JobFilterRequestModel jobFilterRequestModel) {
    return Resource(
        url: 'nurse/jobs',
        params: {
          // Calculate number page based on offset and take
          'page':
              ((jobFilterRequestModel.page! / jobFilterRequestModel.take!) + 1)
                  .toInt()
                  .toString(),
          'take': jobFilterRequestModel.take.toString(),

          'tab': jobFilterRequestModel.tab.toString(),
          if (jobFilterRequestModel.cityId != null)
            'city_id': jobFilterRequestModel.cityId.toString(),
          if (jobFilterRequestModel.divisionId != null)
            'division_id': jobFilterRequestModel.divisionId.toString(),
        },
        parse: (response) {
          return ListJobResponseModel(json.decode(response.body));
        });
  }

  static Resource applyJob(int jobId) {
    return Resource(
        url: 'nurse/jobs/$jobId/apply-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource completeJob(int jobId) {
    return Resource(
        url: 'nurse/jobs/$jobId/complete-jobs',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }

  static Resource generateBillPayment() {
    return Resource(
        url: 'nurse/generate-bill/uniform-fee',
        parse: (response) {
          return DefaultResponseModel(json.decode(response.body));
        });
  }
}
