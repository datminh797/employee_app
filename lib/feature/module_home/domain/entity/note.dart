import 'package:equatable/equatable.dart';

class Note extends Equatable {
  final String noteId;
  final String noteTitle;
  final String noteContent;
  final String relatedEventId;

  const Note({
    required this.noteId,
    required this.noteTitle,
    required this.noteContent,
    required this.relatedEventId,
  });

  @override
  List<Object?> get props => [
        noteId,
        noteTitle,
        noteContent,
        relatedEventId,
      ];
}
