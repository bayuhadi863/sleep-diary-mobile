import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/current_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/last_week_summary.dart';
import 'package:sleep_diary_mobile/controllers/sleep_diary_summary/monthly_summary.dart';
import 'package:sleep_diary_mobile/repositories/user/user_repository.dart';

class AdviceRepository {

  static Map<String, String> factorsAdvices = {
    "sakit": 'Sakit: Kalau lagi sakit, usahain buat istirahat yang cukup dan jangan ngelakuin aktivitas yang terlalu berat. Kalau gejala nggak kunjung membaik, langsung aja konsultasi sama dokter. Jangan lupa makan makanan bergizi dan minum cairan yang cukup biar cepet sembuh.',
    "lingkungan": 'Lingkungan: Kalau lingkungan sekitar dingin, pake selimut biar anget. Buat yang sering keganggu suara, coba deh pake penutup telinga. Pastikan juga ruangan tidur kamu gelap banget dengan gorden atau tirai yang bisa menghalangi cahaya dari luar.',
    "stress": 'Stress: Buat ngurangin stres, coba deh rutin lakuin kegiatan relaksasi kayak meditasi, yoga, atau olahraga. Kalau ada masalah, cerita aja sama orang terdekat. Kalau butuh bantuan lebih, nggak ada salahnya konsultasi sama psikolog biar dapet bimbingan dan strategi yang tepat.',
    "terbangun": 'Terbangun: Biar nggak sering terbangun, usahain punya jadwal tidur yang konsisten setiap hari, termasuk akhir pekan. Kalau terbangun di malam hari, coba latihan relaksasi kayak pernafasan dalam, meditasi, atau visualisasi buat nenangin pikiran dan tubuh. Kalau susah balik tidur, coba baca buku atau dengerin musik instrumental yang ngebosenin.',
    "gelisah": 'Gelisah: Kalau sering gelisah sebelum tidur, coba teknik relaksasi kayak pernafasan dalam atau meditasi. Hindari kafein dan stimulan lainnya menjelang tidur. Kalau masalah ini terus berlanjut, ada baiknya konsultasi sama psikolog buat dapet penanganan yang tepat.'
  };

  static Future<String> lastWeekAdvice() async {

    final user = await UserRepository().fetchUserDetails();
    
    final lastWeekScaleAverage = await LastWeekSummary().getLastWeekScaleAverage();

    if(lastWeekScaleAverage < 1) return '${user.name.split(' ')[0]} Belum Isi Data';

    final lastWeekFactors = await LastWeekSummary().getLastWeekFactors();

    List<String> mostLastWeekFactors = [];

    int mostFactors = 0;

    lastWeekFactors.forEach((key, value) {
      if(value > mostFactors){
        mostFactors = value;
        mostLastWeekFactors.clear();
        mostLastWeekFactors.add(key);
      }
      else if(value == mostFactors){
        mostLastWeekFactors.add(key);
      }
    });

    if(mostFactors == 0) return 'Kualitas Tidur ${user.name.split(' ')[0]} Minggu Lalu Sudah Bagus, Tetap Pertahankan Ya!!!!';

    String advice = 'Faktor yang paling mempengaruhi tidur ${user.name.split(' ')[0]} minggu lalu adalah ';

    if(mostLastWeekFactors.length > 1){
      for (var i = 0; i < mostLastWeekFactors.length; i++) {
        if(i != mostLastWeekFactors.length - 1){
          advice += '${mostLastWeekFactors[i]}, ';
        }
        else{
          advice += '${mostLastWeekFactors[i]}.';
        }
      }
    }
    else{
      advice += '${mostLastWeekFactors[0]}.';
    }

    advice += '\n\n${user.name.split(" ")[0]}, coba cek beberapa tips ini deh!\n\n';

    for (var i = 0; i < mostLastWeekFactors.length; i++) {
      advice += '${factorsAdvices[mostLastWeekFactors[i]]}\n\n';
    }

    advice += 'Semoga tips ini bikin tidur kamu lebih nyenyak ya! Selamat beristirahat!';

    return advice;

  }

