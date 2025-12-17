import 'dart:convert';
import 'package:http/http.dart' as http;
import '../domain/exam_model.dart';

class ExamRepository {
  final String baseUrl;

  ExamRepository({required this.baseUrl});

  Future<List<Exam>> fetchExams() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/exams'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Exam.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load exams');
      }
    } catch (e) {
      throw Exception('Connection error: $e');
    }
  }
}
