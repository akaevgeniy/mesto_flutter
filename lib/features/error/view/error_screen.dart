import 'package:flutter/material.dart';
import 'package:mesto_flutter/features/base_screen/base_screen.dart';

class ErrorScreen extends BasePageScreen {
  const ErrorScreen({super.key});

  @override
  State<ErrorScreen> createState() => _ErrorScreenState();
}

class _ErrorScreenState extends BasePageScreenState<ErrorScreen> {
  @override
  String appBarTitle() {
    throw UnimplementedError();
  }

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Error screen'),
    );
  }
}