  static Future<String> currentWeekAdvice() async {
    final user = await UserRepository().fetchUserDetails();
    
    final currentWeekScaleAverage = await CurrentWeekSummary().getCurrentWeekScaleAverage();

    if(currentWeekScaleAverage < 1) return '${user.name.split(' ')[0]} Belum Isi Data';

    final currentWeekFactors = await CurrentWeekSummary().getCurrentWeekFactors();

    List<String> mostCurrentWeekFactors = [];

    int mostFactors = 0;

    currentWeekFactors.forEach((key, value) {
      if(value > mostFactors){
        mostFactors = value;
        mostCurrentWeekFactors.clear();
        mostCurrentWeekFactors.add(key);
      }
      else if(value == mostFactors){
        mostCurrentWeekFactors.add(key);
      }
    });

    if(mostFactors == 0) return 'Kualitas Tidur ${user.name.split(' ')[0]} Minggu Ini Sudah Bagus, Tetap Pertahankan Ya!!!!';

    String advice = 'Faktor yang paling mempengaruhi tidur ${user.name.split(' ')[0]} minggu ini adalah ';

    if(mostCurrentWeekFactors.length > 1){
      for (var i = 0; i < mostCurrentWeekFactors.length; i++) {
        if(i != mostCurrentWeekFactors.length - 1){
          advice += '${mostCurrentWeekFactors[i]}, ';
        }
        else{
          advice += '${mostCurrentWeekFactors[i]}.';
        }
      }
    }
    else{
      advice += '${mostCurrentWeekFactors[0]}.';
    }

    advice += '\n\n${user.name.split(" ")[0]}, coba cek beberapa tips ini deh!\n\n';

    for (var i = 0; i < mostCurrentWeekFactors.length; i++) {
      advice += '${factorsAdvices[mostCurrentWeekFactors[i]]}\n\n';
    }

    advice += 'Semoga tips ini bikin tidur kamu lebih nyenyak ya! Selamat beristirahat!';

    return advice;

  }

  static Future<String> monthlyAdvice(int month, int year) async {
    final user = await UserRepository().fetchUserDetails();
    
    final monthlyScaleAverage = await MonthlySummary().getMonthlyScaleAverage(month, year);

    if(monthlyScaleAverage < 1) return '${user.name.split(' ')[0]} Belum Isi Data';

    final monthlyFactors = await MonthlySummary().getMonthlyFactors(month, year);

    List<String> mostMonthlyFactors = [];

    int mostFactors = 0;

    monthlyFactors.forEach((key, value) {
      if(value > mostFactors){
        mostFactors = value;
        mostMonthlyFactors.clear();
        mostMonthlyFactors.add(key);
      }
      else if(value == mostFactors){
        mostMonthlyFactors.add(key);
      }
    });

    if(mostFactors == 0) return 'Kualitas Tidur ${user.name.split(' ')[0]} Bulan Ini Sudah Bagus, Tetap Pertahankan Ya!!!!';

    String advice = 'Faktor yang paling mempengaruhi tidur ${user.name.split(' ')[0]} bulan ini adalah ';

    if(mostMonthlyFactors.length > 1){
      for (var i = 0; i < mostMonthlyFactors.length; i++) {
        if(i != mostMonthlyFactors.length - 1){
          advice += '${mostMonthlyFactors[i]}, ';
        }
        else{
          advice += 'dan ${mostMonthlyFactors[i]}.';
        }
      }
    }
    else{
      advice += '${mostMonthlyFactors[0]}.';
    }

    advice += '\n\n${user.name.split(" ")[0]}, coba cek ceberapa tips ini deh!\n\n';

    for (var i = 0; i < mostMonthlyFactors.length; i++) {
      advice += '${factorsAdvices[mostMonthlyFactors[i]]}\n\n';
    }

    advice += 'Semoga tips ini bikin tidur kamu lebih nyenyak ya! Selamat beristirahat!';

    return advice;
  }

}