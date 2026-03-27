class GuardDashbord {
  GuardDashbord({
     this.success,
     this.date,
     this.data,
  });

  final bool? success;
  final DateTime? date;
  final Data? data;

  factory GuardDashbord.fromJson(Map<String, dynamic> json){
    return GuardDashbord(
      success: json["success"],
      date: DateTime.tryParse(json["date"] ?? ""),
      data: json["data"] == null ? null : Data.fromJson(json["data"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "date": date?.toIso8601String(),
    "data": data?.toJson(),
  };

}

class Data {
  Data({
    required this.visitors,
    required this.vehicles,
    required this.kids,
    required this.incidents,
  });

  final Visitors? visitors;
  final Kids? vehicles;
  final Kids? kids;
  final Incidents? incidents;

  factory Data.fromJson(Map<String, dynamic> json){
    return Data(
      visitors: json["visitors"] == null ? null : Visitors.fromJson(json["visitors"]),
      vehicles: json["vehicles"] == null ? null : Kids.fromJson(json["vehicles"]),
      kids: json["kids"] == null ? null : Kids.fromJson(json["kids"]),
      incidents: json["incidents"] == null ? null : Incidents.fromJson(json["incidents"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "visitors": visitors?.toJson(),
    "vehicles": vehicles?.toJson(),
    "kids": kids?.toJson(),
    "incidents": incidents?.toJson(),
  };

}

class Incidents {
  Incidents({
    required this.total,
    required this.open,
    required this.closed,
  });

  final int? total;
  final int? open;
  final int? closed;

  factory Incidents.fromJson(Map<String, dynamic> json){
    return Incidents(
      total: json["total"],
      open: json["open"],
      closed: json["closed"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "open": open,
    "closed": closed,
  };

}

class Kids {
  Kids({
    required this.total,
    required this.kidsIn,
    required this.exit,
  });

  final int? total;
  final int? kidsIn;
  final int? exit;

  factory Kids.fromJson(Map<String, dynamic> json){
    return Kids(
      total: json["total"],
      kidsIn: json["in"],
      exit: json["exit"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "in": kidsIn,
    "exit": exit,
  };

}

class Visitors {
  Visitors({
    required this.total,
    required this.inside,
    required this.exited,
  });

  final int? total;
  final int? inside;
  final int? exited;

  factory Visitors.fromJson(Map<String, dynamic> json){
    return Visitors(
      total: json["total"],
      inside: json["inside"],
      exited: json["exited"],
    );
  }

  Map<String, dynamic> toJson() => {
    "total": total,
    "inside": inside,
    "exited": exited,
  };

}
