import 'package:equatable/equatable.dart';

abstract class BookingState extends Equatable {
  const BookingState();

  @override
  List<Object> get props => [];
}

class BookingInitial extends BookingState {}

class BookingLoading extends BookingState {}

class BookingDateSelected extends BookingState {
  final DateTime selectedDate;
  final Map<String, List<String>> availableTimesByDay;

  const BookingDateSelected({
    required this.selectedDate,
    required this.availableTimesByDay,
  });

  @override
  List<Object> get props => [selectedDate, availableTimesByDay];
}

class BookingTimeSelected extends BookingState {
  final String selectedTime;

  const BookingTimeSelected({required this.selectedTime});

  @override
  List<Object> get props => [selectedTime];
}

class BookingSuccess extends BookingState {
  final String message;

  const BookingSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class BookingError extends BookingState {
  final String message;

  const BookingError({required this.message});

  @override
  List<Object> get props => [message];
}
