import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'providers/question_bank_provider.dart';
import 'providers/quiz_provider.dart';
import 'providers/session_provider.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const NcsApp());
}

class NcsApp extends StatelessWidget {
  const NcsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SessionProvider()),
        ChangeNotifierProvider(create: (_) => QuestionBankProvider()..load()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: MaterialApp(
        title: 'NCS 직업기초능력 훈련',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorSchemeSeed: Colors.indigo,
          useMaterial3: true,
          visualDensity: VisualDensity.comfortable,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.indigo,
            foregroundColor: Colors.white,
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
