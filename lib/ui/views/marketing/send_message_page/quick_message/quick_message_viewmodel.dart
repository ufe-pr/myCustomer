import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/send_message_viewmodel.dart';


class QuickMessageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  MessageArgument argument;

  // Function to serve as a helper for the navigation
  Future navigateTo() async {
    // await _navigationService.navigateTo(Routes.sendAMessageView);
  }

  Future navigateToMessageView(selected, title, message) async {
    MessageArgument argument = MessageArgument(selectedCustomers: selected, title: title,message: message);
     await _navigationService.navigateTo(Routes.messageView,arguments: argument);
  }

  Future navigateToMessage(selected) async {
    MessageArgument  argument = MessageArgument(selectedCustomers: selected,title: '',message: '');
    await _navigationService.navigateTo(Routes.messageView, arguments: argument);
  }
}
