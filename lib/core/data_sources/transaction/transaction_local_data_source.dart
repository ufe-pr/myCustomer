import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/transaction/transaction_model_h.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

abstract class TransactionDataSource{
  Future<void> init();
}


@lazySingleton
class TransactionLocalDataSourceImpl extends TransactionDataSource with ReactiveServiceMixin {
  static const String _boxname = "transactionBox";
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.transaction);
  Box<TransactionModel> get _transactionBox => _hiveService.box<TransactionModel>(HiveBox.transaction);

  RxValue<List<TransactionModel>> _alltransactions = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get alltransactions => _alltransactions.value;

  RxValue<double> _whatyouowe = RxValue<double>(initial: 0);
  double get whatyouowe => _whatyouowe.value;

  RxValue<List<TransactionModel>> _transactions = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get transactions => _transactions.value;

  RxValue<List<TransactionModel>> _debitlist = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get debitlist => _debitlist.value;

  RxValue<List<TransactionModel>> _creditlist = RxValue<List<TransactionModel>>(initial: []);
  List<TransactionModel> get creditlist => _creditlist.value;

  RxValue<List<TransactionModel>> _owingcustomers = RxValue<List<TransactionModel>>(initial: []);
  List get owingcustomers => _owingcustomers.value;

  RxValue<List<TransactionModel>> _owedcustomers = RxValue<List<TransactionModel>>(initial: []);
  List get owedcustomers => _owedcustomers.value;

  List<String> formattedate = [];
  String date;
  
  get box => _hiveService.openBox<TransactionModel>(HiveBox.transaction);
