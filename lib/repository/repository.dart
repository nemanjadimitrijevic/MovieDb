import 'package:hive_flutter/adapters.dart';
import 'package:movies/repository/repository_box.dart';

class Repository<T extends Object?, S extends RepositoryBox> {
  late S _boxWrapper;

  Repository(S customBoxWrapper) {
    _boxWrapper = customBoxWrapper;
  }

  Future<void> save(T? newObject) async {
    final box = await _boxWrapper.box;
    box.add(newObject);
  }

  Future<void> put(dynamic key, T? newObject) async {
    final Box box = await _boxWrapper.box;
    box.put(key, newObject);
  }

  Future<void> saveAll(List<T?> newList) async {
    final Box box = await _boxWrapper.box;
    box.putAll(newList.asMap());
  }

  Future<T?> get(dynamic key) async {
    final box = await _boxWrapper.box;
    return box.get(key);
  }

  Future<List<T>?> getAll() async {
    final box = await _boxWrapper.box;
    return box.values.toList();
  }

  Future<void> delete(T? objectToDelete) async {
    final box = await _boxWrapper.box;
    await box.delete(objectToDelete);
  }

  Future<void> deleteKey(dynamic key) async {
    final box = await _boxWrapper.box;
    box.delete(key);
  }

  Future<void> clear() async {
    final box = await _boxWrapper.box;
    await box.clear();
  }
}
