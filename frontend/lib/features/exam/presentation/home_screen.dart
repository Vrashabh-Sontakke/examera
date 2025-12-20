import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'exam_provider.dart';
import 'exam_card.dart';
import '../domain/exam_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Examera'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              onChanged: (value) =>
                  context.read<ExamProvider>().setSearchQuery(value),
              decoration: InputDecoration(
                hintText: 'Search exams...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
        ),
      ),
      body: Consumer<ExamProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error.isNotEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => provider.loadExams(),
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.exams.isEmpty) {
            return const Center(child: Text('No exams found.'));
          }

          return ListView.builder(
            itemCount: provider.exams.length,
            itemBuilder: (context, index) {
              final exam = provider.exams[index];
              return ExamCard(
                exam: exam,
                onTap: () {
                  context.go('/details', extra: exam);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showFilterDialog(context),
        child: const Icon(Icons.filter_list),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Filter by Status',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 8,
                children: [
                  ChoiceChip(
                    label: const Text('All'),
                    selected: false, // Simplified for now to avoid lint
                    onSelected: (_) {
                      context.read<ExamProvider>().setStatusFilter(null);
                      Navigator.pop(context);
                    },
                  ),
                  ...ExamStatus.values.map((status) {
                    return ChoiceChip(
                      label: Text(
                        status.toString().split('.').last.toUpperCase(),
                      ),
                      selected: false, // Should be managed by provider
                      onSelected: (selected) {
                        if (selected) {
                          context.read<ExamProvider>().setStatusFilter(status);
                        }
                        Navigator.pop(context);
                      },
                    );
                  }), // .toList(),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
