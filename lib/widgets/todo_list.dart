import 'package:flutter/material.dart';

import '../models/todo.dart';
import '../services/todo_service.dart';
import 'todo_card.dart';

class TodoList extends StatefulWidget {
  const TodoList({
    super.key,
    required this.todoService,
    required this.selectedColor,
  });

  final TodoService todoService;
  final int selectedColor;

  @override
  State<TodoList> createState() => TodoListState();
}

class TodoListState extends State<TodoList> {
  List<Todo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState(); // 初期化処理
    _loadTodos(); // TODOリスト読み込み
  }

  // 初期化時にTODOリストを読み込む関数
  Future<void> _loadTodos() async {
    final todos = await widget.todoService.getTodos(); // TODOリストを取得

    // 状態を更新
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  // 新しいTODOを追加する関数
  void addTodo(Todo newTodo) async {
    setState(() => _todos.add(newTodo));
    await widget.todoService.saveTodos(_todos);
  }

  // TODOを削除する関数
  Future<void> _deleteTodo(Todo todo) async {
    setState(() => _todos.removeWhere((t) => t.id == todo.id));
    await widget.todoService.saveTodos(_todos);
  }

  void _toggleTodo(Todo todo) async {
    setState(() {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(isCompleted: !todo.isCompleted);
      }
    });
    await widget.todoService.saveTodos(_todos);
  }

  @override
  // ビルドメソッド
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView.builder(
      itemCount: _todos.length,
      itemBuilder: (context, index) {
        final todo = _todos[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: TodoCard(
            todo: todo,
            selectedColor: widget.selectedColor,
            onToggle: () => _toggleTodo(todo),
            onDelete: () => _deleteTodo(todo),
          ),
        );
      },
    );
  }
}
