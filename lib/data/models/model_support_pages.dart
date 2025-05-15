class ModelSupportPages {
  String? _pageTitle;
  String? _pageUrl;

  ModelSupportPages({String? pageTitle, String? pageUrl}) {
    _pageTitle = pageTitle;
    _pageUrl = pageUrl;
  }

  ModelSupportPages.fromJson(Map<String, dynamic> json) {
    _pageTitle = json['page_title'];
    _pageUrl = json['page_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_title'] = this._pageTitle;
    data['page_url'] = this._pageUrl;
    return data;
  }

  String get pageTitle => _pageTitle ?? "";

  String get pageUrl => _pageUrl ?? "";
}
