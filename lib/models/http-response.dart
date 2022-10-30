class HttpResponse {
  String status;
  dynamic data;

  HttpResponse({required this.status, this.data});

  factory HttpResponse.fromJson(dynamic json) {
    return HttpResponse(
      status: json['status'],
      data: json['data'],
    );
  }
}
