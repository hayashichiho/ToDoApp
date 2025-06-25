import 'package:flutter/material.dart'; // Flutterの基本パッケージ
import 'package:shared_preferences/shared_preferences.dart'; // 端末にデータを保存するためのパッケージ

import 'screens/list_screen.dart';
import 'services/todo_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutterの初期化
  final prefs =
      await SharedPreferences.getInstance(); // SharedPreferences のインスタンスを取得

  final todoService = TodoService(prefs); // Todoserviceのインスタンスを作成

  runApp(MyApp(todoService: todoService)); // MyApp を起動
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
