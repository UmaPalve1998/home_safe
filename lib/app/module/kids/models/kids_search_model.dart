class KidsSearchModel {
    KidsSearchModel({
         this.success,
         this.data,
    });

    final bool? success;
    final KidsSearchData? data;

    factory KidsSearchModel.fromJson(Map<String, dynamic> json){
        return KidsSearchModel(
            success: json["success"],
            data: json["data"] == null ? null : KidsSearchData.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data?.toJson(),
    };

}

class KidsSearchData {
    KidsSearchData({
        required this.userType,
        required this.tenantId,
        required this.ownerId,
        required this.firstName,
        required this.phone,
        required this.block,
        required this.floor,
        required this.flat,
        required this.residents,
    });

    final String? userType;
    final String? tenantId;
    final String? ownerId;
    final String? firstName;
    final String? phone;
    final String? block;
    final String? floor;
    final String? flat;
    final List<Resident> residents;

    factory KidsSearchData.fromJson(Map<String, dynamic> json){
        return KidsSearchData(
            userType: json["userType"],
            tenantId: json["tenantId"],
            ownerId: json["ownerId"],
            firstName: json["firstName"],
            phone: json["phone"],
            block: json["block"],
            floor: json["floor"],
            flat: json["flat"],
            residents: json["residents"] == null ? [] : List<Resident>.from(json["residents"]!.map((x) => Resident.fromJson(x))),
        );
    }

    Map<String, dynamic> toJson() => {
        "userType": userType,
        "tenantId": tenantId,
        "ownerId": ownerId,
        "firstName": firstName,
        "phone": phone,
        "block": block,
        "floor": floor,
        "flat": flat,
        "residents": residents.map((x) => x?.toJson()).toList(),
    };

}

class Resident {
    Resident({
        required this.residentId,
        required this.name,
        required this.age,
        required this.gender,
        required this.type,
        required this.mobile,
        required this.residentImage,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
    });

    final String? residentId;
    final String? name;
    final int? age;
    final String? gender;
    final String? type;
    final String? mobile;
    final String? residentImage;
    final String? id;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    factory Resident.fromJson(Map<String, dynamic> json){
        return Resident(
            residentId: json["residentId"],
            name: json["name"],
            age: json["age"],
            gender: json["gender"],
            type: json["type"],
            mobile: json["mobile"],
            residentImage: json["residentImage"],
            id: json["_id"],
            createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
            updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
        );
    }

    Map<String, dynamic> toJson() => {
        "residentId": residentId,
        "name": name,
        "age": age,
        "gender": gender,
        "type": type,
        "mobile": mobile,
        "residentImage": residentImage,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
    };

}
