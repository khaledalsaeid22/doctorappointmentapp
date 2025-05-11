import 'package:doctorapp/auth/bloc/auth_bloc.dart';
import 'package:doctorapp/auth/bloc/auth_event.dart';
import 'package:doctorapp/auth/bloc/auth_state.dart';
import 'package:doctorapp/specialists/screens/specialist_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          print('تم إنشاء الحساب بنجاح: ${state.user.email}');
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const SpecialistListScreen(),
            ),
          );
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text('إنشاء حساب')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'البريد الإلكتروني',
                  ),
                ),
                const SizedBox(height: 16.0),
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'كلمة المرور'),
                ),
                const SizedBox(height: 24.0),
                if (state is AuthLoading)
                  const CircularProgressIndicator()
                else
                  ElevatedButton(
                    onPressed: () {
                      BlocProvider.of<AuthBloc>(context).add(
                        RegisterRequested(
                          email: _emailController.text,
                          password: _passwordController.text,
                        ),
                      );
                    },
                    child: const Text('إنشاء حساب'),
                  ),
                const SizedBox(height: 16.0),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Go back to login screen
                  },
                  child: const Text('لديك حساب بالفعل؟ تسجيل الدخول'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
