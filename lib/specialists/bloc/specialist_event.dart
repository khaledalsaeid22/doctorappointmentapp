import 'package:equatable/equatable.dart';

abstract class SpecialistEvent extends Equatable {
  const SpecialistEvent();

  @override
  List<Object> get props => [];
}

class LoadSpecialists extends SpecialistEvent {}
