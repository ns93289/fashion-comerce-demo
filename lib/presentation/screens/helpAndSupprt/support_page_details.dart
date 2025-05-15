import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../../components/common_app_bar.dart';

class SupportPageDetails extends StatefulWidget {
  final String pageTitle;
  final String pageUrl;

  const SupportPageDetails({super.key, required this.pageTitle, required this.pageUrl});

  @override
  State<SupportPageDetails> createState() => _SupportPageDetailsState();
}

class _SupportPageDetailsState extends State<SupportPageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(widget.pageTitle)), body: SafeArea(child: _buildSupportPage()));
  }

  Widget _buildSupportPage() {
    return InAppWebView(initialUrlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.pageUrl))));
  }
}
