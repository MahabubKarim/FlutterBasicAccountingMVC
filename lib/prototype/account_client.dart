import 'account.dart';

class AccountClient {
    var store = Map<int, Account>();
    int counter = 0;

    AccountClient() {
      Account account;
      account = new Account();
      account.id = ++counter;
      account.code = "1001";
      account.name = "Petty Cash";
      account.typeId = 1;
      store[account.id] = account;

      account = new Account();
      account.id = ++counter;
      account.code = "1002";
      account.name = "Loan";
      account.typeId = 2;
      store[account.id] = account;
    }

    Account getAccount(int id) {
      return store[id];
    }

    List<Account> listAccounts() {
      List<Account> list = store.entries.map((e) => e.value).toList();
      return list;
    }

    Account createAccount(Account account) {
      account.id = ++counter;
      store[account.id]= account ;
      return account;
    }

    Account updateAccount(Account account) {
      store[account.id] = account;
      return account;
    }

    Account deleteAccount(Account account) {
      store.remove(account.id);
      return account;
    }

}