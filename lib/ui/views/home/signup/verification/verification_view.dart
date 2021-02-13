import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:stacked/stacked.dart';

import 'verification_viewmodel.dart';

class VerificationView extends StatelessWidget {
  TextEditingController _pinCodeController = TextEditingController();

  static final _pinFormPageKey = GlobalKey<FormState>();
  final _pinPageKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerificationViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        key: _pinPageKey,
        body: CustomBackground(
          child: Form(
            key: _pinFormPageKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: SizeConfig.yMargin(context, 7)),
                Text(
                  AppLocalizations.of(context).verifyCode,
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: SizeConfig.yMargin(context, 4),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 5)),
                //TODO: Pin Validation
                Padding(
                  padding: EdgeInsets.all(SizeConfig.yMargin(context, 3)),
                  child: PinCodeTextField(
                    controller: _pinCodeController,
                    length: 4,
                    obsecureText: false,
                    animationType: AnimationType.scale,
                    textInputType: TextInputType.number,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.underline,
                      selectedColor: Colors.black,
                      activeColor: Colors.black,
                      inactiveColor: Colors.grey,
                      borderWidth: 1,
                      fieldWidth: SizeConfig.yMargin(context, 8),
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    // errorAnimationController: errorController,
                    autoDisposeControllers: false,
                    onCompleted: (v) {},
                    onChanged: (value) {
                      //TODO: Listens and move below code to viewmodel

                      // if (value != null && value.length == 4) {

                      // }
                    },
                  ),
                ),
                Center(
                  child: Text(
                    AppLocalizations.of(context).enter4DigitCode,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      fontSize: SizeConfig.yMargin(context, 2),
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: SizeConfig.yMargin(context, 13)),
                CustomRaisedButton(
                  btnColor: BrandColors.primary,
                  txtColor: ThemeColors.background,
                  btnText: AppLocalizations.of(context).nextButton,
                  onPressed: () async {
                    // viewModel.signUpTest();
                    if (!_pinFormPageKey.currentState.validate()) return;

                    //Dismiss keyboard during async call
                    FocusScope.of(context).requestFocus(FocusNode());

                    //Call Function to Next Screen
                    model.navigateToNextScreen();
                  },
                ),

                SizedBox(height: SizeConfig.yMargin(context, 18)),
                Container(
                    width: SizeConfig.xMargin(context, 60),
                    child: CustomizeProgressIndicator(3, 4)),
                SizedBox(height: SizeConfig.yMargin(context, 6)),
              ],
            ),
          ),
        ),
      ),
      viewModelBuilder: () => VerificationViewModel(),
    );
  }
}
