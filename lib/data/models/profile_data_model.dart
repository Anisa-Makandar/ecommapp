class UserDataModel {
  bool? status;
  String? message;
  UserData? data;

  UserDataModel(
      {required this.status, required this.data, required this.message});

  factory UserDataModel.fromJson(Map<String, dynamic> json) {
    return UserDataModel(
      status: json["status"] == "true" || json["status"] == true,
      message: json["message"],
      data: json["data"] != null
          ? UserData.fromJson((json["data"] as Map).cast<String, dynamic>())
          : null,
    );
  }
}

class UserData {
  String? id;
  String? name;
  String? email;
  String? mobile_number;
  String? password;
  String? image;

  ///might give error
  String? status;
  String? created_at;
  String? updated_at;
  UserData({
    required this.status,
    required this.id,
    required this.name,
    required this.image,
    required this.updated_at,
    required this.created_at,
    required this.email,
    required this.mobile_number,
    required this.password,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
        status: json["status"],
        id: json["id"],
        name: json["name"],
        image: json["image"],
        updated_at: json["updated_at"],
        created_at: json["created_at"],
        email: json["email"],
        mobile_number: json["mobile_number"],
        password: json["password"]);
  }
}
