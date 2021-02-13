import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_hooks/stacked_hooks.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

import 'business_viewmodel.dart';

class BusinessView extends StatelessWidget {
  final _businessPageKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BusinessViewModel>.reactive(
      builder: (context, model, child) => AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: BrandColors.primary,
          statusBarIconBrightness: Brightness.light,
        ),
        child: SafeArea(
          child: Scaffold(
            key: _businessPageKey,
            resizeToAvoidBottomInset: false,
            backgroundColor: BrandColors.primary,
            body: CustomBackground(child: _PartialBuildForm()),
          ),
        ),
      ),
      viewModelBuilder: () => BusinessViewModel(),
    );
  }
}

class _PartialBuildForm extends HookViewModelWidget<BusinessViewModel> {
  static final _businessFormPageKey = GlobalKey<FormState>();

  _PartialBuildForm({Key key}) : super(key: key, reactive: false);

  @override
  Widget buildViewModelWidget(
      BuildContext context, BusinessViewModel viewModel) {
    var _storeName = useTextEditingController();
    var _storeAddress = useTextEditingController();
    var _fullName = useTextEditingController();
    var _emailAddress = useTextEditingController();

    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(SizeConfig.xMargin(context, 8)),
              topRight: Radius.circular(SizeConfig.xMargin(context, 8)))),
      child: Form(
        key: _businessFormPageKey,
        child: Column(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  SizedBox(height: SizeConfig.yMargin(context, 7)),
                  Text(
                    AppLocalizations.of(context).businessDetails,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: SizeConfig.yMargin(context, 4),
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 5)),
                  Text(
                    AppLocalizations.of(context).oneLastStep,
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: SizeConfig.yMargin(context, 2),
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 2)),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      key: Key("fullname"),
                      controller: _fullName,
                      validator: (value) => (value.isEmpty)
                          ? AppLocalizations.of(context).pleaseEnterYourFullName
                          : null,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).enterYourFullName,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      key: Key("email"),
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailAddress,
                      validator: (_) =>
                          viewModel.validateEmail(_emailAddress.text),
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          labelText: AppLocalizations.of(context)
                              .pleaseEnterYourEmailAddress,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      key: Key("storeName"),
                      controller: _storeName,
                      validator: (value) => (value.isEmpty)
                          ? AppLocalizations.of(context).pleaseStoreName
                          : null,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).enterStoreName,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
                    child: TextFormField(
                      key: Key("storeAddress"),
                      controller: _storeAddress,
                      validator: (value) => (value.isEmpty)
                          ? AppLocalizations.of(context).pleaseStoreAddress
                          : null,
                      style: TextStyle(
                        fontFamily: 'Lato',
                        fontSize: SizeConfig.yMargin(context, 2),
                        fontWeight: FontWeight.w300,
                        color: Theme.of(context).cursorColor,
                      ),
                      decoration: InputDecoration(
                          labelText:
                              AppLocalizations.of(context).enterStoreAddress,
                          border: OutlineInputBorder()),
                    ),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 4)),
                ],
              ),
            ),
            CustomRaisedButton(
              btnColor: BrandColors.primary,
              txtColor: ThemeColors.background,
              btnText: AppLocalizations.of(context).submitAndFinish,
              borderColor: BrandColors.primary,
              child: Container(),
              onPressed: () async {
                // viewModel.signUpTest();
                if (_businessFormPageKey.currentState.validate()) {
                  //Dismiss keyboard during async call
                  FocusScope.of(context).requestFocus(FocusNode());

                  //Call Function to Signin
                  viewModel.updateUserDeets(
                      _fullName.text.trim(), _emailAddress.text.trim());
                  viewModel.updateUser(
                      _storeName.text.trim(), _storeAddress.text.trim());
                }
              },
            ),
            SizedBox(height: SizeConfig.yMargin(context, 6)),
            Container(
                width: SizeConfig.xMargin(context, 60),
                child: CustomizeProgressIndicator(4, 4)),
            SizedBox(height: SizeConfig.yMargin(context, 4)),
          ],
        ),
      ),
    );
  }
}
