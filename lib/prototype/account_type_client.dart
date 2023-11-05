import 'package:accounting/prototype/account_type.dart';

class AccountTypeClient {
    var store = Map<int, AccountType>();
    int counter = 0;

    AccountTypeClient() {
      AccountType accountType;
      accountType = new AccountType();
      accountType.id = ++counter;
      accountType.name = "Asset";
      store[accountType.id] = accountType;

      accountType = new AccountType();
      accountType.id = ++counter;
      accountType.name = "Liability";
      store[accountType.id] = accountType;

      accountType = new AccountType();
      accountType.id = ++counter;
      accountType.name = "Equity";
      store[accountType.id] = accountType;

      accountType = new AccountType();
      accountType.id = ++counter;
      accountType.name = "Income";
      store[accountType.id] = accountType;

      accountType = new AccountType();
      accountType.id = ++counter;
      accountType.name = "Expense";
      store[accountType.id] = accountType;
    }

    AccountType getAccountType(int id) {
      return store[id];
    }

    List<AccountType> listAccountTypes() {
      List<AccountType> list = store.entries.map((e) => e.value).toList();
      return list;
    }

    AccountType createAccountType(AccountType accountType) {
      accountType.id = ++counter;
      store[accountType.id]= accountType ;
      return accountType;
    }

    AccountType updateAccountType(AccountType accountType) {
      store[accountType.id] = accountType;
      return accountType;
    }

    AccountType deleteAccountType(AccountType accountType) {
      store.remove(accountType.id);
      return accountType;
    }

}