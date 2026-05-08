import 'package:flutter/material.dart';
import '../models/submission.dart';
import '../services/submission_service.dart';
import 'submission_form_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubmissionListScreen extends StatefulWidget {
  const SubmissionListScreen({super.key});

  @override
  State<SubmissionListScreen> createState() => _SubmissionListScreenState();
}

class _SubmissionListScreenState extends State<SubmissionListScreen> {
  late final SubmissionService _submissionService;

  @override
  void initState() {
    super.initState();
    _submissionService = SubmissionService(Supabase.instance.client);
  }

  Future<void> _deleteSubmission(int id) async {
    try {
      await _submissionService.deleteSubmission(id);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Submission Deleted')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Submissions'),
      ),
      body: StreamBuilder<List<Submission>>(
        stream: _submissionService.watchSubmissions(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final submissions = snapshot.data!;
          if (submissions.isEmpty) {
            return const Center(child: Text('No submissions yet.'));
          }
          return ListView.builder(
            itemCount: submissions.length,
            itemBuilder: (context, index) {
              final submission = submissions[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(submission.fullName),
                  subtitle: Text('${submission.email}\n${submission.phoneNumber}'),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SubmissionFormScreen(submission: submission),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () => _showDeleteDialog(submission.id!),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SubmissionFormScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showDeleteDialog(int id) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Submission'),
        content: const Text('Are you sure you want to delete this submission?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _deleteSubmission(id);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
