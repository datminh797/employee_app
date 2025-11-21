import 'package:employee_app/feature/module_home/domain/repository/home_repository.dart';

import '../entity/note.dart';

class GetNoteUseCase {
  HomeRepository homeRepository;
  GetNoteUseCase(this.homeRepository);

  Future<List<Note>> call() async {
    final List<Note> noteList = await homeRepository.getNotes()!;

    return noteList;
  }
}
