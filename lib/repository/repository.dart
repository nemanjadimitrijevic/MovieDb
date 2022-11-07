import 'package:hive_flutter/adapters.dart';
import 'package:movies/repository/repository_box.dart';

class Repository<T extends HiveObject?, S extends RepositoryBox> {
  late S _boxWrapper;

  Repository(S customBoxWrapper) {
    _boxWrapper = customBoxWrapper;
  }

  Future<void> save(T? newObject) async {
    final box = await _boxWrapper.box;
    box.add(newObject);
  }

  Future<void> saveAll(List<T?>? newList) async {
    final box = await _boxWrapper.box;
    newList?.forEach((element) {
      box.add(element);
    });
  }

  Future<T?> get() async {
    final box = await _boxWrapper.box;
    return box.values;
  }

  Future<List<T>?> getAll() async {
    final box = await _boxWrapper.box;
    return box.values.toList();
  }

  Future<void> clear() async {
    final box = await _boxWrapper.box;
    await box.clear();
  }
}
