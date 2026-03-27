class FlatSearch {
  FlatSearch({
     this.success,
     this.count,
     this.data,
  });

  final bool? success;
  final Count? count;
  final FlatData? data;

  factory FlatSearch.fromJson(Map<String, dynamic> json){
    return FlatSearch(
      success: json["success"],
      count: json["count"] == null ? null : Count.fromJson(json["count"]),
      data: json["data"] == null ? null : FlatData.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "count": count?.toJson(),
    "data": data?.toJson(),
  };

}

class Count {
  Count({
    required this.tenants,
    required this.owners,
    required this.total,
  });

  final int? tenants;
  final int? owners;
  final int? total;

  factory Count.fromJson(Map<String, dynamic> json){
    return Count(
      tenants: json["tenants"],
      owners: json["owners"],
      total: json["total"],
    );
  }

  Map<String, dynamic> toJson() => {
    "tenants": tenants,
    "owners": owners,
    "total": total,
  };

}

class FlatData {
  FlatData({
    required this.tenants,
    required this.owners,
  });

  final List<Owner> tenants;
  final List<Owner> owners;

  factory FlatData.fromJson(Map<String, dynamic> json){
    return FlatData(
      tenants: json["tenants"] == null ? [] : List<Owner>.from(json["tenants"]!.map((x) => Owner.fromJson(x))),
      owners: json["owners"] == null ? [] : List<Owner>.from(json["owners"]!.map((x) => Owner.fromJson(x))),
    );
  }

  Map<String, dynamic> toJson() => {
    "tenants": tenants.map((x) => x?.toJson()).toList(),
    "owners": owners.map((x) => x?.toJson()).toList(),
  };

}

class Owner {
  Owner({
    required this.ownerId,
    required this.firstName,
    required this.phone,
    required this.block,
    required this.floor,
    required this.flat,
    required this.role,
    required this.tenantId,
  });

  final String? ownerId;
  final String? firstName;
  final String? phone;
  final String? block;
  final String? floor;
  final String? flat;
  final String? role;
  final String? tenantId;

  factory Owner.fromJson(Map<String, dynamic> json){
    return Owner(
      ownerId: json["ownerId"],
      firstName: json["firstName"],
      phone: json["phone"],
      block: json["block"],
      floor: json["floor"],
      flat: json["flat"],
      role: json["role"],
      tenantId: json["tenantId"],
    );
  }

  Map<String, dynamic> toJson() => {
    "ownerId": ownerId,
    "firstName": firstName,
    "phone": phone,
    "block": block,
    "floor": floor,
    "flat": flat,
    "role": role,
    "tenantId": tenantId,
  };

}
