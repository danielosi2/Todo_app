import 'package:flutter/material.dart';
import 'package:listviewbuilder/todo_item.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const TodoApp(),
    );
  }
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<TodoApp> createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List<Todo> task = [];
  final TextEditingController taskController = TextEditingController();

  @override
  void dispose() {
    taskController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("To Do App"),
      ),
      body: ListView.builder(
        itemCount: task.length,
        itemBuilder: (context, index) {
          final item = task[index];
          return Dismissible(
            key: Key(item.toString()),
            onDismissed: (direction) {
              setState(() {
                task.removeAt(index);
              });
            },
            background: Container(color: Colors.red),
            child: Container(
              margin: EdgeInsets.all(12),
              width: double.infinity,
              height: 100,
              alignment: Alignment.center,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(12), color: Colors.greenAccent),
              child: ListTile(
                leading: Checkbox(
                  value: task[index].completed,
                  onChanged: (bool? newValue) {
                    setState(
                      () {
                        task[index].completed = newValue!;
                      },
                    );
                  },
                ),
                title: Text(
                  task[index].name,
                  style: TextStyle(
                    decoration: task[index].completed ? TextDecoration.lineThrough : TextDecoration.none,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addTask,
        child: const Icon(Icons.add),
      ),
    );
  }

  void addTask() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Task"),
          content: TextField(
            controller: taskController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Enter new task",
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  task.add(Todo(name: taskController.text));
                });
                Navigator.of(context).pop();
                taskController.clear();
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
