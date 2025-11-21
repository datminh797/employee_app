import '../model/note_model.dart';

abstract class HomeDataSource {
  List<NoteModel>? getNoteList();
  NoteModel? getNote(String noteId);
  void addNote(NoteModel noteModel);
  void updateNote(NoteModel noteModel);
  void deleteNote(String noteId);
}
