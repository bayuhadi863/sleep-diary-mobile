import 'package:get/get.dart';
import 'package:sleep_diary_mobile/models/sleep_diary_mode.dart';
import 'package:sleep_diary_mobile/repositories/sleep_diary/get_sleep_diary.dart';

class GetSleepDiaryDetailController extends GetxController {
  static GetSleepDiaryDetailController get instance => Get.find();

  final isLoading = false.obs;
  final Rx<SleepDiaryModel> sleepDiary = SleepDiaryModel.empty().obs;

  void fetchSleepDiaryDetail(String id) async {
    try {
      isLoading(true);

      final getSleepDiaryRepository = Get.put(GetSleepDiaryRepository());
      final sleepDiaryData =
          await getSleepDiaryRepository.fetchSleepDiaryById(id);
      sleepDiary(sleepDiaryData);

      isLoading(false);
    } catch (e) {
      isLoading(false);
      throw e;
    }
  }
}
