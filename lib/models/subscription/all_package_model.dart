class AllPackageModel {
  int? id;
  String? name;
  String? description;
  String? price;
  String? monthlyPrice;

  AllPackageModel(
      {this.id, this.name, this.description, this.price, this.monthlyPrice});

  AllPackageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    monthlyPrice = json['monthly_price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['monthly_price'] = this.price;
    return data;
  }
}
