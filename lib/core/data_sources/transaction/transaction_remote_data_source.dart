import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';

abstract class TransactionRemoteDataSource {
  Future<List<TransactionModel>> fetchTransaction();
}

class TransactionRemoteDataSourceImpl implements TransactionRemoteDataSource {
  @override
  Future<List<TransactionModel>> fetchTransaction() {
    // TODO: implement fetchTransaction
    throw UnimplementedError();
  }
}
