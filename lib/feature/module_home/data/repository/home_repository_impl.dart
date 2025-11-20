import 'package:employee_app/feature/module_home/data/data_source/home_data_source.dart';
import 'package:employee_app/feature/module_home/domain/entity/note.dart';
import 'package:employee_app/feature/module_home/domain/repository/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeDataSource homeDataSource;

  HomeRepositoryImpl(this.homeDataSource);

  @override
  Future<List<Note>>? getNotes() {
    final notes = homeDataSource.getNoteList();
    return null;
  }
}
