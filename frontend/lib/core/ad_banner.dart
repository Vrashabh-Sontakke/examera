import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../features/subscription/subscription_provider.dart';

class AdBanner extends StatelessWidget {
  const AdBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final isPremium = context.watch<SubscriptionProvider>().isPremium;

    if (isPremium) return const SizedBox.shrink();

    return Container(
      width: double.infinity,
      height: 60,
      margin: const EdgeInsets.symmetric(vertical: 8),
      color: Colors.grey[300],
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('AdSense Ad', style: TextStyle(color: Colors.grey)),
            Text(
              'Upgrade to Remove Ads',
              style: TextStyle(fontSize: 10, color: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
