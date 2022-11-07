import 'package:hive_flutter/adapters.dart';
import 'package:movies/domain/genre.dart';
import 'package:movies/repository/repository_box.dart';

class GenresBox extends RepositoryBox {
  @override
  var box = Hive.openBox<Genre>("genres_box");
}
