import 'package:flutter/material.dart';
import 'package:mesto_flutter/features/base_screen/base_screen.dart';

class HomeScreen extends BasePageScreen {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BasePageScreenState<HomeScreen> with BaseScreen {
  @override
  String appBarTitle() {
    return 'Home';
  }

  @override
  void initState() {
    isShowAppBar(false);
    super.initState();
  }

  @override
  Widget body() {
    return const Center(
      child: Text("Home screen"),
    );
  }
}
