class KidsListModel {
  KidsListModel({
     this.success,
     this.page,
     this.limit,
     this.total,
     this.stats,
     this.data,
  });

  final bool? success;
  final int? page;
  final int? limit;
  final int? total;
  final Stats? stats;
  final List<Kids>? data;

  factory KidsListModel.fromJson(Map<String, dynamic> json){
    return KidsListModel(
      success: json["success"],
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      data: json["data"] == null ? [] : List<Kids>.from(json["data"]!.map((x) => Kids.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "page": page,
    "limit": limit,
    "total": total,
    "stats": stats?.toJson(),
    "data": data?.map((x) => x?.toJson()).toList(),
  };

}

class Kids {
  Kids({
    required this.id,
    required this.communityId,
    required this.kidsInOutId,
    required this.tenantId,
    required this.name,
    required this.age,
    required this.gender,
    required this.parentName,
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
  });

  final String? id;
  final String? communityId;
  final String? kidsInOutId;
  final String? tenantId;
  final String? name;
  final String? age;
  final String? gender;
  final String? parentName;
  final int? phone;
  final String? block;
  final String? floor;
  final String? flat;
  final String? guardName;
  final String? time;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? ownerId;

  factory Kids.fromJson(Map<String, dynamic> json){
    return Kids(
      id: json["_id"],
      communityId: json["communityId"],
      kidsInOutId: json["kidsInOutId"],
      tenantId: json["tenantId"],
      name: json["name"],
      age: json["age"],
      gender: json["gender"],
      parentName: json["parentName"],
      phone: json["phone"],
      block: json["block"],
      floor: json["floor"],
      flat: json["flat"],
      guardName: json["guardName"],
      time: json["time"],
      status: json["status"],
      createdAt: json["createdAt"],
      updatedAt: json["updatedAt"],
      v: json["__v"],
      ownerId: json["ownerId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "communityId": communityId,
    "kidsInOutId": kidsInOutId,
    "tenantId": tenantId,
    "name": name,
    "age": age,
    "gender": gender,
    "parentName": parentName,
    "phone": phone,
    "block": block,
    "floor": floor,
    "flat": flat,
    "guardName": guardName,
    "time": time,
    "status": status,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "__v": v,
    "ownerId": ownerId,
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
