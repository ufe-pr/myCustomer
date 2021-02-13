import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/data_sources/transaction/transaction_local_data_source.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SelectTransactionViewModel extends ReactiveViewModel{
  final _transactionService = locator<TransactionLocalDataSourceImpl>();
  final NavigationService _navigationService = locator<NavigationService>();

  List<TransactionModel> get debitList => _transactionService.debitlist;
  List<TransactionModel> get creditList => _transactionService.creditlist;

  void setTransaction(TransactionModel transaction, String action){
    _transactionService.setTransaction(transaction);
    action == 'credit' ? _navigationService.navigateTo(Routes.selectRouteCredit) : _navigationService.navigateTo(Routes.selectRouteDebt);
  }

  void navigateNotSelect(String action) {
    action == 'credit' ? _navigationService.navigateTo(Routes.addCredit) : _navigationService.navigateTo(Routes.addDebt);
  }

  @override
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_transactionService];
  
}