import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class SavedDialogViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
}

Future<void> navigateNext() async {
  //TODO: route to screen
}
