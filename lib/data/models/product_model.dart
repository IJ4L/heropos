import 'dart:convert';

ProductModel productModelFromJson(String str) =>
    ProductModel.fromJson(json.decode(str));

String productModelToJson(ProductModel data) => json.encode(data.toJson());

class ProductModel {
  String nameOfProduct;
  String priceOfProduct;
  String imgOfProduct;
  int quantity;

  ProductModel({
    required this.nameOfProduct,
    required this.priceOfProduct,
    this.quantity = 1,
    required this.imgOfProduct,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ProductModel &&
        other.nameOfProduct == nameOfProduct &&
        other.priceOfProduct == priceOfProduct;
  }

  @override
  int get hashCode => nameOfProduct.hashCode ^ priceOfProduct.hashCode;

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        nameOfProduct: json["name_of_product"],
        priceOfProduct: json["price_of_product"],
        quantity: json["quantity"],
        imgOfProduct: json["quantity"],
      );

  Map<String, dynamic> toJson() => {
        "name_of_product": nameOfProduct,
        "price_of_product": priceOfProduct,
        "quantity": quantity,
        "img_of_product": imgOfProduct,
      };
}
