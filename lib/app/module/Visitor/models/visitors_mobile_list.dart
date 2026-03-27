class VisitorsMobileSearch {
  VisitorsMobileSearch({
     this.success,
     this.count,
     this.data,
  });

  final bool? success;
  final int? count;
  final List<VisitorsMobile>? data;

  factory VisitorsMobileSearch.fromJson(Map<String, dynamic> json){
    return VisitorsMobileSearch(
      success: json["success"],
      count: json["count"],
      data: json["data"] == null ? [] : List<VisitorsMobile>.from(json["data"]!.map((x) => VisitorsMobile.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count,
    "data": data?.map((x) => x?.toJson()).toList(),
  };

}

class VisitorsMobile {
  VisitorsMobile({
    required this.id,
    required this.communityId,
    required this.visitorId,
    required this.name,
    required this.phone,
    required this.noOfPersons,
    required this.vehicleNo,
    required this.units,
    required this.visitorImage,
    required this.guardName,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.phoneStr,
  });

  final String? id;
  final String? communityId;
  final String? visitorId;
  final String? name;
  final int? phone;
  final int? noOfPersons;
  final String? vehicleNo;
  final List<Unit> units;
  final dynamic visitorImage;
  final String? guardName;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? phoneStr;

  factory VisitorsMobile.fromJson(Map<String, dynamic> json){
    return VisitorsMobile(
      id: json["_id"],
      communityId: json["communityId"],
      visitorId: json["visitorId"],
      name: json["name"],
      phone: json["phone"],
      noOfPersons: json["noOfPersons"],
      vehicleNo: json["vehicleNo"],
      units: json["units"] == null ? [] : List<Unit>.from(json["units"]!.map((x) => Unit.fromJson(x))),
      visitorImage: json["visitorImage"],
      guardName: json["guardName"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      phoneStr: json["phoneStr"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "communityId": communityId,
    "visitorId": visitorId,
    "name": name,
    "phone": phone,
    "noOfPersons": noOfPersons,
    "vehicleNo": vehicleNo,
    "units": units.map((x) => x?.toJson()).toList(),
    "visitorImage": visitorImage,
    "guardName": guardName,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "phoneStr": phoneStr,
  };

}

class Unit {
  Unit({
    required this.tenantId,
    required this.ownerId,
    required this.block,
    required this.floor,
    required this.flat,
    required this.status,
    required this.id,
  });

  final String? tenantId;
  final String? ownerId;
  final String? block;
  final String? floor;
  final String? flat;
  final String? status;
  final String? id;

  factory Unit.fromJson(Map<String, dynamic> json){
    return Unit(
      tenantId: json["tenantId"],
      ownerId: json["ownerId"],
      block: json["block"],
      floor: json["floor"],
      flat: json["flat"],
      status: json["status"],
      id: json["_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "tenantId": tenantId,
    "ownerId": ownerId,
    "block": block,
    "floor": floor,
    "flat": flat,
    "status": status,
    "_id": id,
  };

}
