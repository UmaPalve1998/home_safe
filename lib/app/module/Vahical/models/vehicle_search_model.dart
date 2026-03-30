class VehicleSearchModel {
  VehicleSearchModel({
     this.success,
     this.count,
     this.data,
  });

  final bool? success;
  final int? count;
  final List<Datum>? data;

  factory VehicleSearchModel.fromJson(Map<String, dynamic> json){
    return VehicleSearchModel(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": data?.map((x) => x?.toJson()).toList(),
  };

}

class Datum {
  Datum({
    required this.userType,
    required this.ownerId,
    required this.name,
    required this.phone,
    required this.flat,
    required this.block,
    required this.floor,
    required this.vehicleNo,
    required this.vehicleType,
    required this.vehicleModel,
    required this.vehicleColor,
  });

  final String? userType;
  final String? ownerId;
  final String? name;
  final String? phone;
  final String? flat;
  final String? block;
  final String? floor;
  final String? vehicleNo;
  final String? vehicleType;
  final String? vehicleModel;
  final String? vehicleColor;

  factory Datum.fromJson(Map<String, dynamic> json){
    return Datum(
      userType: json["userType"],
      ownerId: json["ownerId"],
      name: json["name"],
      phone: json["phone"],
      flat: json["flat"],
      block: json["block"],
      floor: json["floor"],
      vehicleNo: json["vehicleNo"],
      vehicleType: json["vehicleType"],
      vehicleModel: json["vehicleModel"],
      vehicleColor: json["vehicleColor"],
    );
  }

  Map<String, dynamic> toJson() => {
    "userType": userType,
    "ownerId": ownerId,
    "name": name,
    "phone": phone,
    "flat": flat,
    "block": block,
    "floor": floor,
    "vehicleNo": vehicleNo,
    "vehicleType": vehicleType,
    "vehicleModel": vehicleModel,
    "vehicleColor": vehicleColor,
  };

}
