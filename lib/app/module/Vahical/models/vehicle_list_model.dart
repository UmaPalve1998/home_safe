class VehicleListModel {
  VehicleListModel({
     this.success,
     this.page,
     this.limit,
     this.total,
     this.totalPages,
     this.stats,
     this.data,
  });

  final bool? success;
  final int? page;
  final int? limit;
  final int? total;
  final int? totalPages;
  final Stats? stats;
  final List<Vehicle>? data;

  factory VehicleListModel.fromJson(Map<String, dynamic> json){
    return VehicleListModel(
      success: json["success"],
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      totalPages: json["totalPages"],
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      data: json["data"] == null ? [] : List<Vehicle>.from(json["data"]!.map((x) => Vehicle.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "page": page,
    "limit": limit,
    "total": total,
    "totalPages": totalPages,
    "stats": stats?.toJson(),
    "data": data?.map((x) => x?.toJson()).toList(),
  };

}

class Vehicle {
  Vehicle({
    required this.id,
    required this.communityId,
    required this.vehicleInOutId,
    required this.tenantId,
    required this.vehicleNo,
    required this.name,
    required this.phone,
    required this.block,
    required this.floor,
    required this.flat,
    required this.guardName,
    required this.time,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.ownerId,
    required this.inTime,
  });

  final String? id;
  final String? communityId;
  final String? vehicleInOutId;
  final String? tenantId;
  final String? vehicleNo;
  final String? name;
  final int? phone;
  final String? block;
  final String? floor;
  final String? flat;
  final String? guardName;
  final DateTime? time;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? ownerId;
  final DateTime? inTime;

  factory Vehicle.fromJson(Map<String, dynamic> json){
    return Vehicle(
      id: json["_id"],
      communityId: json["communityId"],
      vehicleInOutId: json["vehicleInOutId"],
      tenantId: json["tenantId"],
      vehicleNo: json["vehicleNo"],
      name: json["name"],
      phone: json["phone"],
      block: json["block"],
      floor: json["floor"],
      flat: json["flat"],
      guardName: json["guardName"],
      time: DateTime.tryParse(json["time"] ?? ""),
      status: json["status"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      ownerId: json["ownerId"],
      inTime: DateTime.tryParse(json["inTime"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "communityId": communityId,
    "vehicleInOutId": vehicleInOutId,
    "tenantId": tenantId,
    "vehicleNo": vehicleNo,
    "name": name,
    "phone": phone,
    "block": block,
    "floor": floor,
    "flat": flat,
    "guardName": guardName,
    "time": time?.toIso8601String(),
    "status": status,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "ownerId": ownerId,
    "inTime": inTime?.toIso8601String(),
  };

}

class Stats {
  Stats({
    required this.id,
    required this.totalRecords,
    required this.totalIn,
    required this.totalOut,
  });

  final dynamic id;
  final int? totalRecords;
  final int? totalIn;
  final int? totalOut;

  factory Stats.fromJson(Map<String, dynamic> json){
    return Stats(
      id: json["_id"],
      totalRecords: json["totalRecords"],
      totalIn: json["totalIn"],
      totalOut: json["totalOut"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "totalRecords": totalRecords,
    "totalIn": totalIn,
    "totalOut": totalOut,
  };

}
