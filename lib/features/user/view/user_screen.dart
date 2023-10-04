import 'package:flutter/material.dart';
import 'package:mesto_flutter/features/base_screen/base_screen.dart';

class UserScreen extends BasePageScreen {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends BasePageScreenState<UserScreen> with BaseScreen {
  @override
  String appBarTitle() {
    return 'User';
  }

  @override
  void initState() {
    isShowAppBar(false);
    super.initState();
  }

  @override
  Widget body() {
    return const Center(
      child: Text("User screen"),
    );
  }
}
