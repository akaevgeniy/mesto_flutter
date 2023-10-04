import 'package:flutter/material.dart';
import 'package:mesto_flutter/constants/theme_data.dart';
import 'package:mesto_flutter/routes/go_router.dart';

class MestoApp extends StatelessWidget {
  const MestoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      builder: (context, child) {
        ErrorWidget.builder = (FlutterErrorDetails errorDetails) {
          return const Text('Error');
        };
        return child ?? const Scaffold();
      },
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.lightTheme,
      title: 'Vkt app',
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
