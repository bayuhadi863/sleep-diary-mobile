import 'package:flutter/material.dart';

final _timePickerTheme = TimePickerThemeData(
  //tombol cancel
  cancelButtonStyle: ButtonStyle(
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
  ),
  //tombol simpan
  confirmButtonStyle: ButtonStyle(
    backgroundColor: MaterialStateProperty.all<Color>(
      const Color(0xFF5C6AC0),
    ),
    foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
    shape: MaterialStateProperty.all<OutlinedBorder>(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
  ),
  backgroundColor: const Color.fromRGBO(38, 38, 66, 1),
  hourMinuteShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  dayPeriodBorderSide: const BorderSide(color: Colors.orange, width: 4),
  dayPeriodColor: Colors.blueGrey.shade600,
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  dayPeriodTextColor: Colors.grey[100],
  dayPeriodShape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(8)),
  ),
  hourMinuteColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected)
          ? const Color.fromRGBO(38, 38, 66, 1)
          : const Color.fromRGBO(38, 38, 66, 1)),
  hourMinuteTextColor: MaterialStateColor.resolveWith(
    (states) => states.contains(MaterialState.selected)
        ? Colors.grey.shade200
        : Colors.grey.shade200,
  ),
  dialHandColor: const Color(0xFF5C6AC0),
  dialBackgroundColor: const Color.fromRGBO(38, 38, 66, 1),
  hourMinuteTextStyle: const TextStyle(
      fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
  dayPeriodTextStyle: const TextStyle(
      fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
  helpTextStyle: const TextStyle(
      fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
  inputDecorationTheme: const InputDecorationTheme(
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.white),
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    contentPadding: EdgeInsets.all(0),
  ),
  dialTextColor: MaterialStateColor.resolveWith((states) =>
      states.contains(MaterialState.selected) ? Colors.white : Colors.white),
  entryModeIconColor: const Color(0xFF5C6AC0),
);
