import 'package:flutter/material.dart';

class SubscriptionProvider with ChangeNotifier {
  bool _isPremium = false;

  bool get isPremium => _isPremium;

  void showSubscriptionPopup(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Subscribe to Premium'),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Enjoy an ad-free experience and track your exams!'),
            SizedBox(height: 16),
            Text(
              'Only Rs. 99 for 1 year',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Maybe Later'),
          ),
          ElevatedButton(
            onPressed: () {
              _isPremium = true;
              notifyListeners();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Welcome to Premium!')),
              );
            },
            child: const Text('Subscribe Now'),
          ),
        ],
      ),
    );
  }
}
