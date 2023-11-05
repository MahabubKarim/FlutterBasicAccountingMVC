import 'transaction.dart';

class TransactionClient {
  var store = Map<int, Transaction>();
  int counter = 0;

  TransactionClient() {
    Transaction transaction;
    transaction = new Transaction();
    transaction.id = ++counter;
    transaction.accountId = 1;
    transaction.date = DateTime.now();
    transaction.debit = 1000000;
    transaction.credit = 0;
    transaction.balance = 1000000;
    store[transaction.accountId] = transaction;

    transaction = new Transaction();
    transaction.id = ++counter;
    transaction.accountId = 2;
    transaction.date = DateTime.now();
    transaction.debit = 0;
    transaction.credit = 500000;
    transaction.balance = 500000;
    store[transaction.accountId] = transaction;

    transaction = new Transaction();
    transaction.id = ++counter;
    transaction.accountId = 3;
    transaction.date = DateTime.now();
    transaction.debit = 10000;
    transaction.credit = 0;
    transaction.balance = 5010000;
    store[transaction.accountId] = transaction;

    transaction = new Transaction();
    transaction.id = ++counter;
    transaction.accountId = 4;
    transaction.date = DateTime.now();
    transaction.debit = 0;
    transaction.credit = 50000;
    transaction.balance = 4060000;
    store[transaction.accountId] = transaction;
  }

  Transaction getTransaction(int id) {
    return store[id];
  }

  List<Transaction> listTransactions() {
    List<Transaction> list = store.entries.map((e) => e.value).toList();
    return list;
  }

  Transaction createTransaction(Transaction transaction) {
    transaction.accountId = ++counter;
    store[transaction.accountId] = transaction;
    return transaction;
  }

  Transaction updateTransaction(Transaction transaction) {
    store[transaction.accountId] = transaction;
    return transaction;
  }

  Transaction deleteTransaction(Transaction transaction) {
    store.remove(transaction.accountId);
    return transaction;
  }
}
