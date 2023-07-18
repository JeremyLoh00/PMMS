import 'package:private_nurse_for_client/models/division/division_response_model.dart';
import 'package:private_nurse_for_client/resource/division_resource.dart';
import 'package:private_nurse_for_client/services/web_services.dart';

class DivisionBloc {
  Future<DivisionResponseModel> getDivisionList() async {
    return await WebService.get(
      DivisionResource.getDivisionList(),
    );
  }
}
