class LoginResponse {
  final bool? success;
  final String? role;
  final String? communityId;
  final String? accessToken;
  final String? refreshToken;
  final String? message;
  final User? user;

  LoginResponse({
    this.success,
    this.role,
    this.communityId,
    this.accessToken,
    this.refreshToken,
    this.message,
    this.user,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json){
    return LoginResponse(
      success: json["success"]??false,
      role: json["role"],
      communityId: json["communityId"],
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      message: json["message"],
      user: json["user"] == null ? null : User.fromJson(json["user"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "role": role,
    "communityId": communityId,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
    "message": message,
    "user": user?.toJson(),
  };

}

class User {
  final String? role;
  final String? communityId;
  final dynamic adminId;
  final dynamic ownerId;
  final dynamic tenantId;
  final String? comUserId;
  final dynamic uniqId;

  User({
    this.role,
    this.communityId,
    this.adminId,
    this.ownerId,
    this.tenantId,
    this.comUserId,
    this.uniqId,
  });

  factory User.fromJson(Map<String, dynamic> json){
    return User(
      role: json["role"],
      communityId: json["communityId"],
      adminId: json["adminId"],
      ownerId: json["ownerId"],
      tenantId: json["tenantId"],
      comUserId: json["comUserId"],
      uniqId: json["uniqId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "role": role,
    "communityId": communityId,
    "adminId": adminId,
    "ownerId": ownerId,
    "tenantId": tenantId,
    "comUserId": comUserId,
    "uniqId": uniqId,
  };

}