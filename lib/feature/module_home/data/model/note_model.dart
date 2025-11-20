import 'package:hive_ce/hive.dart';

import '../../domain/entity/note.dart';

part 'note_model.g.dart';

@HiveType(typeId: 0)
class NoteModel {
  @HiveField(0)
  final String noteId;
  @HiveField(1)
  final String noteTitle;
  @HiveField(2)
  final String noteContent;
  @HiveField(3)
  final String relatedEventId;

  const NoteModel({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.relatedEventId,
  });

  // ----------------------------------- ENTITY -----------------------------------
  Note toEntity() {
    return Note(
      noteId: noteId,
      noteTitle: noteTitle,
      noteContent: noteContent,
      relatedEventId: relatedEventId,
    );
  }

  factory NoteModel.fromEntity(Note note) {
    return NoteModel(
      noteId: note.noteId,
      noteTitle: note.noteTitle,
      noteContent: note.noteContent,
      relatedEventId: note.relatedEventId,
    );
  }
  // ----------------------------------- HIVE -----------------------------------
}
