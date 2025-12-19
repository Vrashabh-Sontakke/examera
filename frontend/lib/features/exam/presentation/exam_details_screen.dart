import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../domain/exam_model.dart';
import 'tracking_buttons.dart';
import '../../../core/ad_banner.dart';

class ExamDetailsScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailsScreen({required this.exam, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(exam.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailSection(
              context,
              'About the Exam',
              exam.description ?? 'No description available.',
            ),
            const Divider(),
            _buildInfoRow(
              context,
              Icons.calendar_month,
              'Exam Date',
              exam.examDate != null
                  ? DateFormat('MMMM dd, yyyy').format(exam.examDate!)
                  : 'TBA',
            ),
            _buildInfoRow(
              context,
              Icons.timer,
              'Application Deadline',
              exam.applicationDeadline != null
                  ? DateFormat(
                      'MMMM dd, yyyy',
                    ).format(exam.applicationDeadline!)
                  : 'TBA',
            ),
            const Divider(),
            _buildDetailSection(
              context,
              'Eligibility',
              exam.eligibility ?? 'Not specified.',
            ),
            _buildDetailSection(
              context,
              'Syllabus',
              'Download or View Syllabus Link: ${exam.syllabusLink ?? "Not available"}',
            ),
            const SizedBox(height: 16),
            TrackingButtons(examId: exam.id),
            const SizedBox(height: 16),
            const Divider(),
            const SizedBox(height: 8),
            const AdBanner(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Open application link
                  // example code
                  // if (exam.applicationLink != null) {
                  //   launchUrl(Uri.parse(exam.applicationLink!));
                  // }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Apply Now'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailSection(
    BuildContext context,
    String title,
    String content,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(content, style: Theme.of(context).textTheme.bodyMedium),
        ],
      ),
    );
  }

  Widget _buildInfoRow(
    BuildContext context,
    IconData icon,
    String label,
    String value,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.secondary),
          const SizedBox(width: 8),
          Text('$label: ', style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }
}
