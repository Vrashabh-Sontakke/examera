enum ExamStatus { upcoming, ongoing, past }

class Exam {
  final int id;
  final String title;
  final String? description;
  final DateTime? examDate;
  final DateTime? applicationDeadline;
  final String? applicationLink;
  final String? officialWebsite;
  final String? syllabusLink;
  final String? eligibility;
  final Map<String, dynamic>? fee;
  final ExamStatus status;

  Exam({
    required this.id,
    required this.title,
    this.description,
    this.examDate,
    this.applicationDeadline,
    this.applicationLink,
    this.officialWebsite,
    this.syllabusLink,
    this.eligibility,
    this.fee,
    required this.status,
  });

  factory Exam.fromJson(Map<String, dynamic> json) {
    return Exam(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      examDate: json['exam_date'] != null
          ? DateTime.parse(json['exam_date'])
          : null,
      applicationDeadline: json['application_deadline'] != null
          ? DateTime.parse(json['application_deadline'])
          : null,
      applicationLink: json['application_link'],
      officialWebsite: json['official_website'],
      syllabusLink: json['syllabus_link'],
      eligibility: json['eligibility'],
      fee: json['fee'],
      status: ExamStatus.values.firstWhere(
        (e) => e.toString().split('.').last == json['status'],
        orElse: () => ExamStatus.upcoming,
      ),
    );
  }
}
