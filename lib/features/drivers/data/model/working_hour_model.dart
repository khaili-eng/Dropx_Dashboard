class WorkingHourModel {
    String dayOfWeek;
   String startTime;
   String endTime;

  WorkingHourModel({
    required this.dayOfWeek,
    required this.startTime,
    required this.endTime,
  });

  Map<String, dynamic> toJson() {
    return {
      "day_of_week": dayOfWeek,
      "start_time": startTime,
      "end_time": endTime,
    };
  }
}