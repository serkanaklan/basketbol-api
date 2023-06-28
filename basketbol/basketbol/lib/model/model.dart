class Api {
  final String username;
  Api({required this.username});
  factory Api.fromJson(Map<String, dynamic> json) {
    return Api(username: json["username"]);
  }
}
