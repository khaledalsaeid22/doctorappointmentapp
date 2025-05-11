import 'package:doctorapp/auth/bloc/auth_bloc.dart';
import 'package:doctorapp/auth/bloc/auth_state.dart';
import 'package:doctorapp/specialists/screens/specialist_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state is AuthAuthenticated) {
          return const SpecialistListScreen();
        } else if (state is AuthUnauthenticated || state is AuthInitial) {
          return const LoginScreen();
        } else if (state is AuthUnauthenticated) {
          return const LoginScreen();
        } else if (state is AuthLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
