import 'package:accounting/persistence/contract.dart';
import 'package:accounting/prototype/account.dart' as pb;
import 'package:accounting/service/abstract_model.dart';
import 'package:accounting/service/model.dart';

class Account extends AbstractModel {
  static String getRuntimeType() {
    return Account().runtimeType.toString();
  }

  String code;
  String name;
  int typeId;

  Account();

  // Convert a Account object into a Map object
  Map<String, dynamic> toEntity() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[Model.ID] = id;
    }
    map[AccountColumn.CODE] = code;
    map[AccountColumn.NAME] = name;
    map[AccountColumn.TYPE_ID] = typeId;
    return map;
  }

  // Extract a Account object from a Map object
  Account.toEntity(Map<String, dynamic> map) {
    this.id = map[Model.ID];
    this.code = map[AccountColumn.CODE];
    this.name = map[AccountColumn.NAME];
    this.typeId = map[AccountColumn.TYPE_ID];
  }

  Account.of(pb.Account account){
    this.id = account.id;
    this.code = account.code;
    this.name = account.name;
    this.typeId = account.typeId;
  }

  pb.Account toMessage(){
    pb.Account account = pb.Account();
    account.id = this.id;
    account.name = this.name;
    account.code = this.code;
    account.typeId = this.typeId;
    return account;
  }
}
