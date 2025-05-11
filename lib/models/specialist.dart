class Specialist {
  final String id;
  final String name;
  final String specialization;
  final List<AvailableDayTime> availableDaysTimes;
  final String? bio;

  Specialist({
    required this.id,
    required this.name,
    required this.specialization,
    required this.availableDaysTimes,
    this.bio,
  });

  factory Specialist.fromMap(Map<String, dynamic> data, String id) {
    final availableDaysTimesData =
        data['availableDaysTimes'] as List<dynamic>? ?? [];
    final availableDaysTimes =
        availableDaysTimesData.map((item) {
          return AvailableDayTime.fromMap(item as Map<String, dynamic>);
        }).toList();

    return Specialist(
      id: id,
      name: data['name'] as String? ?? '',
      specialization: data['specialization'] as String? ?? '',
      availableDaysTimes: availableDaysTimes,
      bio: data['bio'] as String?,
    );
  }

  Map<String, List<String>> getAvailableTimesByDay() {
    final Map<String, List<String>> availability = {};
    for (final dayTime in availableDaysTimes) {
      availability[dayTime.day] = dayTime.times;
    }
    return availability;
  }
}

class AvailableDayTime {
  final String day;
  final List<String> times;

  AvailableDayTime({required this.day, required this.times});

  factory AvailableDayTime.fromMap(Map<String, dynamic> data) {
    final timesData = data['times'] as List<dynamic>? ?? [];
    final times = timesData.map((item) => item as String).toList();

    return AvailableDayTime(day: data['day'] as String? ?? '', times: times);
  }
}
