class Query {
  final String type;
  final List<int> range;

  Query({required this.type, required this.range});

  factory Query.fromJson(Map<String, dynamic> json) {
    return Query(
      type: json['type'],
      range: List<int>.from(json['range']),
    );
  }
}

class ApiResponse {
  final String token;
  final List<int> data;
  final List<Query> queries;

  ApiResponse({required this.token, required this.data, required this.queries});

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    return ApiResponse(
      token: json['token'],
      data: List<int>.from(json['data']),
      queries: (json['query'] as List).map((e) => Query.fromJson(e)).toList(),
    );
  }
}
