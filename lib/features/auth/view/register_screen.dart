import 'package:flutter/material.dart';
import 'package:mesto_flutter/features/base_screen/base_screen.dart';

class RegisterScreen extends BasePageScreen {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends BasePageScreenState<RegisterScreen>
    with BaseScreen {
  @override
  String appBarTitle() {
    return 'Register';
  }

  @override
  void initState() {
    isBackButton(false);
    isShowAppBar(false);
    super.initState();
  }

  @override
  Widget body() {
    return const Center(
      child: Text("Register screen"),
    );
  }
}
