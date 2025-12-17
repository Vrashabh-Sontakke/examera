import 'package:flutter/foundation.dart';
import '../domain/exam_model.dart';
import '../data/exam_repository.dart';

class ExamProvider with ChangeNotifier {
  final ExamRepository repository;

  List<Exam> _exams = [];
  List<Exam> _filteredExams = [];
  bool _isLoading = false;
  String _error = '';

  ExamStatus? _statusFilter;
  String _searchQuery = '';

  ExamProvider({required this.repository});

  List<Exam> get exams => _filteredExams;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> loadExams() async {
    _isLoading = true;
    _error = '';
    notifyListeners();

    try {
      _exams = await repository.fetchExams();
      _applyFilters();
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void setStatusFilter(ExamStatus? status) {
    _statusFilter = status;
    _applyFilters();
    notifyListeners();
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
    notifyListeners();
  }

  void _applyFilters() {
    _filteredExams = _exams.where((exam) {
      final matchesStatus =
          _statusFilter == null || exam.status == _statusFilter;
      final matchesSearch = exam.title.toLowerCase().contains(
        _searchQuery.toLowerCase(),
      );
      return matchesStatus && matchesSearch;
    }).toList();
  }
}
