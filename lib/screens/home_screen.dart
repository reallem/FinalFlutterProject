import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/add'),
              child: Text('Add Task'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/display'),
              child: Text('View Tasks'),
            ),
          ],
        ),
      ),
    );
  }
}

