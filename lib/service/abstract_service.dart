import 'package:accounting/persistence/abstract_store.dart';
import 'package:accounting/service/model.dart';

abstract class AbstractService<T extends Model> extends AbstractStore<T>{

  Future<T> getById(int id) async {
    return await this.readById(id);
  }

  Future<List<T>> getAll() async {
    return await this.readAll();
  }

  void create(T account) {
    this.insert(account);
  }

  void update(T account) async {
    await this.merge(account);
  }

  void delete(T account) async {
    await this.purge(account);
  }

  fetch(Map<String, dynamic> map){}

}