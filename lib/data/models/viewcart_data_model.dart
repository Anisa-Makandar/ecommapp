class CartModel {
  int? id;
  String? image;
  String? name;
  String? price;
  int? product_id;
  int? quantity;
  CartModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.product_id,
      required this.quantity});
  factory CartModel.fromJson(Map<String, dynamic> json) {
    return CartModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      product_id: json['product_id'],
      quantity: json['quantity'],
    );
  }
}

class CartDataModel {
  String? message;
  bool? status;
  List<CartModel>? data;
  CartDataModel(
      {required this.data, required this.message, required this.status});
  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    List<CartModel> mCart = [];
    for (Map<String, dynamic> eachCart in json['data']) {
      mCart.add(CartModel.fromJson(eachCart));
    }
    return CartDataModel(
      data: mCart,
      message: json['message'],
      status: json['status'],
    );
  }
}
