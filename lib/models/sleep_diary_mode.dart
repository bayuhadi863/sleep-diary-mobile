import 'package:cloud_firestore/cloud_firestore.dart';

class SleepDiaryModel {
  final String? id;
  String userId;
  String sleepDate;
  String sleepTime;
  String wakeupTime;
  int scale;
  List<String> factors;
  String description;

  SleepDiaryModel(
      {this.id,
      required this.userId,
      required this.sleepDate,
      required this.sleepTime,
      required this.wakeupTime,
      required this.scale,
      required this.factors,
      required this.description});

  static SleepDiaryModel empty() => SleepDiaryModel(
      userId: '',
      sleepDate: '',
      sleepTime: '',
      wakeupTime: '',
      scale: 0,
      factors: [],
      description: '');

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'sleepDate': sleepDate,
      'sleepTime': sleepTime,
      'wakeupTime': wakeupTime,
      'scale': scale,
      'factors': factors,
      'description': description
    };
  }

  // factory slepp diary from snapshot
  factory SleepDiaryModel.fromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return SleepDiaryModel(
        id: snapshot.id,
        userId: data['userId'],
        sleepDate: data['sleepDate'],
        sleepTime: data['sleepTime'],
        wakeupTime: data['wakeupTime'],
        scale: data['scale'],
        factors:
            data['factors'] != null ? List<String>.from(data['factors']) : [],
        description: data['description']);
  }
}
