import 'package:flushbar/flushbar.dart';
import 'package:flushbar/flushbar_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/social_icon.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';

import 'signin_viewmodel.dart';

class SignInView extends StatelessWidget {
  final _signinPageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    ScreenUtil.init(context, width: width, height: height);
    return ViewModelBuilder<SignInViewModel>.nonReactive(
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: BrandColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: WillPopScope(
            onWillPop: () => model.navigateToOnboarding(),
            child: Scaffold(
              key: _signinPageKey,
              resizeToAvoidBottomInset: false,
              backgroundColor: BrandColors.primary,
              body: CustomBackground(child: _PartialBuildForm()),
            ),
          ),
        ),
      ),
      viewModelBuilder: () => SignInViewModel(),
    );
  }
}

class _PartialBuildForm extends HookViewModelWidget<SignInViewModel> {
  static final _signinFormPageKey = GlobalKey<FormState>();

  _PartialBuildForm({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(BuildContext context, SignInViewModel viewModel) {
    var _inputSigninNumberController = useTextEditingController();
    var _userPasswordController = useTextEditingController();

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.xMargin(context, 8)),
              topRight: Radius.circular(SizeConfig.xMargin(context, 8)))),
      child: Form(
        key: _signinFormPageKey,
        child: Column(
          children: <Widget>[
            SizedBox(height: SizeConfig.yMargin(context, 3)),
            Text( 
              AppLocalizations.of(context).signIn.toUpperCase(),
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: SizeConfig.textSize(context, 6),
              ),
            ),
            SizedBox(height: SizeConfig.xMargin(context, 10)),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.xMargin(context, 5)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text( 
                  AppLocalizations.of(context).signUpEnterPhoneNumber,
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textSize(context, 4),
                  ),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.yMargin(context, 1)),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.xMargin(context, 5),
                right: SizeConfig.xMargin(context, 5),
              ),
              child: InternationalPhoneNumberInput(
                onInputChanged: (PhoneNumber number) {
                  viewModel.number = number;
                  // print('Phone changed');
                },
                // onInputValidated: (bool value) {
                //   viewModel.phoneValid = value;
                //   viewModel.activeBtn();
                //   print('Value is: $value');
                // },
                ignoreBlank: false,
                // autoValidate: true,
                // countries: ['NG', 'GH', 'BJ' 'TG', 'CI'],
                errorMessage: AppLocalizations.of(context).invalidPhoneNo,
                selectorType: PhoneInputSelectorType.DIALOG,
                selectorTextStyle:
                    TextStyle(color: Theme.of(context).cursorColor),
                initialValue: viewModel.number,
                textFieldController: _inputSigninNumberController,
                // inputBorder: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: SizeConfig.xMargin(context, 8)),
            Padding(
              padding: EdgeInsets.only(left: SizeConfig.xMargin(context, 5)),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: Text(
                  AppLocalizations.of(context).pleaseEnterPassword,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: SizeConfig.textSize(context, 4),
                  ),
                ),
              ),
            ),
            // SizedBox(height: SizeConfig.xMargin(context, 0.5)),
            Padding(
              padding: EdgeInsets.only(
                left: SizeConfig.xMargin(context, 5),
                right: SizeConfig.xMargin(context, 5),
              ),
              child: TextFormField(
                key: Key("userpassword"),
                controller: _userPasswordController,
                obscureText: viewModel.obscureText,
                // viewModel.obscureText,
                validator: (_) =>
                    viewModel.validatePassword(_userPasswordController.text),
                style: TextStyle(
                  fontFamily: 'Lato',
                  fontSize: SizeConfig.yMargin(context, 2),
                  fontWeight: FontWeight.w300,
                  color: Theme.of(context).cursorColor,
                ),
                // autovalidate: true,
                // onChanged: (_) {
                //   viewModel.validatePassword(_userPassword.text);
                //   viewModel.activeBtn();
                // },
                decoration: InputDecoration(
                  // suffixIcon: _CustomPartialBuildWidget<SignUpViewModel>(
                  //   builder: (BuildContext context, SignUpViewModel viewModel) =>
                  //       IconButton(
                  //     icon: Icon(
                  //       // Based on obscureText state choose the icon
                  //       viewModel.obscureText
                  //           ? Icons.visibility
                  //           : Icons.visibility_off,
                  //       color: Theme.of(context).primaryColorDark,
                  //     ),
                  //     onPressed: () {
                  //       // Update the state i.e. toogle the state of obscureText variable
                  //       viewModel.togglePassword();
                  //     },
                  //   ),
                  // ),
                  labelText: AppLocalizations.of(context).password,
                  // border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(height: SizeConfig.yMargin(context, 3)),
            CustomRaisedButton(
              btnColor: BrandColors.primary,
              txtColor: ThemeColors.background,
              borderColor: BrandColors.primary,
              btnText: AppLocalizations.of(context).nextButton,
              onPressed: () async {
                // viewModel.signUpTest();
                if (!_signinFormPageKey.currentState.validate()) return;

                //Dismiss keyboard during async call
                FocusScope.of(context).requestFocus(FocusNode());

                //Call Function to Signin
                viewModel.signIn(
                  viewModel.number.dialCode +
                      int.parse(_inputSigninNumberController.text
                          .splitMapJoin(RegExp(r'[^0-9]'), onMatch: (_) => '')).toString(),
                  _userPasswordController.text.trim(),
                );
              },
              child: Icon(
                Icons.arrow_forward,
                color: ThemeColors.background,
                size: SizeConfig.yMargin(context, 2.5),
              ),
            ),
            SizedBox(height: SizeConfig.yMargin(context, 4)),
            // Text(
            //   'or \n Continue with your social accounts',
            //   textAlign: TextAlign.center,
            //   style: TextStyle(
            //     color: Theme.of(context).textSelectionColor,
            //     fontSize: SizeConfig.yMargin(context, 1.8),
            //   ),
            // ),
            // SizedBox(height: SizeConfig.yMargin(context, 2)),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: <Widget>[
            //     SocialIconButton(
            //       onTap: () {
            //         Flushbar(
            //           backgroundColor: BrandColors.primary,
            //           duration: const Duration(seconds: 3),
            //           message: 'Google signin coming soon',
            //           icon: Icon(
            //             Icons.info_outline,
            //             size: 28.0,
            //             color: ThemeColors.background,
            //           ),
            //           leftBarIndicatorColor: Colors.blue[300],
            //         ).show(context);
            //       },
            //       socialIconUrl: 'assets/icons/google_icon.png',
            //     ),
            //     SocialIconButton(
            //       onTap: () {
            //         Flushbar(
            //           backgroundColor: BrandColors.primary,
            //           duration: const Duration(seconds: 3),
            //           message: 'Facebook signin coming soon',
            //           icon: Icon(
            //             Icons.info_outline,
            //             size: 28.0,
            //             color: ThemeColors.background,
            //           ),
            //           leftBarIndicatorColor: Colors.blue[300],
            //         ).show(context);
            //       },
            //       socialIconUrl: 'assets/icons/facebook_icon.png',
            //     ),
            //     //  SocialIconButton(
            //     //    onTap: () {},
            //     //    socialIconUrl: 'assets/icons/apple_icon.png',
            //     //  ),
            //   ],
            // ),
            SizedBox(height: SizeConfig.yMargin(context, 2)),
            CustomRaisedButton(
              btnColor: ThemeColors.unselect,
              txtColor: BrandColors.primary,
              borderColor: ThemeColors.unselect,
              btnText: AppLocalizations.of(context).notAMemberSignUp,
              child: Container(),
              onPressed: () {
                // dismiss keyboard during async call
                FocusScope.of(context).requestFocus(FocusNode());
                // Route Screen to Login
                viewModel.navigateToSignup();
              },
            ),
            SizedBox(height: SizeConfig.yMargin(context, 8)),
            Container(
                width: SizeConfig.xMargin(context, 60),
                child: CustomizeProgressIndicator(1, 4)),
            Expanded(child: SizedBox(height: SizeConfig.yMargin(context, 6))),
          ],
        ),
      ),
    );
  }
}
