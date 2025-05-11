// ... بقية الاستيرادات وشاشة BookAppointmentScreen

import 'package:doctorapp/appointments/bloc/appointment_bloc.dart';
import 'package:doctorapp/appointments/bloc/appointment_event.dart';
import 'package:doctorapp/appointments/bloc/appointment_state.dart';
import 'package:doctorapp/models/specialist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BookAppointmentScreen extends StatefulWidget {
  final Specialist specialist;

  const BookAppointmentScreen({Key? key, required this.specialist})
    : super(key: key);

  @override
  _BookAppointmentScreenState createState() => _BookAppointmentScreenState();
}

class _BookAppointmentScreenState extends State<BookAppointmentScreen> {
  DateTime? _selectedDate;
  String? _selectedTime;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (picked != null && picked != _selectedDate) {
      BlocProvider.of<BookingBloc>(
        context,
      ).add(DateSelected(selectedDate: picked, specialist: widget.specialist));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<BookingBloc, BookingState>(
      listener: (context, state) {
        if (state is BookingSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
          Navigator.of(context).pop();
        } else if (state is BookingError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
        if (state is BookingDateSelected) {
          _selectedDate = state.selectedDate;
          _selectedTime = null;
        }
        if (state is BookingTimeSelected) {
          _selectedTime = state.selectedTime;
        }
      },
      builder: (context, state) {
        Map<String, List<String>> availableTimesByDay = {};
        if (state is BookingDateSelected && state.availableTimesByDay != null) {
          availableTimesByDay = state.availableTimesByDay;
        } else {
          availableTimesByDay = widget.specialist.getAvailableTimesByDay();
        }

        List<String> availableTimesForSelectedDate = [];

        if (_selectedDate != null) {
          final dayOfWeek = _selectedDate!.weekdayToString();
          availableTimesForSelectedDate = availableTimesByDay[dayOfWeek] ?? [];
        }

        return Scaffold(
          appBar: AppBar(title: Text('حجز موعد مع ${widget.specialist.name}')),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'اختر تاريخ الموعد:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                InkWell(
                  onTap: () => _selectDate(context),
                  child: Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      _selectedDate == null
                          ? 'اختر تاريخًا'
                          : '${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}',
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                if (_selectedDate != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'اختر وقت الموعد:',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8.0),
                      if (availableTimesForSelectedDate.isNotEmpty)
                        Wrap(
                          spacing: 8.0,
                          children:
                              availableTimesForSelectedDate.map((time) {
                                return ChoiceChip(
                                  label: Text(time),
                                  selected: _selectedTime == time,
                                  onSelected: (selected) {
                                    if (selected) {
                                      BlocProvider.of<BookingBloc>(
                                        context,
                                      ).add(TimeSelected(selectedTime: time));
                                    } else {
                                      BlocProvider.of<BookingBloc>(context).add(
                                        const TimeSelected(selectedTime: ''),
                                      );
                                    }
                                  },
                                );
                              }).toList(),
                        )
                      else
                        const Text('لا توجد أوقات متاحة لهذا اليوم.'),
                    ],
                  ),
                const SizedBox(height: 32.0),
                ElevatedButton(
                  onPressed:
                      _selectedDate != null && _selectedTime != null
                          ? () {
                            BlocProvider.of<BookingBloc>(context).add(
                              BookAppointmentRequested(
                                specialist: widget.specialist,
                                bookingDateTime: _selectedDate!,
                                bookingTimeSlot: _selectedTime!,
                              ),
                            );
                          }
                          : null,
                  child:
                      state is BookingLoading
                          ? const CircularProgressIndicator()
                          : const Text('تأكيد الحجز'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

extension on DateTime {
  String weekdayToString() {
    switch (weekday) {
      case 1:
        return 'الاثنين';
      case 2:
        return 'الثلاثاء';
      case 3:
        return 'الأربعاء';
      case 4:
        return 'الخميس';
      case 5:
        return 'الجمعة';
      case 6:
        return 'السبت';
      case 7:
        return 'الأحد';
      default:
        return '';
    }
  }
}
