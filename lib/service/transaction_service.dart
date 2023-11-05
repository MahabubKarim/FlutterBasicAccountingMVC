import 'package:accounting/account/transaction.dart';
import 'package:accounting/prototype/transaction.dart' as pb;
import 'package:accounting/prototype/transaction_client.dart';
import 'package:accounting/service/abstract_service.dart';

class TransactionService extends AbstractService<Transaction> {
  TransactionClient transactionClient = TransactionClient();

  static void sync() async {
    TransactionClient client = TransactionClient();
    TransactionService service = new TransactionService();
    for (pb.Transaction transaction in client.listTransactions()) {
      service.createTransaction(Transaction.of(transaction));
    }
  }

  @override
  Transaction getModel() {
    return Transaction();
  }

  @override
  Transaction toEntity(Map<String, dynamic> map) {
    return Transaction.toEntity(map);
  }

  Transaction getTransaction(int id)  {
    return Transaction.of(transactionClient.getTransaction(id));
    // return await this.readById(id);
  }

  List<Transaction> listTransactions()  {
    List<Transaction> transactions = List<Transaction>();
    for (pb.Transaction transaction in transactionClient.listTransactions()) {
      transactions.add(Transaction.of(transaction));
    }
    return transactions;
    // return await this.readAll();
  }

  void createTransaction(Transaction transaction) {
    // this.create(transaction);
    // store.insertTransaction(transaction);
    transactionClient.createTransaction(transaction.toMessage());
  }

  void updateTransaction(Transaction transaction) async {
    // await this.merge(transaction);
    transactionClient.updateTransaction(transaction.toMessage());
  }

  void deleteTransaction(Transaction transaction) async {
    await this.purge(transaction);
    transactionClient.deleteTransaction(transaction.toMessage());
  }

}
