import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/const_widget.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/partial_build.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/ui/theme/theme_viewmodel.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'language_viewmodel.dart';
import 'package:mycustomers/core/localization/app_localization.dart';

class LanguageSelectionPageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<LanguageViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: customizeAppBar(context, 1.0,
            title: 'Language Settings',
            arrowColor: Theme.of(context).textSelectionColor),
        body: Container(
          margin:
              EdgeInsets.symmetric(horizontal: SizeConfig.xMargin(context, 8)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: SizeConfig.yMargin(context, 3)),
              Text(
                AppLocalizations.of(context).selectYourLanguage,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: SizeConfig.yMargin(context, 2.2),
                ),
              ),
              SizedBox(height: SizeConfig.yMargin(context, 2)),
              ListView.builder(
                shrinkWrap: true,
                itemCount: model.languages.length,
                itemBuilder: (BuildContext context, int index) {
                  return CustomPartialBuild<SettingManagerModel>(
                    builder: (context, viewModel) => Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: SizeConfig.yMargin(context, 0.5)),
                      child: InkWell(
                        onTap: () {
                          // model.setLanguage(index);
                          viewModel.setLocale(model.languages[index]['code'], model.languages[index]['name']);
                        },
                        child: Container(
                          height: SizeConfig.yMargin(context, 7),
                          width: SizeConfig.xMargin(context, 100),
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Color.fromARGB(13, 71, 126, 200),
                                offset: Offset(0, 4),
                                blurRadius: 4,
                              )
                            ],
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(
                              color: (viewModel.locale?.languageCode ??
                                          Localizations.localeOf(context)
                                              .languageCode) ==
                                      model.languages[index]['code']
                                  ? Theme.of(context).textSelectionColor
                                  : Color(0xFFE8E8E8),
                            ),
                            color: Theme.of(context).backgroundColor,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.all(
                                    SizeConfig.yMargin(context, 1)),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(
                                      SizeConfig.yMargin(context, 5)),
                                  child: Image(
                                    height: SizeConfig.yMargin(context, 10),
                                    fit: BoxFit.contain,
                                    image: AssetImage(
                                      model.languages[index]['image'],
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                model.languages[index]['name'],
                                style: TextStyle(
                                  color: Theme.of(context).cursorColor,
                                  fontSize: SizeConfig.yMargin(context, 2.5),
                                ),
                              ),
                              Padding(
                                  padding: EdgeInsets.all(
                                      SizeConfig.yMargin(context, 4)),
                                  child: Text("")),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => LanguageViewModel(),
    );
  }
}
