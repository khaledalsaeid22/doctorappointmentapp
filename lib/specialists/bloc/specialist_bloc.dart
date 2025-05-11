import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/models/specialist.dart';
import 'package:doctorapp/repositories/specialist_repository.dart';
import 'package:doctorapp/specialists/bloc/specialist_event.dart';
import 'package:doctorapp/specialists/bloc/specialist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SpecialistBloc extends Bloc<SpecialistEvent, SpecialistState> {
  final SpecialistRepository specialistRepository;

  SpecialistBloc({required SpecialistRepository specialistRepository})
    : specialistRepository = specialistRepository,
      super(SpecialistInitial()) {
    on<LoadSpecialists>(onLoadSpecialists);
  }

  Future<void> onLoadSpecialists(
    LoadSpecialists event,
    Emitter<SpecialistState> emit,
  ) async {
    emit(SpecialistLoading());
    try {
      final specialistsStream = specialistRepository.getSpecialists();
      await emit.forEach<List<Specialist>>(
        specialistsStream,
        onData: (specialists) => SpecialistLoaded(specialists: specialists),
        onError:
            (error, StackTrace) => SpecialistError(message: error.toString()),
      );
    } catch (e) {
      emit(SpecialistError(message: e.toString()));
    }
  }
}
