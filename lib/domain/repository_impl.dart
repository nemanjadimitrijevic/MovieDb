import 'package:hive_flutter/adapters.dart';
import 'package:movies/domain/repository_interface.dart';

class HiveRepository<T> implements IRepository<T> {
  final Box _box;

  HiveRepository(this._box);

  @override
  Future<T> get(dynamic id) async {
    // if (boxIsClosed) {
    //   return;
    // }

    return _box.get(id);
  }

  @override
  Future<void> add(T object) async {
    if (boxIsClosed) {
      return;
    }

    await _box.add(object);
  }

  bool get boxIsClosed => !(_box.isOpen);
}
