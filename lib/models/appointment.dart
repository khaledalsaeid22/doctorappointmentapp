class Booking {
  final String bookingId;
  final String userId;
  final String specialistId;
  final String specialistName; // اسم الأخصائي
  final String specialistSpecialization; // تخصص الأخصائي
  final DateTime bookingDateTime;
  final String bookingTimeSlot;
  final String status;

  Booking({
    required this.bookingId,
    required this.userId,
    required this.specialistId,
    required this.specialistName,
    required this.specialistSpecialization,
    required this.bookingDateTime,
    required this.bookingTimeSlot,
    required this.status,
  });

  factory Booking.fromMap(Map<String, dynamic> data, String id) {
    return Booking(
      bookingId: id,
      userId: data['userId'] as String? ?? '',
      specialistId: data['specialistId'] as String? ?? '',
      specialistName: data['specialistName'] as String? ?? '',
      specialistSpecialization:
          data['specialistSpecialization'] as String? ?? '',
      bookingDateTime:
          (data['bookingDateTime'] as int?) != null
              ? DateTime.fromMillisecondsSinceEpoch(
                data['bookingDateTime'] as int,
              )
              : DateTime.now(),
      bookingTimeSlot: data['bookingTimeSlot'] as String? ?? '',
      status: data['status'] as String? ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'specialistId': specialistId,
      'specialistName': specialistName,
      'specialistSpecialization': specialistSpecialization,
      'bookingDateTime': bookingDateTime.millisecondsSinceEpoch,
      'bookingTimeSlot': bookingTimeSlot,
      'status': status,
    };
  }
}
