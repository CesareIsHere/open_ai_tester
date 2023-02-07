import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:open_ai_tester/models/openai_variables_model.dart';
import 'package:open_ai_tester/pages/chat.dart';
import 'package:open_ai_tester/pages/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  // register shared preferences
  GetIt.I.registerSingleton<SharedPreferences>(prefs);

  GetIt.I.registerSingleton<OpenAiVariablesModel>(OpenAiVariablesModel.fromJson(
      jsonDecode(prefs.getString("openAiVariables") ?? "{}")));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OpenAi Tester',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/settings':
            return MaterialPageRoute(
              builder: (context) => const SettingsPage(),
            );
          default:
            return MaterialPageRoute(
              builder: (context) => const ChatPage(),
            );
        }
      },
      home: const ChatPage(),
    );
  }
}
