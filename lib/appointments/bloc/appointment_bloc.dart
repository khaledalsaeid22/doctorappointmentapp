import 'package:doctorapp/appointments/bloc/appointment_event.dart';
import 'package:doctorapp/appointments/bloc/appointment_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/specialist.dart';

class BookingBloc extends Bloc<BookingEvent, BookingState> {
  BookingBloc() : super(BookingInitial()) {
    on<DateSelected>(_onDateSelected);
    on<TimeSelected>(_onTimeSelected);
    on<BookAppointmentRequested>(_onBookAppointmentRequested);
    on<ResetBooking>(_onResetBooking);
  }

  void _onDateSelected(DateSelected event, Emitter<BookingState> emit) {
    emit(
      BookingDateSelected(
        selectedDate: event.selectedDate,
        availableTimesByDay: event.specialist.getAvailableTimesByDay(),
      ),
    );
  }

  void _onTimeSelected(TimeSelected event, Emitter<BookingState> emit) {
    emit(BookingTimeSelected(selectedTime: event.selectedTime));
  }

  Future<void> _onBookAppointmentRequested(
    BookAppointmentRequested event,
    Emitter<BookingState> emit,
  ) async {
    emit(BookingLoading());
    try {
      print(
        'تم طلب حجز: الأخصائي=${event.specialist.id}, التاريخ=${event.bookingDateTime}, الوقت=${event.bookingTimeSlot}',
      );
      // Simulate success for now
      await Future.delayed(const Duration(seconds: 1));
      emit(const BookingSuccess(message: 'تم حجز الموعد بنجاح!'));
      emit(BookingInitial()); // Reset state
    } catch (e) {
      emit(BookingError(message: 'حدث خطأ أثناء حجز الموعد.'));
    }
  }

  void _onResetBooking(ResetBooking event, Emitter<BookingState> emit) {
    emit(BookingInitial());
  }
}
