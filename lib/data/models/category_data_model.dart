class CategoryModel {
  String? id;
  String? name;
  String? status;
  String? created_at;
  String? updated_at;
  CategoryModel(
      {required this.id,
      required this.name,
      required this.status,
      required this.created_at,
      required this.updated_at});
  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      name: json['name'],
      status: json['status'],
      created_at: json['created_at'],
      updated_at: json['updated_at'],
    );
  }
}

class CategoryDataModel {
  bool? status;
  String? message;
  List<CategoryModel>? data;
  CategoryDataModel(
      {required this.status, required this.message, required this.data});
  factory CategoryDataModel.fromJson(Map<String, dynamic> json) {
    List<CategoryModel> mCategory = [];
    for (Map<String, dynamic> eachCategory in json['data']) {
      mCategory.add(CategoryModel.fromJson(eachCategory));
    }
    return CategoryDataModel(
      status: json['status'],
      message: json['message'],
      data: mCategory,
    );
  }
}
