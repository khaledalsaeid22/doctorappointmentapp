import 'package:doctorapp/appointments/bloc/appointment_bloc.dart';
import 'package:doctorapp/appointments/screens/appointment_booking_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../models/specialist.dart';

class SpecialistCard extends StatelessWidget {
  final Specialist specialist;

  const SpecialistCard({super.key, required this.specialist});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              specialist.name,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              specialist.specialization,
              style: const TextStyle(fontSize: 16.0, color: Colors.grey),
            ),
            const SizedBox(height: 12.0),
            const Text(
              'الأيام والساعات المتاحة:',
              style: TextStyle(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 4.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children:
                  specialist.availableDaysTimes.map((adt) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2.0),
                      child: Text('${adt.day}: ${adt.times.join(', ')}'),
                    );
                  }).toList(),
            ),
            if (specialist.bio != null && specialist.bio!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 12.0),
                child: Text(
                  'نبذة: ${specialist.bio!}',
                  style: const TextStyle(fontStyle: FontStyle.italic),
                ),
              ),
            const SizedBox(height: 8.0),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                onPressed: () {
                  print('تم الضغط على حجز موعد لـ ${specialist.name}');
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder:
                          (context) => BlocProvider(
                            create: (context) => BookingBloc(),
                            child: BookAppointmentScreen(
                              specialist: specialist,
                            ),
                          ),
                    ),
                  );
                },
                child: const Text('حجز موعد'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
