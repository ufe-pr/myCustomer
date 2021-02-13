import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/customer_contact_service.dart';
import 'package:mycustomers/core/services/sms_services.dart';
import 'package:stacked/stacked.dart';

class SendMessageViewModel extends BaseViewModel {

  final List<String> _messageEntries = <String>[
    " Don't leave me",
    "Happy New year",
    "Debt reminder"
  ];
  final MessageServices _messageServices = locator<MessageServices>();
  final _customerContactService = locator<CustomerContactService>();

  String number = "0786067005";


  List<String> get messageEntries => _messageEntries;

  void sendSms(){
   print('I have no idea what I am doing');
  }

}