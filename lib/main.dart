import 'package:chatgpt/presentation/pages/chat/chat_page.dart';
import 'package:chatgpt/presentation/pages/splash/splash_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GPT',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: 'splash',
      routes: {
        'splash': (context) => const SplashPage(),
        'chat': (context) => const ChatPage(),
      },
    );
  }
}
