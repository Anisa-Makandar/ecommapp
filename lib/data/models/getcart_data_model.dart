class ProductModel {
  int? id;
  String? image;
  String? name;
  String? price;
  int? quantity;

  ProductModel(
      {required this.id,
      required this.image,
      required this.name,
      required this.price,
      required this.quantity});
  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      image: json['image'],
      name: json['name'],
      price: json['price'],
      quantity: json['quantity'],
    );
  }
}

class OrderModel {
  int? id;
  String? total_amount;
  String? order_number;
  String? status;
  String? created_at;
  List<ProductModel>? product;

  OrderModel({
    required this.id,
    required this.total_amount,
    required this.order_number,
    required this.status,
    required this.created_at,
    required this.product,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    List<ProductModel> mProduct = [];
    for (Map<String, dynamic> eachProduct in json['product']) {
      mProduct.add(ProductModel.fromJson(eachProduct));
    }
    return OrderModel(
      id: json['id'],
      total_amount: json['total_amount'],
      order_number: json['order_number'],
      status: json['status'],
      created_at: json['created_at'],
      product: mProduct,
    );
  }
}

class GetOrderDataModel {
  String? message;
  bool? status;
  List<OrderModel>? orders;
  GetOrderDataModel(
      {required this.message, required this.status, required this.orders});
  factory GetOrderDataModel.fromJson(Map<String, dynamic> json) {
    List<OrderModel> mOrders = [];
    for (Map<String, dynamic> eachGetcart in json['orders']) {
      mOrders.add(OrderModel.fromJson(eachGetcart));
    }
    return GetOrderDataModel(
      message: json['message'],
      status: json['status'],
      orders: mOrders,
    );
  }
}
