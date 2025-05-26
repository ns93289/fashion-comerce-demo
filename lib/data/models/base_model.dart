class BaseModel {
  String? _message;

  BaseModel.fromJson(dynamic json) {
    _message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['message'] = _message;
    return data;
  }

  String get message => _message ?? "";
}
