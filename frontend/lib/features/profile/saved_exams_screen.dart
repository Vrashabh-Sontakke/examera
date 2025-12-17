import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../exam/presentation/exam_provider.dart';
import '../exam/presentation/exam_card.dart';
import '../subscription/subscription_provider.dart';
import 'package:go_router/go_router.dart';

class SavedExamsScreen extends StatelessWidget {
  const SavedExamsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final subProvider = context.watch<SubscriptionProvider>();

    if (!subProvider.isPremium) {
      return Scaffold(
        appBar: AppBar(title: const Text('Saved Exams')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.lock, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text('This feature is for Premium users only.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => subProvider.showSubscriptionPopup(context),
                child: const Text('Upgrade Now'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Saved Exams')),
      body: Consumer<ExamProvider>(
        builder: (context, provider, child) {
          // For now, let's mock the "saved" status or filter by some logic
          // In a real app, this would be a specific API call
          final savedExams = provider.exams.take(2).toList(); // Mocking

          if (savedExams.isEmpty) {
            return const Center(child: Text('No saved exams yet.'));
          }

          return ListView.builder(
            itemCount: savedExams.length,
            itemBuilder: (context, index) {
              final exam = savedExams[index];
              return ExamCard(
                exam: exam,
                onTap: () => context.go('/details', extra: exam),
              );
            },
          );
        },
      ),
    );
  }
}
