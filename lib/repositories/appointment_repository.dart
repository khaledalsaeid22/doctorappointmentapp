import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorapp/models/appointment.dart';

class BookingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveBooking(Booking booking) async {
    try {
      await _firestore.collection('bookings').add(booking.toMap());
    } catch (e) {
      print('Error saving booking: $e');
      rethrow;
    }
  }

  Stream<List<Booking>> getUserBookings(String userId) {
    return _firestore
        .collection('bookings')
        .where('userId', isEqualTo: userId)
        .orderBy('bookingDateTime', descending: false)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs
              .map(
                (doc) =>
                    Booking.fromMap(doc.data() as Map<String, dynamic>, doc.id),
              )
              .toList();
        });
  }
}
