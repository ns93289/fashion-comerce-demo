import 'package:fashion_comerce_demo/main.dart';
import 'package:fashion_comerce_demo/presentation/components/common_app_bar.dart';
import 'package:flutter/material.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CommonAppBar(title: Text(language.myProfile)));
  }

  Widget _buildProfilePicture() {
    return SingleChildScrollView(child: Column(),);
  }
}
