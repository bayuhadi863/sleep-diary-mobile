class SleepDiaryModel{
  String userId;
  String sleepDate;
  String sleepTime;
  String wakeupTime;
  int scale;
  String description; 

  SleepDiaryModel({
    required this.userId,
    required this.sleepDate,
    required this.sleepTime,
    required this.wakeupTime,
    required this.scale,
    required this.description
  });

  static SleepDiaryModel empty() => SleepDiaryModel(
    userId: '',
    sleepDate: '',
    sleepTime: '',
    wakeupTime: '',
    scale: 0,
    description: ''
  );

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sleepDate': sleepDate,
      'sleepTime': sleepTime,
      'wakeupTime': wakeupTime,
      'scale': scale,
      'description': description
    };
  }
}