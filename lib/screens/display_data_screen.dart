import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayDataScreen extends StatelessWidget {
  final _supabase = Supabase.instance.client;

  Future<List<Map<String, dynamic>>> _fetchTasks() async {
    final response = await _supabase.from('tasks').select().execute();

    if (response.error != null) {
      return []; // Error occurred
    }

    if (response.data != null && response.data is List<dynamic>) {
      return (response.data as List<dynamic>).cast<Map<String, dynamic>>();
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Task List')),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError || !snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No tasks available'));
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final task = tasks[index];
              return ListTile(
                title: Text(task['title'] ?? 'Untitled'),
                subtitle: Text(task['description'] ?? 'No description'),
              );
            },
          );
        },
      ),
    );
  }
}

extension on PostgrestResponse {
  get error => null;
}


