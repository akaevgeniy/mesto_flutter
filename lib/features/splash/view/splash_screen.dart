import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:mesto_flutter/constants/theme_colors.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/features/auth/bloc/auth_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  final _authBloc = getIt<AuthBloc>();
  late AnimationController _controller;

  @override
  void initState() {
    // без этого появляется серый фон с opacity у статус бара
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
      ),
    );
    _controller = AnimationController(
      vsync: this,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      bloc: _authBloc,
      listener: (context, state) {
        if (state is AppAuthenticated) {
          context.go('/home');
        } else if (state is AuthenticationStart) {
          context.go('/auth');
        } else if (state is AppAforeAuthenticated) {
          context.go('/auth/register');
        }
      },
      child: Scaffold(
        backgroundColor: ThemeColors.white,
        body: SafeArea(
          child: Center(
            child: Column(
              children: [
                Lottie.asset(
                  './assets/splash.json',
                  fit: BoxFit.contain,
                  controller: _controller,
                  animate: true,
                  repeat: true,
                  onLoaded: (composition) {
                    _controller
                      ..duration = composition.duration
                      ..forward().whenComplete(() async {
                        _authBloc.add(const AppLoadedup());
                      });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
