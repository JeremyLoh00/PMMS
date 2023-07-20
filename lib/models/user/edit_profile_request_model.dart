import 'package:image_picker/image_picker.dart';

class EditProfileRequestModel {
  XFile? photoPath;

  String? address;
  String? phoneNo;
  String? name;
  String? email;
  String? ic;
  String? gender;
  String? bank;
  String? account;

  EditProfileRequestModel({
    this.photoPath,
    this.address,
    this.phoneNo,
    this.name,
    this.email,
    this.ic,
    this.gender,
    this.bank,
    this.account,
  });

  EditProfileRequestModel.fromJson(Map<String, dynamic> json) {
    address = json['user[address]'];
    phoneNo = json['user[phone_no]'];
    email = json['user[email]'];
    name = json['user[name]'];
    ic = json['user[ic]'];
    gender = json['user[gender]'];
    bank = json['user[bank]'];
    account = json['user[account]'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, String>();

    data['user[address]'] = this.address!;
    data['user[phone_no]'] = this.phoneNo!;
    data['user[name]'] = this.name!;
    data['user[email]'] = this.email!;
    data['user[ic]'] = this.ic!;
    data['user[gender]'] = this.gender!;
    data['user[bank]'] = this.bank!;
    data['user[account]'] = this.account!;
    return data;
  }
}
