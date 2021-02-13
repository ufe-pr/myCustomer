import 'package:hive/hive.dart';

abstract class TransactionRepository<T extends HiveObject> {
  Future<void> addTransaction(T newObject);
  
  Future<List<T>> getTransactions(int id);
}