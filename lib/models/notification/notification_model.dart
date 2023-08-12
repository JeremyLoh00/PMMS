class NotificationModel {
  String? id;
  String? body;
  String? icon;
  String? iconColor;
  String? title;
  String? routeName;
  String? createdAt;

  NotificationModel(
      {this.id,
      this.body,
      this.icon,
      this.iconColor,
      this.title,
      this.routeName,
      this.createdAt});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    body = json['body'];
    icon = json['icon'];
    iconColor = json['icon_color'];
    title = json['title'];
    routeName = json['route_name'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['body'] = this.body;
    data['icon'] = this.icon;
    data['icon_color'] = this.iconColor;
    data['title'] = this.title;
    data['route_name'] = this.routeName;
    data['created_at'] = this.createdAt;
    return data;
  }
}
