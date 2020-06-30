import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/core/models/message.dart';
import 'package:stacked/stacked.dart';

class StuffModel extends BaseViewModel {
  List _selectedCustomers;
  bool checkBoxValue;

  List templateList;

  int currentIndex;

  get numberOfSelectedCustomers => _selectedCustomers.length;

  checkBoxFunction(bool bool) {}

  void onTap(template) {}

}
