import 'package:accounting/persistence/contract.dart';
import 'package:accounting/prototype/account_type.dart' as pb;
import 'package:accounting/service/abstract_model.dart';
import 'package:accounting/service/model.dart';

class AccountType extends AbstractModel {
  static String getRuntimeType(){
    return AccountType().runtimeType.toString();
  }

  int id;
  String name;

  AccountType();

  Map<String, dynamic> toEntity() {
    var map = Map<String, dynamic>();
    if (id != null) {
      map[Model.ID] = id;
    }
    map[AccountTypeColumn.NAME] = name;
    return map;
  }

  // Extract a Account object from a Map object
  AccountType.toEntity(Map<String, dynamic> map) {
    this.id = map[Model.ID];
    this.name = map[AccountTypeColumn.NAME];
  }

  AccountType.of(pb.AccountType account){
    this.id = account.id;
    this.name = account.name;
  }

  static pb.AccountType toMessage(AccountType account) {
    pb.AccountType account = pb.AccountType();
    account.id = account.id;
    account.name = account.name;
    return account;
  }
}
