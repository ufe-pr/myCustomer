import 'dart:async';
import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';

class AddDebtViewModel extends BaseViewModel{
  final _debouncer = Debouncer(milliseconds: 100);
  final dformat = new DateFormat('dd/MM/yyyy');
  bool show = false;
  bool save = false;
  DateTime selectedDate = DateTime.now();
  String newDate;
  List items = [];

  double _amount;
  double get amount => _amount;

  String _error;
 // String get error => _error;

  String _item;
  String get item => _item;

  bool isNumeric(String amt) {
    if(amt == null) {
      return false;
    }
    return num.tryParse(amt) != null;
  }

  void updateAmount(String value) {
    _debouncer.run(() {
      if(value.length != 0) {
        String val = '';
        for (int i = 0; i < value.length; i++) {
          if(value[i] != ','){
            val = val.toString()+value[i].toString();
          }
        }
        if (isNumeric(val)){
          _error = null;
          _amount = double.parse(val);
          show = true;
          amount != null && newDate != null && items.length > 0 ? save = true : save = false;
          notifyListeners();
        } else{
          _error = 'Enter a valid amount';
          notifyListeners();
        }
      }
    });
  }

  void setDate(DateTime date) {
    newDate = dformat.format(date);
    amount != null && newDate.length > 0 && items.length > 0 ? save = true : save = false;
    notifyListeners();
  }

  void updateItem(String value){
    _item = value;
    notifyListeners();
  }

  void removeItem(int index) {
    items.removeAt(index);
    notifyListeners();
  }

  void addItem() {
    if(item != null) {
      if(item.length > 0) {
        items.add(item);
        _item = null;
        amount != null && newDate.length > 0 && items.length > 0 ? save = true : save = false;
        notifyListeners();
      }
    }
  }
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({ this.milliseconds });

  run(VoidCallback action) {
    if (_timer != null) {
      _timer.cancel();
    }

    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}