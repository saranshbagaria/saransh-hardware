class PainterResponse {
  String id;
  String name;
  String contactNumber;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  PainterResponse({
    required this.id,
    required this.name,
    required this.contactNumber,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  // fromJson to create a Result instance from JSON
  factory PainterResponse.fromJson(Map<String, dynamic> json) {
    return PainterResponse(
      id: json['_id'],
      name: json['name'],
      contactNumber: json['contactNumber'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'contactNumber': contactNumber,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}

class PainterListResponse{
  List<PainterResponse> painters;
  int page;
  int limit;
  int totalPages;
  int totalResults;

  PainterListResponse({
    required this.painters,
    required this.page,
    required this.limit,
    required this.totalPages,
    required this.totalResults,
  });

  factory PainterListResponse.fromJson(Map<String, dynamic> json) {
    return PainterListResponse(
        painters: List<PainterResponse>.from(json['results'].map((x)=> PainterResponse.fromJson(x))),
        page: json['page'],
        limit: json['limit'],
        totalPages: json['totalPages'],
        totalResults: json['totalResults'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': List<dynamic>.from(painters.map((x) => x.toJson())),
      'page': page,
      'limit': limit,
      'totalPages': totalPages,
      'totalResults': totalResults,
    };
  }
}