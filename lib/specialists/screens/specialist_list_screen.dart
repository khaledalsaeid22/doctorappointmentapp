import 'package:doctorapp/auth/screens/profile.dart';
import 'package:doctorapp/specialists/bloc/specialist_bloc.dart';
import 'package:doctorapp/specialists/bloc/specialist_event.dart';
import 'package:doctorapp/specialists/bloc/specialist_state.dart';
import 'package:doctorapp/specialists/widgets/error_message.dart';
import 'package:doctorapp/specialists/widgets/loading_indicator.dart';
import 'package:doctorapp/specialists/widgets/specialist_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/specialist_repository.dart';

class SpecialistListScreen extends StatelessWidget {
  const SpecialistListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              SpecialistBloc(specialistRepository: SpecialistRepository())
                ..add(LoadSpecialists()),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.person),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ProfileScreen(),
                  ),
                );
              },
            ),
          ],
          title: const Text('Avilable specialists'),
          centerTitle: true,
        ),
        body: BlocBuilder<SpecialistBloc, SpecialistState>(
          builder: (context, state) {
            if (state is SpecialistLoading) {
              return const LoadingIndicator(text: 'جاري تحميل الأخصائيين...');
            } else if (state is SpecialistLoaded) {
              return ListView.builder(
                itemCount: state.specialists.length,
                itemBuilder: (context, index) {
                  final specialist = state.specialists[index];
                  return SpecialistCard(specialist: specialist);
                },
              );
            } else if (state is SpecialistError) {
              print(state.message);
              return ErrorMessage(message: state.message);
            } else {
              return const Center(child: Text('لا توجد بيانات أخصائيين.'));
            }
          },
        ),
      ),
    );
  }
}
