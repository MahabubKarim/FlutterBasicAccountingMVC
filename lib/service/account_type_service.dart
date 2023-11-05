import 'package:accounting/prototype/account_type.dart' as pb;
import 'package:accounting/account/account_type.dart';
import 'package:accounting/prototype/account_type_client.dart';
import 'package:accounting/service/abstract_service.dart';

import 'model.dart';

class AccountTypeService extends AbstractService<AccountType> {
  AccountTypeClient accountClient = AccountTypeClient();

  static void sync() {
      AccountTypeClient client = AccountTypeClient();
      AccountTypeService service = AccountTypeService();
      for(pb.AccountType accountType in client.listAccountTypes()) {
          service.createAccountType(AccountType.of(accountType));
      }
  }

  @override
  Model getModel() {
    return AccountType();
  }

  @override
  Model toEntity(Map<String, dynamic> map) {
    return AccountType.toEntity(map);
  }

  Future<AccountType> getAccountType(int id) async {
    return await this.getById(id);
  }

  Future<List<AccountType>> listAccountTypes() async {
    return await this.getAll();
  }

 /* Future<List<AccountType>> listAccountTypes() async {
    List<AccountType> accountList = List<AccountType>();
    await this.persistence.database.then((db) async => {
      await db.query(getModelName()).then((values) => {
        for (var value in values) {
           accountList.add(AccountType.fetch(value))
        }
      })
    });
    return accountList;
  }*/

  void createAccountType(AccountType account) {
    // accountClient.createAccount(account);
    this.create(account);
  }

  void updateAccountType(AccountType account) async {
    this.update(account);
    // accountClient.updateAccountType(account);
  }

  void deleteAccountType(AccountType account)  {
    this.delete(account);
    //await store.deleteAccountType(account);
    //accountClient.deleteAccountType(AccountType.toMessage(account));
  }
}
