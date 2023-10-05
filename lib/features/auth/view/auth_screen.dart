import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mesto_flutter/di/service_locator.dart';
import 'package:mesto_flutter/features/auth/bloc/auth_bloc.dart';
import 'package:mesto_flutter/features/base_screen/base_screen.dart';
import 'package:mesto_flutter/helpers/widget_helpers.dart';
import 'package:mesto_flutter/widgets/error_toast.dart';

class AuthScreen extends BasePageScreen {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends BasePageScreenState<AuthScreen> with BaseScreen {
  final authBloc = getIt<AuthBloc>();

  @override
  String appBarTitle() {
    return 'Auth';
  }

  @override
  void initState() {
    isBackButton(false);
    super.initState();
  }

  sendForm() {
    authBloc.add(
      const UserAuth(email: '111@11.ru', password: '1111'),
    );
  }

  @override
  Widget body() {
    return BlocConsumer<AuthBloc, AuthState>(
      bloc: authBloc,
      listener: (context, state) {
        if (state is AuthenticationSuccess) {
          context.push('/auth/pincode');
        }
        if (state is AuthenticationFailure) {
          showError(state.exception.toString());
        }
      },
      builder: (context, state) {
        return Center(
          child: Column(
            children: [
              const Text("Auth screen"),
              16.ph,
              ElevatedButton(
                  onPressed: () {
                    sendForm();
                  },
                  child: const Text("Auth"))
            ],
          ),
        );
      },
    );
  }
}
