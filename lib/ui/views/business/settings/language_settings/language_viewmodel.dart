import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class LanguageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
   
   List get languages => _supportedLanguages;

  List<Map<String, String>> _supportedLanguages = [
    {'image': 'assets/languages/icons/uk.png','code': 'en', 'name': 'English'},
    {'image': 'assets/languages/icons/fr.png','code': 'fr', 'name': 'Francias'},
    {'image': 'assets/languages/icons/de.png','code': 'de', 'name': 'German'},
    {'image': 'assets/languages/icons/ar.png','code': 'ar', 'name': 'Arabic'},
    // {'image': 'assets/languages/icons/ng.png','code': 'yo', 'name': 'Yoruba'},
    {'image': 'assets/languages/icons/es.png','code': 'es', 'name': 'Spanish'},
    // {'image': 'assets/languages/icons/ng.png','code': 'ig', 'name': 'Igbo'},
    {'image': 'assets/languages/icons/hi.png','code': 'hi', 'name': 'Hindu'},
    ];

  // Future<void> setLanguage(int index) async {
  //   await locator<IStorageUtil>()
  //       .saveString('AppPreferenceKey.USER_PREF_LANGUAGE', _supportedLanguages[index]['code']);
  //   navigateToNext();
  // }

  Future navigateToNext() async {
    await Future.value();
    await _navigationService.clearStackAndShow(Routes.signupViewRoute);
  }
  

  
}
