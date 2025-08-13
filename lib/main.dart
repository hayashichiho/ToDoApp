import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'screens/list_screen.dart';
import 'services/todo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env"); // ← ファイル名を明示
  print('API_KEY: ${dotenv.env['API_KEY']}'); // デバッグ用

  final prefs = await SharedPreferences.getInstance();
  final todoService = TodoService(prefs);
  runApp(MyApp(todoService: todoService));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.todoService});

  final TodoService todoService; // TodoService のインスタンス

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ListScreen(todoService: todoService),
    ); // ListScreen を表示
  }
}
