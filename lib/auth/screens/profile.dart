import 'package:doctorapp/auth/bloc/auth_bloc.dart';
import 'package:doctorapp/auth/bloc/auth_event.dart';
import 'package:doctorapp/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  String _getUsernameFromEmail(String? email) {
    if (email != null && email.contains('@')) {
      return email.split('@')[0];
    }
    return 'User';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('الملف الشخصي'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              BlocProvider.of<AuthBloc>(context).add(LogoutRequested());
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              final username = _getUsernameFromEmail(state.user.email);
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: Text(
                        username.isNotEmpty ? username[0].toUpperCase() : 'U',
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      username,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 24.0),

                    const Text(
                      'معلومات المستخدم',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      'البريد الإلكتروني: ${state.user.email ?? 'غير متوفر'}',
                    ),
                    const SizedBox(height: 24.0),

                    // قائمة الحجوزات
                    const Text(
                      'حجوزاتي',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Divider(color: Colors.grey[300], thickness: 1),
                    const Text('لا توجد حجوزات حتى الآن.'),
                  ],
                ),
              );
            } else {
              return const Center(child: Text('لا يوجد معلومات مستخدم متاحة.'));
            }
          },
        ),
      ),
    );
  }
}
