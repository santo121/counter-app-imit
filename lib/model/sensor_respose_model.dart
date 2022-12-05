class RecentMoneySentResponse {
  String? d;
  String? t;
  String? h;
  RecentMoneySentResponse({this.d, this.t});

  RecentMoneySentResponse.fromJson(Map<String, dynamic> json) {
    d = json['D'];
    t = json['T'];
    h = json['H'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['D'] = this.d;
    data['T'] = this.t;
    return data;
  }
}