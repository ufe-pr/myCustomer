import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';

class MainProfilePageViewModel extends BaseViewModel {
  final NavigationService _navigationService = locator<NavigationService>();
  final _storeRepository = locator<StoreRepository>();
  final _authService = locator<AuthService>();

  get userName => _authService?.currentUser?.firstName ?? 'None';

  get businessName => StoreRepository?.currentStore?.name ?? 'None';

  Future navigateToEditProfilePage() async {
    await _navigationService.navigateTo(Routes.editProfileViewRoute);
  }
}
