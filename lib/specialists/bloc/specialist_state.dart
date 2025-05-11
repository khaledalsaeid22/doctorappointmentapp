import 'package:equatable/equatable.dart';
import '../../models/specialist.dart';

abstract class SpecialistState extends Equatable {
  const SpecialistState();

  @override
  List<Object> get props => [];
}

class SpecialistInitial extends SpecialistState {}

class SpecialistLoading extends SpecialistState {}

class SpecialistLoaded extends SpecialistState {
  final List<Specialist> specialists;

  const SpecialistLoaded({required this.specialists});

  @override
  List<Object> get props => [specialists];
}

class SpecialistError extends SpecialistState {
  final String message;

  const SpecialistError({required this.message});

  @override
  List<Object> get props => [message];
}
