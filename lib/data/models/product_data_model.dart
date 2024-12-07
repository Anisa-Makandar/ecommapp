class DataModel {
  String? id;
  String? name;
  String? price;
  String? image;
  String? category_id;
  String? status;
  String? created_at;
  String? updated_at;

  DataModel(
      {required this.id,
      required this.name,
      required this.price,
      required this.image,
      required this.category_id,
      required this.status,
      required this.created_at,
      required this.updated_at});
  factory DataModel.fromJson(Map<String, dynamic> json) {
    return DataModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      image: json['image'],
      category_id: json['category_id'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

class ProductDataModel {
  bool? status;
  String? message;
  List<DataModel>? data;
  ProductDataModel(
      {required this.status, required this.message, required this.data});
  factory ProductDataModel.fromJson(Map<String, dynamic> json) {
    List<DataModel> mData = [];
    for (Map<String, dynamic> eachData in json['data']) {
      mData.add(DataModel.fromJson(eachData));
    }
    return ProductDataModel(
      status: json['status'],
      message: json['message'],
      data: mData,
    );
  }
}
