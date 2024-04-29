import 'package:get/get.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';

class GetSleepDiaryController extends GetxController {
  static GetSleepDiaryController get instance => Get.find();
  var date = DateTime.now();

  Rx<SleepDiaryModel> sleepDiary = SleepDiaryModel.empty().obs;
  final getSleepDiaryRepository = Get.put(GetSleepDiaryRepository());

  RxList sleepDiaryDates = [].obs;

  @override
  void onInit() {
    super.onInit();
    fetchSleepDiaryData(date);
    getAllDates();
  }

  fetchSleepDiaryData(date) async {
    try {
      final sleepDiary = await getSleepDiaryRepository.fetchSleepDiary(date);
      this.sleepDiary(sleepDiary);
      print(
          'sleepdiary data: ${this.sleepDiary.value.toJson() == SleepDiaryModel.empty().toJson()}');
    } catch (e) {
      sleepDiary(SleepDiaryModel.empty());
      // print(e);
    }
  }

  Future<bool> checkSleepDiaryData(date) async {
    return await getSleepDiaryRepository.checkSleepDiaryData(date);
  }

  getAllDates() async {
    try {
      final dates = await getSleepDiaryRepository.getSleepDiaryDates();
      sleepDiaryDates = dates as RxList;
      print('sleepDiaryDates: $sleepDiaryDates');
    } catch (e) {
      sleepDiaryDates = [].obs;
    }
  }
}
