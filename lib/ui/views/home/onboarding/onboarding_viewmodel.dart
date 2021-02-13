import 'dart:async';
import 'package:flutter/material.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/ui/views/home/sigin/signin_view.dart';
import 'package:mycustomers/ui/views/home/signup/signup_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class OnboardingViewModel extends BaseViewModel {
  //Page controller Index
  int currentIndex = 0;
  final pageController = new PageController(initialPage: 0);
  Timer _animationTimer;

  //Init State
  void initState() {
    _animationTimer = Timer.periodic(Duration(seconds: 5), (Timer timer) {
      currentIndex < 4 ? currentIndex++ : currentIndex = 0;

      pageController.animateToPage(
        currentIndex,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
    notifyListeners();
  }

  // Navigation
  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToSignIn() async {
    await _navigationService.replaceWithTransition(
      SignInView(),
      opaque: true,
      popGesture: true,
      transition: 'rightToLeftWithFade',
      duration: Duration(milliseconds: 100),
    );
  }

  Future navigateToSignUp() async {
    await _navigationService.replaceWithTransition(
      SignUpView(),
      opaque: true,
      popGesture: true,
      transition: 'rightToLeftWithFade',
      duration: Duration(milliseconds: 100),
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
    _animationTimer.cancel();
  }
}
