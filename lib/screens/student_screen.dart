import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_app/models/student_model.dart';
import 'package:riverpod_app/view_model/student_view_model.dart';

class StudentScreen extends ConsumerStatefulWidget {
  const StudentScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _StudentScreenState();
}

class _StudentScreenState extends ConsumerState<StudentScreen> {
  final _gap = const SizedBox(height: 8);
  final _fnameController = TextEditingController();
  final _lnameController = TextEditingController();

  void _editStudent(int index, Student student) {
    _fnameController.text = student.fname;
    _lnameController.text = student.lname;

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Student'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _fnameController,
                decoration: const InputDecoration(
                  hintText: 'First Name',
                  border: OutlineInputBorder(),
                ),
              ),
              _gap,
              TextFormField(
                controller: _lnameController,
                decoration: const InputDecoration(
                  hintText: 'Last Name',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
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
                final updatedStudent = Student(
                  fname: _fnameController.text,
                  lname: _lnameController.text,
                );
                ref
                    .read(studentViewModelProvider.notifier)
                    .updateStudent(index, updatedStudent);
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final studentState = ref.watch(studentViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _fnameController,
              decoration: const InputDecoration(
                hintText: 'First Name',
                border: OutlineInputBorder(),
              ),
            ),
            _gap,
            TextFormField(
              controller: _lnameController,
              decoration: const InputDecoration(
                hintText: 'Last Name',
                border: OutlineInputBorder(),
              ),
            ),
            _gap,
            ElevatedButton(
              onPressed: () {
                Student student = Student(
                  fname: _fnameController.text,
                  lname: _lnameController.text,
                );
                ref.read(studentViewModelProvider.notifier).addStudent(student);
              },
              child: const Text('Add Student'),
            ),
            _gap,
            studentState.isLoading
                ? const CircularProgressIndicator()
                : studentState.lstStudents.isEmpty
                    ? const Text('No data')
                    : Expanded(
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const Divider(),
                          itemCount: studentState.lstStudents.length,
                          itemBuilder: (context, index) {
                            Student student = studentState.lstStudents[index];
                            return ListTile(
                              tileColor: Colors.greenAccent,
                              title: Text(student.fname),
                              subtitle: Text(student.lname),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      _editStudent(index, student);
                                    },
                                    color: Colors.blue,
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete),
                                    onPressed: () {
                                      ref
                                          .read(
                                              studentViewModelProvider.notifier)
                                          .deleteStudent(index);
                                    },
                                    color: Colors.red,
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}
