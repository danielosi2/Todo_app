import 'package:flutter/material.dart';

class TodoBox extends StatefulWidget {
  const TodoBox({super.key});

  @override
  State<TodoBox> createState() => _TodoBoxState();
}

class _TodoBoxState extends State<TodoBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12)
      ),
    );
  }
}
