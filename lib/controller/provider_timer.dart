import 'dart:async';
import 'package:flutter/material.dart';

import '../page/login.dart';

class ProviderTimer extends ChangeNotifier {
  int remainingTime = 2 * 60 * 60;
  String time = '02:00:00';
  get chanegone => time;
  Future<void> resetTimer(BuildContext context, String language) async {
    // Set initial time here
    Future.delayed(Duration(seconds: 1), () {
      remainingTime--;

      int hours = (remainingTime ~/ 3600);
      int minutes = (remainingTime % 3600) ~/ 60;
      int seconds = remainingTime % 60;

      String hoursStr = (hours < 10) ? '0$hours' : '$hours';
      String minutesStr = (minutes < 10) ? '0$minutes' : '$minutes';
      String secondsStr = (seconds < 10) ? '0$seconds' : '$seconds';
      time = '$hoursStr:$minutesStr:$secondsStr';
      notifyListeners();
      if (remainingTime <= 0) {
        time = '00:00:00';
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => LoginPage(
                    Language: language,
                  )),
        );
      } else {
        resetTimer(context, language);
      }
    });
  }
}
