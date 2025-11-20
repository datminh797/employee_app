import 'package:employee_app/feature/module_home/domain/entity/note.dart';

abstract class HomeRepository {
  Future<List<Note>>? getNotes();
}
