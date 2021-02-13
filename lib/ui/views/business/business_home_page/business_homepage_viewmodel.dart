
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';
import 'package:mycustomers/core/repositories/business_card/business_card_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';

class BusinessHomePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final AuthService _auth = locator<AuthService>();

  String get pNum => _auth.currentUser.phoneNumber;


  String get profileCardTitle => 'Profile';

  String get profileCardSubtitle =>
      StoreRepository?.currentStore?.address ?? '---';

  Future navigateToProfilePage() async {
    await _navigationService.navigateTo(Routes.profileViewRoute);
  }

  Future navigateToBusinessCardPage() async {
    await _navigationService.navigateTo(Routes.businessCardRoute);
  }

  Future navigateToSupportPage() async {
    await _navigationService.navigateTo(Routes.supportViewRoute);
  }

  Future navigateToSettingsPage() async {
    await _navigationService.navigateTo(Routes.bussinessSettingsPage);
  }

   /// Fields
  BusinessCardH _businessCard = BusinessCardH.empty();

  /// Getters
  BusinessCardH get businessCard => _businessCard;

}
