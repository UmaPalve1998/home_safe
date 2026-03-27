class VisitorsListModel {
  VisitorsListModel({
     this.success,
     this.data,
     this.pagination,
     this.statistics,
  });

  final bool? success;
  final List<Visitora>? data;
  final Pagination? pagination;
  final Statistics? statistics;

  factory VisitorsListModel.fromJson(Map<String, dynamic> json){
    return VisitorsListModel(
      success: json["success"],
      data: json["data"] == null ? [] : List<Visitora>.from(json["data"]!.map((x) => Visitora.fromJson(x))),
      pagination: json["pagination"] == null ? null : Pagination.fromJson(json["pagination"]),
      statistics: json["statistics"] == null ? null : Statistics.fromJson(json["statistics"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data != null ? data!.map((x) => x?.toJson()).toList(): null,
    "pagination": pagination?.toJson(),
    "statistics": statistics?.toJson(),
  };

}

class Visitora {
  Visitora({
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
  });

  final String? communityId;
  final String? visitorId;
  final String? name;
  final int? phone;
  final int? noOfPersons;
  final String? vehicleNo;
  final List<Unit> units;
  final String? visitorImage;
  final String? guardName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  factory Visitora.fromJson(Map<String, dynamic> json){
    return Visitora(
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
    );
  }

  Map<String, dynamic> toJson() => {
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
    required this.inStatus,
    required this.inTime,
    required this.outTime,
  });

  final String? tenantId;
  final String? ownerId;
  final String? block;
  final String? floor;
  final String? flat;
  final String? status;
  final String? id;
  final String? inStatus;
  final DateTime? inTime;
  final DateTime? outTime;

  factory Unit.fromJson(Map<String, dynamic> json){
    return Unit(
      tenantId: json["tenantId"],
      ownerId: json["ownerId"],
      block: json["block"],
      floor: json["floor"],
      flat: json["flat"],
      status: json["status"],
      id: json["_id"],
      inStatus: json["inStatus"],
      inTime: DateTime.tryParse(json["inTime"] ?? ""),
      outTime: DateTime.tryParse(json["outTime"] ?? ""),
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
    "inStatus": inStatus,
    "inTime": inTime?.toIso8601String(),
    "outTime": outTime?.toIso8601String(),
  };

}

class Pagination {
  Pagination({
    required this.total,
    required this.page,
    required this.limit,
    required this.totalPages,
  });

  final int? total;
  final int? page;
  final int? limit;
  final dynamic totalPages;

  factory Pagination.fromJson(Map<String, dynamic> json){
    return Pagination(
      total: json["total"],
      page: json["page"],
      limit: json["limit"],
      totalPages: json["totalPages"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "page": page,
    "limit": limit,
    "totalPages": totalPages,
  };

}

class Statistics {
  Statistics({
    required this.totalVisitors,
    required this.inVisitors,
    required this.outVisitors,
    required this.returnVisitors,
    required this.nightStay,
  });

  final int? totalVisitors;
  final int? inVisitors;
  final int? outVisitors;
  final int? returnVisitors;
  final int? nightStay;

  factory Statistics.fromJson(Map<String, dynamic> json){
    return Statistics(
      totalVisitors: json["totalVisitors"],
      inVisitors: json["inVisitors"],
      outVisitors: json["outVisitors"],
      returnVisitors: json["returnVisitors"],
      nightStay: json["nightStay"],
    );
  }

  Map<String, dynamic> toJson() => {
    "totalVisitors": totalVisitors,
    "inVisitors": inVisitors,
    "outVisitors": outVisitors,
    "returnVisitors": returnVisitors,
    "nightStay": nightStay,
  };

}
