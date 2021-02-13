import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/views/business/profile/profile_screen/profile_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';

class ProfilePageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<MainProfilePageViewModel>.reactive(
        builder: (context, model, child) {
          TextEditingController _userName =
              TextEditingController(text: model.userName);
          TextEditingController _businessName =
              TextEditingController(text: model.businessName);

          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              title: Text(
                AppLocalizations.of(context).profile,
                style: TextStyle(
                  color: Theme.of(context).cursorColor,
                  fontWeight: FontWeight.bold,
                  fontSize: SizeConfig.textSize(context, 6),
                ),
              ),
              centerTitle: true,
              elevation: 0.0,
              iconTheme: IconThemeData(color: BrandColors.primary),
              actions: <Widget>[
                FlatButton(
                  onPressed: model.navigateToEditProfilePage,
                  child: Text(
                    AppLocalizations.of(context).edit,
                    style: TextStyle(
                      fontSize: SizeConfig.textSize(context, 4.4),
                      color: Theme.of(context).textSelectionColor,
                    ),
                  ),
                )
              ],
            ),
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: SizeConfig.yMargin(context, 2),
                    ),
                    child: Center(
                      child: CircleAvatar(
                        backgroundColor: ThemeColors.unselect,
                        radius: SizeConfig.yMargin(context, 12),
                        child: Text(
                          _userName.text.substring(0, 1),
                          style: TextStyle(
                            color: BrandColors.primary,
                            fontSize: SizeConfig.textSize(context, 18),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(color: ThemeColors.gray.shade600),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.yMargin(context, 4),
                      ),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).name),
                                SizedBox(width: 30),
                                Expanded(
                                  child: TextField(
                                    autofocus: false,
                                    controller: _userName,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Row(
                              children: <Widget>[
                                Text(AppLocalizations.of(context).businessName),
                                SizedBox(width: 18),
                                Expanded(
                                  child: TextField(
                                    autofocus: false,
                                    controller: _businessName,
                                    textAlign: TextAlign.left,
                                    decoration: InputDecoration(
                                      enabled: false,
                                      border: InputBorder.none,
                                    ),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
        viewModelBuilder: () => MainProfilePageViewModel());
  }
}
