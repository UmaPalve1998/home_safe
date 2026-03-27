class IncidentListModel {
  IncidentListModel({
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
  final List<Incident>? data;

  factory IncidentListModel.fromJson(Map<String, dynamic> json){
    return IncidentListModel(
      success: json["success"],
      page: json["page"],
      limit: json["limit"],
      total: json["total"],
      stats: json["stats"] == null ? null : Stats.fromJson(json["stats"]),
      data: json["data"] == null ? [] : List<Incident>.from(json["data"]!.map((x) => Incident.fromJson(x))),
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

class Incident {
  Incident({
    required this.id,
    required this.communityId,
    required this.incidentId,
    required this.incidentType,
    required this.subject,
    required this.description,
    required this.priority,
    required this.status,
    required this.images,
    required this.date,
    required this.incidentTime,
    required this.guard,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.updateTime,
    required this.closeTime,
  });

  final String? id;
  final String? communityId;
  final String? incidentId;
  final String? incidentType;
  final String? subject;
  final String? description;
  final String? priority;
  final String? status;
  final List<String> images;
  final DateTime? date;
  final DateTime? incidentTime;
  final String? guard;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final DateTime? updateTime;
  final DateTime? closeTime;

  factory Incident.fromJson(Map<String, dynamic> json){
    return Incident(
      id: json["_id"],
      communityId: json["communityId"],
      incidentId: json["incidentId"],
      incidentType: json["incidentType"],
      subject: json["subject"],
      description: json["description"],
      priority: json["priority"],
      status: json["status"],
      images: json["images"] == null ? [] : List<String>.from(json["images"]!.map((x) => x)),
      date: DateTime.tryParse(json["date"] ?? ""),
      incidentTime: DateTime.tryParse(json["incidentTime"] ?? ""),
      guard: json["guard"],
      createdAt: DateTime.tryParse(json["createdAt"] ?? ""),
      updatedAt: DateTime.tryParse(json["updatedAt"] ?? ""),
      v: json["__v"],
      updateTime: DateTime.tryParse(json["updateTime"] ?? ""),
      closeTime: DateTime.tryParse(json["closeTime"] ?? ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "communityId": communityId,
    "incidentId": incidentId,
    "incidentType": incidentType,
    "subject": subject,
    "description": description,
    "priority": priority,
    "status": status,
    "images": images.map((x) => x).toList(),
    "date": date?.toIso8601String(),
    "incidentTime": incidentTime?.toIso8601String(),
    "guard": guard,
    "createdAt": createdAt?.toIso8601String(),
    "updatedAt": updatedAt?.toIso8601String(),
    "__v": v,
    "updateTime": updateTime?.toIso8601String(),
    "closeTime": closeTime?.toIso8601String(),
  };

}

class Stats {
  Stats({
    required this.id,
    required this.total,
    required this.open,
    required this.inProgress,
    required this.closed,
    required this.cancelled,
  });

  final dynamic id;
  final int? total;
  final int? open;
  final int? inProgress;
  final int? closed;
  final int? cancelled;

  factory Stats.fromJson(Map<String, dynamic> json){
    return Stats(
      id: json["_id"],
      total: json["total"],
      open: json["open"],
      inProgress: json["inProgress"],
      closed: json["closed"],
      cancelled: json["cancelled"],
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "total": total,
    "open": open,
    "inProgress": inProgress,
    "closed": closed,
    "cancelled": cancelled,
  };

}
