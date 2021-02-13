import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/mixins/validators.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/shared/dialog_loader.dart';
import 'package:mycustomers/ui/views/home/onboarding/onboarding_view.dart';
import 'package:mycustomers/ui/views/home/signup/signup_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:pedantic/pedantic.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:mycustomers/ui/shared/toast_widget.dart';

class SignInViewModel extends BaseViewModel with Validators {

  
  void init() async {}

  SignInViewModel() {
    init();
  }

  final NavigationService _navigationService = locator<NavigationService>();
  final DialogService _dialogService = locator<DialogService>();

  String phoneNumber;
  bool obscureText = true;
  bool btnColor = true;

  get currentStore => StoreRepository.currentStore;

  // String initialCountry = 'NG';
  PhoneNumber number = PhoneNumber(isoCode: isoCode);

  // void togglePassword() {
  //   obscureText = !obscureText;
  //   notifyListeners();
  // }

  // void activeBtn() {
  //   btnColor = !btnColor;
  //   notifyListeners();
  // }

  void getPhoneNumber(String phoneNumber) async {}

  Future onInputChange() async {}

  // Navigate
  Future navigateToNextScreen() async {
    if (confirmHasStore()) await _navigationService.replaceWithTransition(MainView(),
        opaque: true, transition: 'rotate', duration: Duration(milliseconds: 400));
  }

    bool confirmHasStore() {
    print('Current store is $currentStore');
    if (currentStore == null) {
      _navigationService.replaceWith(Routes.createBusinessView);
      return false;
    }
    return true;
  }

  Future navigateToSignup() async {
    await _navigationService.replaceWithTransition(SignUpView(),
        opaque: true,
        transition: 'fade',
        duration: Duration(milliseconds: 400));
  }

  final _authService = locator<AuthService>();

  Future<void> signIn(String phoneNumber, String password) async {
    bool busy = true;
    _dialogService.registerCustomDialogUi(buildLoaderDialog);
    _dialogService.showCustomDialog(
        title: 'Please hold on while we try to sign you in');
    try {
      await _authService.signInWithPhoneNumber(phoneNumber, password);
      _dialogService.completeDialog(DialogResponse());
      showToastCustom(
        message: 'Welcome Back',
        success: true,
      );
      busy = false;
      unawaited(navigateToNextScreen());
      // navigateToNextScreen();
    } on AuthException catch (e) {
      showToastCustom(
        message: e.message,
      );
      Logger.e(e.message);
    } catch (e, s) {
      Logger.e('Unknown Error', e: e, s: s);
      showToastCustom(
        message: 'An error occured while we try to sign you in',
      );
    }
    if (busy) _dialogService.completeDialog(DialogResponse());
  }

   Future navigateToOnboarding() async {
    await _navigationService.replaceWithTransition(
      OnboardingView(),
      opaque: true,
      popGesture: true,
      transition: 'rightToLeftWithFade',
      duration: Duration(milliseconds: 100),
    );
  }

}
