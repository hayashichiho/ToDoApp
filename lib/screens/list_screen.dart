import 'package:flutter/material.dart';

import '../screens/add_todo_screen.dart';
import '../services/todo_service.dart';
import '../widgets/todo_list.dart';
import '../widgets/weather.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key, required this.todoService});

  final TodoService todoService;

  @override
  State<ListScreen> createState() => ListScreenState();
}

class ListScreenState extends State<ListScreen> {
  final _todoListKey = GlobalKey<TodoListState>();
  int _selectedColor = 0xFF2196F3; // 初期色は青

  Widget _colorCircle(BuildContext context, int colorValue) {
    return GestureDetector(
      onTap: () => Navigator.of(context).pop(colorValue),
      child: CircleAvatar(
        backgroundColor: Color(colorValue),
        radius: 20,
        child: _selectedColor == colorValue
            ? const Icon(Icons.check, color: Colors.white)
            : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TODOリスト')),
      body: Column(
        children: [
          Expanded(
            child: TodoList(
              key: _todoListKey,
              todoService: widget.todoService,
              selectedColor: _selectedColor,
            ),
          ),
          // 下部の情報表示エリア
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                // 左下：天気情報
                Container(
                  padding: const EdgeInsets.all(8), // 内側の余白
                  // 外側の余白
                  decoration: BoxDecoration(
                    color: Colors.white, // 背景色
                    borderRadius: BorderRadius.circular(12), // 角丸
                    boxShadow: [
                      // 影の設定
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Weather(),
                ),
                const Spacer(),
                // 右下：追加ボタン
                FloatingActionButton(
                  onPressed: () async {
                    final newTodo = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddTodoScreen(
                          todoService: widget.todoService,
                          selectedColor: _selectedColor,
                        ),
                      ),
                    );
                    if (newTodo != null) {
                      _todoListKey.currentState?.addTodo(newTodo);
                    }
                  },
                  child: const Icon(Icons.add),
                ),
                //色選択ボタン
                IconButton(
                  icon: const Icon(Icons.color_lens, color: Colors.black),
                  onPressed: () async {
                    // 色選択ダイアログを表示
                    final color = await showDialog<int>(
                      context: context,
                      builder: (context) {
                        return SimpleDialog(
                          title: const Text('色を選択'),
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                _colorCircle(context, 0xFF2196F3), // 青
                                _colorCircle(context, 0xFFFF9800), // オレンジ
                                _colorCircle(context, 0xFF4CAF50), // 緑
                                _colorCircle(context, 0xFFF44336), // 赤
                              ],
                            ),
                          ],
                        );
                      },
                    );
                    if (color != null) {
                      setState(() {
                        _selectedColor = color;
                      });
                    }
                  },
                  tooltip: '色選択',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
