import 'package:flutter/material.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:stacked/stacked.dart';
import 'app_lock_settings_page_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

class AppLockSettingsPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AppLockSettingsPageViewModel>.reactive(
      viewModelBuilder: () => AppLockSettingsPageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: customizeAppBar(context, 1.0,
              title: AppLocalizations.of(context).appLock,
              arrowColor: BrandColors.primary),
          backgroundColor: Theme.of(context).backgroundColor,
          body: Column(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: SizeConfig.yMargin(context, 2),
                    horizontal: SizeConfig.xMargin(context, 5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 196, 196, 196),
                        ),
                        child: ListTileTheme(
                          style: ListTileStyle.list,
                          selectedColor:
                              const Color.fromARGB(50, 196, 196, 196),
                          child: ListTile(
                              onTap: () =>
                                  model.getThecurrentStateOfPin() == false
                                      ? model.navigateToSetPinPage()
                                      : model.navigateToChangePinPage(),
                              trailing: Icon(Icons.chevron_right),
                              title: model.getThecurrentStateOfPin() == false
                                  ? Text(
                                      AppLocalizations.of(context)
                                          .setApplockPin,
                                      style: TextStyle(
                                        fontSize:
                                            SizeConfig.textSize(context, 4),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )
                                  : Text(
                                      AppLocalizations.of(context)
                                          .changeAppLockPin,
                                      style: TextStyle(
                                          fontSize:
                                              SizeConfig.textSize(context, 4),
                                          fontWeight: FontWeight.w600))),
                        ),
                      ),
                      SizedBox(
                        height: SizeConfig.yMargin(context, 2.5),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(20, 196, 196, 196),
                        ),
                        child: ListTileTheme(
                          style: ListTileStyle.list,
                          selectedColor:
                              const Color.fromARGB(50, 196, 196, 196),
                          child: ListTile(
                            enabled: model.getThecurrentStateOfPin(),
                            onTap: () => model.navigateToRemovePinPage(),
                            trailing: Icon(Icons.chevron_right),
                            title: Text(
                              AppLocalizations.of(context).removeAppLock,
                              style: TextStyle(
                                fontSize: SizeConfig.textSize(context, 4),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
