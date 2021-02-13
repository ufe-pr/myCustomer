import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class TransactionHistoryViewModel extends BaseViewModel{
  String value = 'All';
  List date = ['09/06/2020', '15/06/2020', '30/06/2020', '10/06/2020', '09/06/2020', '15/06/2020', '30/06/2020', '10/06/2020'];
  List time = ['09:00', '11:00', '09:00', '12:00', '09:00', '11:00', '09:00', '12:00'];
  List purchase = ['4 Crates of Amstel', '5 Crates of Egg', '5 Cartons of Milk', '5 Packs of 5 Alive', '4 Crates of Amstel', '5 Crates of Egg', '5 Cartons of Milk', '5 Packs of 5 Alive'];
  List payed = [20000, 15000, 10000, 23000, 20000, 15000, 10000, 23000];
  List owes = [30000, 0, 9000, 2000, 30000, 0, 9000, 2000];
  List<String> drop = ['All', 'Select a Date'];
  DateTime selectedDate = DateTime.now();
  final dformat = new DateFormat('dd/MM/yyyy');
  List datel = ['09/06/2020', '15/06/2020', '30/06/2020', '10/06/2020', '09/06/2020', '15/06/2020', '30/06/2020', '10/06/2020'];
  List timel = ['09:00', '11:00', '09:00', '12:00', '09:00', '11:00', '09:00', '12:00'];
  List purchasel = ['4 Crates of Amstel', '5 Crates of Egg', '5 Cartons of Milk', '5 Packs of 5 Alive', '4 Crates of Amstel', '5 Crates of Egg', '5 Cartons of Milk', '5 Packs of 5 Alive'];
  List payedl = [20000, 15000, 10000, 23000, 20000, 15000, 10000, 23000];
  List owesl = [30000, 0, 9000, 2000, 30000, 0, 9000, 2000];

  void setValue(String val) {
    value = val;
    notifyListeners();
  }

  void loadAll() {
    date = ['09/06/2020', '15/06/2020', '30/06/2020', '10/06/2020', '09/06/2020', '15/06/2020', '30/06/2020', '10/06/2020'];
    time = ['09:00', '11:00', '09:00', '12:00', '09:00', '11:00', '09:00', '12:00'];
    purchase = ['4 Crates of Amstel', '5 Crates of Egg', '5 Cartons of Milk', '5 Packs of 5 Alive', '4 Crates of Amstel', '5 Crates of Egg', '5 Cartons of Milk', '5 Packs of 5 Alive'];
    payed = [20000, 15000, 10000, 23000, 20000, 15000, 10000, 23000];
    owes = [30000, 0, 9000, 2000, 30000, 0, 9000, 2000];
    notifyListeners();
  }

  void setData(String ndate){
    date = [];
    time = [];
    purchase = [];
    payed = [];
    owes = [];
    for(int i=0; i < datel.length; i++){
      if(ndate == datel[i]) {
        date.add(datel[i]);
        time.add(timel[datel.indexOf(datel[i])]);
        purchase.add(purchasel[datel.indexOf(datel[i])]);
        payed.add(payedl[datel.indexOf(datel[i])]);
        owes.add(owesl[datel.indexOf(datel[i])]);
      }
    }
  }

  void setDate(DateTime date) {
    drop.length > 2 ? drop[2] = dformat.format(date).toString() : drop.add(dformat.format(date).toString());
    //setValue(dformat.format(date).toString());
    value = dformat.format(date).toString();
    setData(dformat.format(date).toString());
    notifyListeners();
  }
}