import 'package:riverpod_app/models/student_model.dart';


class StudentState {
  final bool isLoading;
  final List<Student> lstStudents;

  StudentState({
    required this.isLoading,
    required this.lstStudents,
  });

  factory StudentState.initial() {
    return StudentState(isLoading: false, lstStudents: []);
  }

  StudentState copyWith({
    bool? isLoading,
    List<Student>? lstStudents,
  }) {
    return StudentState(
      isLoading: isLoading ?? this.isLoading,
      lstStudents: lstStudents ?? this.lstStudents,
    );
  }

  StudentState addStudent({required bool isLoading, required Student student}) {
    return StudentState(
      isLoading: isLoading,
      lstStudents: List.from(lstStudents)..add(student),
    );
  }

  StudentState deleteAt({required bool isLoading, required int index}) {
    return StudentState(
      isLoading: isLoading,
      lstStudents: List.from(lstStudents)..removeAt(index),
    );
  }

  StudentState updateAt(
      {required bool isLoading, required int index, required Student student}) {
    var updatedList = List<Student>.from(lstStudents);
    updatedList[index] = student;
    return StudentState(
      isLoading: isLoading,
      lstStudents: updatedList,
    );
  }
}