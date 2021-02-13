import 'package:hive/hive.dart';
import 'package:mycustomers/core/repositories/transaction/transaction_repository.dart';

class TransactionRepositoryImpl implements TransactionRepository {
  @override
  Future<void> addTransaction(HiveObject newObject) {
      // TODO: implement addTransaction
      throw UnimplementedError();
    }
  
    @override
    Future<List<HiveObject>> getTransactions(int id) {
    // TODO: implement getTransactions
    throw UnimplementedError();
  }
}