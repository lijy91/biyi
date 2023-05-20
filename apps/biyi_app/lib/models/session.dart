class Session {
  Session({
    required this.id,
    this.accessToken,
  });

  factory Session.fromJson(Map<String, dynamic> json) {
    return Session(
      id: json['id'],
      accessToken: json['access_token'],
    );
  }

  int id;
  String? accessToken;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'access_token': accessToken,
    };
  }
}
