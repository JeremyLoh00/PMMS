class ChangePasswordRequestModel {
  String? password;
  String? passwordConfirmation;
  String? currentPassword;

  ChangePasswordRequestModel({
    this.password,
    this.passwordConfirmation,
    this.currentPassword,
  });

  ChangePasswordRequestModel.fromJson(Map<String, dynamic> json) {
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    currentPassword = json['current_password'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['password'] = this.password;
    data['password_confirmation'] = this.passwordConfirmation;
    data['current_password'] = this.currentPassword;
    return data;
  }
}