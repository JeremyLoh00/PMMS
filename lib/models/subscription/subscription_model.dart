import 'package:private_nurse_for_client/models/subscription/all_package_model.dart';
import 'package:private_nurse_for_client/models/subscription/current_package_model.dart';

class SubscriptionModel {
  bool? isSubscribe;
  CurrentPackage? currentPackage;
  List<AllPackageModel>? allPackages;

  SubscriptionModel({this.isSubscribe, this.currentPackage, this.allPackages});

  SubscriptionModel.fromJson(Map<String, dynamic> json) {
    isSubscribe = json['is_subscribe'];
    currentPackage = json['current_package'] != null
        ? new CurrentPackage.fromJson(json['current_package'])
        : null;
    if (json['all_packages'] != null) {
      allPackages = <AllPackageModel>[];
      json['all_packages'].forEach((v) {
        allPackages!.add(new AllPackageModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['is_subscribe'] = this.isSubscribe;
     if (this.currentPackage != null) {
      data['current_package'] = this.currentPackage!.toJson();
    }
    if (this.allPackages != null) {
      data['all_packages'] = this.allPackages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

