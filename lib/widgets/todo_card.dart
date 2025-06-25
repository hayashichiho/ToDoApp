import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // 日付フォーマット用パッケージ

import '../models/todo.dart';

class TodoCard extends StatelessWidget {
  final Todo todo; // 表示する Todo データ
  final VoidCallback? onToggle; // 完了トグル用コールバック
  final VoidCallback? onDelete; // 削除用コールバック（必要に応じて追加）
  final int selectedColor;
  const TodoCard({
    super.key,
    required this.todo,
    this.onToggle,
    this.onDelete,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: todo.isCompleted
          ? const Color.fromARGB(255, 44, 47, 45)
          : Color(selectedColor),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 8, // カードの影の深さ

      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 左：完了ボタン・右：削除ボタン
            IconButton(
              iconSize: 32,
              icon: Icon(
                todo.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: Colors.white,
              ),
              onPressed: onToggle,
              tooltip: '完了',
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    todo.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    todo.detail,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                  Text(
                    DateFormat('M月d日(E)').format(todo.dueDate),
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ],
              ),
            ),
            IconButton(
              iconSize: 32,
              icon: const Icon(Icons.delete, color: Colors.white),
              onPressed: onDelete,
              tooltip: '削除',
            ),
          ],
        ),
      ),
    );
  }
}
