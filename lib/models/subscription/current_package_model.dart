class CurrentPackage {
  int? id;
  String? name;
  String? description;
  String? price;
  String? remainingDuration;
  String? dueDate;

  CurrentPackage(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.remainingDuration,
      this.dueDate});

  CurrentPackage.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    remainingDuration = json['remaining_duration'];
    dueDate = json['due_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['remaining_duration'] = this.remainingDuration;
    data['due_date'] = this.dueDate;
    return data;
  }
}