import 'package:accounting/account/account.dart';
import 'package:accounting/prototype/account.dart' as pb;
import 'package:accounting/prototype/account_client.dart';
import 'package:accounting/service/abstract_service.dart';
import 'model.dart';

class AccountService extends AbstractService<Account>{
  AccountClient accountClient = AccountClient();

  static void sync() async {
      AccountClient client = AccountClient();
      AccountService service = new AccountService();
      for(pb.Account account in client.listAccounts()) {
          service.createAccount(Account.of(account));
      }
  }

  @override
  Account getModel() {
    return Account();
  }

  @override
  Account toEntity(Map<String, dynamic> map) {
    return Account.toEntity(map);
  }

  Future<Account> getAccount(int id) async {
    return await this.readById(id);
  }

  Future<List<Account>> listAccounts() async {
    return await this.readAll();
  }

  void createAccount(Account account) {
    this.create(account);
    //store.insertAccount(account);
     //accountClient.createAccount(account.toMessage());
  }

  void updateAccount(Account account) async {
    await this.merge(account);
    // accountClient.updateAccount(account);
  }

  void deleteAccount(Account account) async {
    await this.purge(account);
    // accountClient.deleteAccount(account);
  }

}
