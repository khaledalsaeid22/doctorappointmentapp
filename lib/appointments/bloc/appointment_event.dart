import 'package:equatable/equatable.dart';
import '../../models/specialist.dart';

abstract class BookingEvent extends Equatable {
  const BookingEvent();

  @override
  List<Object> get props => [];
}

class DateSelected extends BookingEvent {
  final DateTime selectedDate;
  final Specialist specialist;

  const DateSelected({required this.selectedDate, required this.specialist});

  @override
  List<Object> get props => [selectedDate, specialist];
}

class TimeSelected extends BookingEvent {
  final String selectedTime;

  const TimeSelected({required this.selectedTime});

  @override
  List<Object> get props => [selectedTime];
}

class BookAppointmentRequested extends BookingEvent {
  final Specialist specialist;
  final DateTime bookingDateTime;
  final String bookingTimeSlot;

  const BookAppointmentRequested({
    required this.specialist,
    required this.bookingDateTime,
    required this.bookingTimeSlot,
  });

  @override
  List<Object> get props => [specialist, bookingDateTime, bookingTimeSlot];
}

class ResetBooking extends BookingEvent {}
