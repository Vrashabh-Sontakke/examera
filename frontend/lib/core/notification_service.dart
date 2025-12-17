import 'package:flutter/material.dart';

class NotificationService {
  static void scheduleExamReminder(String examTitle, DateTime examDate) {
    final reminderDate = examDate.subtract(const Duration(days: 1));
    debugPrint('Scheduled reminder for $examTitle on $reminderDate');
  }

  static void sendBestOfLuckNotification(String examTitle) {
    debugPrint('Notification: Best of luck for your $examTitle exam tomorrow!');
  }
}
