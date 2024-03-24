import 'package:get/get.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';

class GetSleepDiaryController extends GetxController {
  static GetSleepDiaryController get instance => Get.find();

  Rx<SleepDiaryModel> sleepDiary = SleepDiaryModel.empty().obs;
  // RxList<Map<String, dynamic>> sleepFactors = <Map<String, dynamic>>[].obs;
  final getSleepDiaryRepository = Get.put(GetSleepDiaryRepository());

  @override
  void onInit() {
    super.onInit();
    fetchSleepDiaryData();
    // fetchSleepFactore();
  }

  /// Fetch user record
  fetchSleepDiaryData() async {
    try {
      final sleepDiary = await getSleepDiaryRepository.fetchSleepDiary();
      this.sleepDiary(sleepDiary);
    } catch (e) {
      sleepDiary(SleepDiaryModel.empty());
    }
  }

  // Future<void> fetchSleepFactors() async {
  //   try {
  //     // Assuming sleepDiaryId is available (modify based on your logic)
  //     final String sleepDiaryId =
  //         sleepDiary.value.id; // Get sleepDiaryId from sleepDiary
  //     final fetchedSleepFactors =
  //         await getSleepDiaryRepository.fetchSleepFactorIds(sleepDiaryId);
  //     this.sleepFactors(fetchedSleepFactors);
  //   } catch (e) {
  //     print(
  //         'Error fetching sleep factors: $e'); // Consider error handling (e.g., snackbar)
  //   }
  // }
}
