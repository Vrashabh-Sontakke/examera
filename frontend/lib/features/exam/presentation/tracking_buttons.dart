import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../subscription/subscription_provider.dart';

class TrackingButtons extends StatelessWidget {
  final int examId;

  const TrackingButtons({required this.examId, super.key});

  @override
  Widget build(BuildContext context) {
    final subProvider = context.watch<SubscriptionProvider>();

    return Row(
      children: [
        ElevatedButton(
          onPressed: () {
            if (!subProvider.isPremium) {
              subProvider.showSubscriptionPopup(context);
              return;
            }
            // TODO: Call track API
            // This marks the exam as applied
            // example code
            // if (exam.applicationLink != null) {
            //   launchUrl(Uri.parse(exam.applicationLink!));
            // }
          },
          child: const Text('Mark Applied'),
        ),
        const SizedBox(width: 8),
        OutlinedButton(
          onPressed: () {
            if (!subProvider.isPremium) {
              subProvider.showSubscriptionPopup(context);
              return;
            }
            // TODO: Call track API
            // This marks the exam as attempted
            // example code
            // if (exam.applicationLink != null) {
            //   launchUrl(Uri.parse(exam.applicationLink!));
            // }
          },
          child: const Text('Mark Attempted'),
        ),
      ],
    );
  }
}
