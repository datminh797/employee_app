import 'package:employee_app/feature/module_home/data/data_source/home_data_source.dart';
import 'package:employee_app/feature/module_home/data/model/note_model.dart';
import 'package:get_it/get_it.dart';
import 'package:hive_ce/hive.dart';

class HomeDataSourceImpl extends HomeDataSource {
  final Box<NoteModel> _noteBox = GetIt.instance<Box<NoteModel>>(instanceName: 'NoteBox');

  @override
  List<NoteModel> getNoteList() {
    return _noteBox.values.toList();
  }

  @override
  NoteModel? getNote(String noteId) {
    return _noteBox.get(noteId);
  }

  @override
  void addNote(NoteModel noteModel) {
    _noteBox.add(noteModel);
  }

  @override
  void deleteNote(String noteId) async {
    await _noteBox.delete(noteId);
  }

  @override
  void updateNote(NoteModel noteModel) async {
    await _noteBox.put(noteModel.noteId, noteModel);
  }
}
