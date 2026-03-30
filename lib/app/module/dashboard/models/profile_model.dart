class ProfileModel {
  ProfileModel({
     this.success,
     this.data,
  });

  final bool? success;
  final ProfileData? data;

  factory ProfileModel.fromJson(Map<String, dynamic> json){
    return ProfileModel(
      success: json["success"],
      data: json["data"] == null ? null : ProfileData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data?.toJson(),
  };

}

class ProfileData {
  ProfileData({
    required this.communityId,
    required this.comUserId,
    required this.name,
    required this.phone,
    required this.userId,
    required this.role,
    required this.isActive,
    required this.isDeleted,
    required this.createdAt,
    required this.updatedAt,
  });

  final String? communityId;
  final String? comUserId;
  final String? name;
  final int? phone;
  final String? userId;
  final String? role;
  final bool? isActive;
  final bool? isDeleted;
  final String? createdAt;
  final String? updatedAt;

  factory ProfileData.fromJson(Map<String, dynamic> json){
    return ProfileData(
      communityId: json["communityId"],
      comUserId: json["comUserId"],
      name: json["name"],
      phone: json["phone"],
      userId: json["userId"],
      role: json["role"],
      isActive: json["isActive"],
      isDeleted: json["isDeleted"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
    "communityId": communityId,
    "comUserId": comUserId,
    "name": name,
    "phone": phone,
    "userId": userId,
    "role": role,
    "isActive": isActive,
    "isDeleted": isDeleted,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
  };

}
