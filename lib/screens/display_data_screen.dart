import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DisplayDataScreen extends StatelessWidget {
  final _supabase = Supabase.instance.client;

  DisplayDataScreen({super.key});

  Future<List<Map<String, dynamic>>> _fetchTasks() async {
    final response = await _supabase.from('tasks').select().execute();
    if (response.error == null && response.data != null) {
      return (response.data as List).cast<Map<String, dynamic>>();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task List'),
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _fetchTasks(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError ||
              !snapshot.hasData ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text(
                'No tasks available',
                style: TextStyle(fontSize: 18, color: Colors.black54),
              ),
            );
          }
          final tasks = snapshot.data!;
          return ListView.builder(
            itemCount: tasks.length,
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              final task = tasks[index];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 10),
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  title: Text(
                    task['title'] ?? 'Untitled',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(task['description'] ?? 'No description'),
                  leading: const Icon(Icons.task, color: Colors.indigo),
                ),
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