//   var box = Hive.openBox<TransactionModel>(_boxname);

  RxValue<TransactionModel> _stransaction = RxValue<TransactionModel>(initial: null);
  TransactionModel get stransaction => _stransaction.value;


  TransactionLocalDataSourceImpl(){
    listenToReactiveValues([_transactions, _debitlist, _creditlist, _alltransactions]);
  }

  @override
  Future<void> init() async {
    _hiveService.registerAdapter(TransactionAdapter());

    if (!_isBoxOpen) {
      await box;
    }
  }

  void setTransaction(TransactionModel transaction){
    _stransaction.value = transaction;
  }

  void getAllTransactions(String id) async{
    //final bbox = await box;
    _alltransactions.value = [];
    for(var trans in _transactionBox.values.toList()) {
      if (trans.sId == id){
        _alltransactions.value.add(trans);
      }
    }
    _alltransactions.value = new List<TransactionModel>.from(_alltransactions.value.reversed);
    _whatyouowe.value = 0;
    _owingcustomers.value = [];
    _owedcustomers.value = [];
    for(var item in _alltransactions.value){
      if(item.amount-item.paid > 0) {
        _owingcustomers.value.add(item);
      }
      if(item.paid-item.amount > 0) {
        _owedcustomers.value.add(item);
        _whatyouowe.value += item.paid-item.amount;
      }
    }
  }
  
  void getTransactions(String id, String stid) async{
    print('get'+id.toString());
    //final bbox = await box;
    _transactions.value = [];
    for (var transaction in _transactionBox.values.toList()) {
      if (transaction.cId == id && transaction.sId == stid){
        _transactions.value.add(transaction);
        print(transaction.boughtdate);
      }
    }
    _debitlist.value = [];
    _creditlist.value = [];
    for(var transactionb in _transactions.value){
      if(transactionb.paid < transactionb.amount){
        _debitlist.value.add(transactionb);
      }
      if(transactionb.amount < transactionb.paid){
        _creditlist.value.add(transactionb);
      }
    }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].cId == id){
        if(transactions[i].boughtdate != null){
          for(int k = 0; k<formattedate.length; k++){
            if(formattedate[k].toString() == dformat.format(DateTime.parse(transactions[i].boughtdate)).toString()) {
              //date = dformat.format(DateTime.parse(transactions[i].boughtdate)).toString();
              //formattedate.add(date);
              isInDate = true;
            }
          }
          if(!isInDate){
            formattedate.add(dformat.format(DateTime.parse(transactions[i].boughtdate)).toString());
          }
          isInDate = false;
        }

        if(transactions[i].paiddate != null){
          for(int j=0; j<formattedate.length; j++){
            if(formattedate[j].toString() == dformat.format(DateTime.parse(transactions[i].paiddate)).toString()){
              isInDate = true;
            }
          }
          if(!isInDate){
            formattedate.add(dformat.format(DateTime.parse(transactions[i].paiddate)).toString());
          }
          isInDate = false;
        }
      }
    }
  }

  void addTransaction(TransactionModel transaction) async {
    print(transaction.cId);
    //final bbox = await box;
    await _transactionBox.add(transaction);
    _transactions.value = [];
    for (var transactionb in _transactionBox.values.toList()) {
      if (transactionb.cId == transaction.cId){
        _transactions.value.add(transactionb);
      }
    }
    _debitlist.value = [];
    _creditlist.value = [];
    for(var transactionb in _transactions.value){
      if(transactionb.paid < transactionb.amount){
        _debitlist.value.add(transactionb);
      }
      if(transactionb.amount < transactionb.paid){
        _creditlist.value.add(transactionb);
      }
    }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].cId == transaction.cId){
        if(transactions[i].boughtdate != null){
          for(int k = 0; k<formattedate.length; k++){
            if(formattedate[k].toString() == dformat.format(DateTime.parse(transactions[i].boughtdate)).toString()) {
              //date = dformat.format(DateTime.parse(transactions[i].boughtdate)).toString();
              //formattedate.add(date);
              isInDate = true;
            }
          }
          if(!isInDate){
            formattedate.add(dformat.format(DateTime.parse(transactions[i].boughtdate)).toString());
          }
          isInDate = false;
        }

        if(transactions[i].paiddate != null){
          for(int j=0; j<formattedate.length; j++){
            if(dformat.format(DateTime.parse(transactions[j].boughtdate)).toString() == dformat.format(DateTime.parse(transactions[i].paiddate)).toString()){
              isInDate = true;
            }
          }
          if(!isInDate){
            formattedate.add(dformat.format(DateTime.parse(transactions[i].paiddate)).toString());
          }
          isInDate = false;
        }
      }
    }
    getAllTransactions(transaction.sId);
    print('done');
  }

  void updateTransaction(TransactionModel transaction)async{
    //final bbox = await box;
    await _transactionBox.putAt(_transactionBox.values.toList().indexOf(_stransaction.value), transaction);
    _transactions.value = [];
    for (var ttransaction in _transactionBox.values.toList()) {
      if (ttransaction.cId == transaction.cId){
        _transactions.value.add(ttransaction);
      }
    }
    formattedate = [];
    bool isInDate = false;
    for(int i=0; i<transactions.length; i++) {
      final dformat = new DateFormat('d MMM');
      if(transactions[i].cId == transaction.cId){
        if(transactions[i].boughtdate != null){
          for(int k = 0; k<formattedate.length; k++){
            if(formattedate[k].toString() == dformat.format(DateTime.parse(transactions[i].boughtdate)).toString()) {
              //date = dformat.format(DateTime.parse(transactions[i].boughtdate)).toString();
              //formattedate.add(date);
              isInDate = true;
            }
          }
          if(!isInDate){
            formattedate.add(dformat.format(DateTime.parse(transactions[i].boughtdate)).toString());
          }
          isInDate = false;
        }

        if(transactions[i].paiddate != null){
          for(int j=0; j<formattedate.length; j++){
            if(dformat.format(DateTime.parse(transactions[j].boughtdate)).toString() == dformat.format(DateTime.parse(transactions[i].paiddate)).toString()){
              isInDate = true;
            }
          }
          if(!isInDate){
            formattedate.add(dformat.format(DateTime.parse(transactions[i].paiddate)).toString());
          }
          isInDate = false;
        }
      }
    }
    _debitlist.value = [];
    _creditlist.value = [];
    for(var transactionb in _transactions.value){
      if(transactionb.paid < transactionb.amount){
        _debitlist.value.add(transactionb);
      }
      if(transactionb.amount < transactionb.paid){
        _creditlist.value.add(transactionb);
      }
    }
    getAllTransactions(transaction.sId);
  }

}
