import 'package:doctorapp/auth/bloc/auth_bloc.dart';
import 'package:doctorapp/auth/bloc/auth_event.dart';
import 'package:doctorapp/auth/screens/auth_gate.dart';
import 'package:doctorapp/specialists/bloc/specialist_bloc.dart';
import 'package:doctorapp/specialists/bloc/specialist_event.dart';
import 'package:doctorapp/specialists/screens/specialist_list_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'repositories/specialist_repository.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
          create: (context) => AuthBloc()..add(AuthCheckRequested()),
        ),
        BlocProvider<SpecialistBloc>(
          create:
              (context) =>
                  SpecialistBloc(specialistRepository: SpecialistRepository())
                    ..add(LoadSpecialists()),
        ),
      ],
      child: MaterialApp(
        title: 'Doctors Appointment App',
        theme: ThemeData(primarySwatch: Colors.blue),
        darkTheme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: Colors.black,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.black,
            foregroundColor: Colors.white,
          ),
        ),
        themeMode: ThemeMode.dark,
        debugShowCheckedModeBanner: false,
        home: const AuthGate(),
      ),
    );
  }
}
