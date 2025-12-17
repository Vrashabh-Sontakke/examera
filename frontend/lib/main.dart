import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'core/router.dart';
import 'features/exam/presentation/exam_provider.dart';
import 'features/exam/data/exam_repository.dart';
import 'features/subscription/subscription_provider.dart';

void main() {
  // Use http://10.0.2.2:8080 for Android Emulators
  // Use http://localhost:8080 for Web and iOS Emulators
  String baseUrl = 'http://localhost:8080';
  if (!kIsWeb && Platform.isAndroid) {
    baseUrl = 'http://10.0.2.2:8080';
  }

  final examRepository = ExamRepository(baseUrl: baseUrl);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => ExamProvider(repository: examRepository)..loadExams(),
        ),
        ChangeNotifierProvider(create: (_) => SubscriptionProvider()),
      ],
      child: const ExameraApp(),
    ),
  );
}

class ExameraApp extends StatelessWidget {
  const ExameraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Examera',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.light,
        ),
        textTheme: GoogleFonts.interTextTheme(),
      ),
      routerConfig: router,
    );
  }
}
