import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/send_message_viewmodel.dart';


class StuffModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
   MessageArgument argument;

  String _upperBoxText = 'Happy New Year!';
  String get upperBoxText => _upperBoxText;

  String lowerBoxText = 'Happy New Year \n Best wishes from me';

  List<String> templateList = [
    'Happy New Year \n Best wishes from me',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Seasons Greetings! \n Wishing you a happ new year',
    'Reloaded 3 of 692 libraries in 1,777ms.',
    'Reloaded 3 of 692 libraries in 1,777ms.'
  ];

  int numberOfSelectedCustomers = 3;

  bool checkBoxValue = true;
  checkBoxFunction(bool val) {
    checkBoxValue = val;
    val = !val;
  }

  int currentIndex = 0;
  onTap(template) {
    currentIndex = templateList.indexOf(template);
  }

  // Function to serve as a helper for the navigation
  Future navigateTo() async {
    await _navigationService.navigateTo(Routes.marketingHomepageView);
  }

  Future navigateToQuickMessage(selected) async {
    MessageArgument argument = MessageArgument(selectedCustomers: selected);
     await _navigationService.navigateTo(Routes.quickMessages, arguments: argument);
  }
  Future navigateToMessage(selected) async {
    MessageArgument  argument = MessageArgument(selectedCustomers: selected,title: '',message: '');
     await _navigationService.navigateTo(Routes.messageView, arguments: argument);
  }
}
