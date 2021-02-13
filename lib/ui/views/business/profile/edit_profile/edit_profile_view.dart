import 'package:flutter/foundation.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:flutter_screenutil/size_extension.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'edit_profile_viewmodel.dart';
import 'package:flushbar/flushbar_helper.dart';

class EditProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<EditProfileViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(
              AppLocalizations.of(context).editProfile,
              style: TextStyle(
                color: Theme.of(context).cursorColor,
                fontWeight: FontWeight.bold,
                fontSize: SizeConfig.textSize(context, 6),
              ),
            ),
            centerTitle: true,
            elevation: 0.0,
            iconTheme: IconThemeData(color: BrandColors.primary),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: !kIsWeb &&
                            defaultTargetPlatform == TargetPlatform.android
                        ? FutureBuilder<void>(
                            future: model.retrieveLostData(),
                            builder: (BuildContext context,
                                AsyncSnapshot<void> snapshot) {
                              switch (snapshot.connectionState) {
                                case ConnectionState.none:
                                case ConnectionState.waiting:
                                  return CircleAvatar(
                                    child: Text(
                                      AppLocalizations.of(context)
                                          .notPickedImage,
                                      textAlign: TextAlign.center,
                                    ),
                                  );
                                case ConnectionState.done:
                                  return _previewImage(context, model);
                                default:
                                  if (snapshot.hasError) {
                                    return Text(
                                      AppLocalizations.of(context).pickImage +
                                          ':' +
                                          '${snapshot.error}}',
                                      textAlign: TextAlign.center,
                                    );
                                  } else {
                                    return Text(
                                      AppLocalizations.of(context)
                                          .notPickedImage,
                                      textAlign: TextAlign.center,
                                    );
                                  }
                              }
                            },
                          )
                        : _previewImage(context, model),
                  ),
                  SizedBox(height: SizeConfig.yMargin(context, 2)),
                  Container(
                    height: SizeConfig.yMargin(context, 8),
                    width: SizeConfig.xMargin(context, 70),
                    decoration: BoxDecoration(
                      color: BrandColors.primary,
                      borderRadius: BorderRadius.circular(8.sp),
                    ),
                    child: FlatButton(
                      onPressed: model.getImagefromGallery,
                      child: Text(
                        model.image == null
                            ? AppLocalizations.of(context).addProfilePicture
                            : AppLocalizations.of(context).changePic,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: SizeConfig.textSize(context, 4),
                          color: ThemeColors.background,
                        ),
                      ),
                    ),
                  ),
                   SizedBox(height: SizeConfig.yMargin(context, 1.4)),
                  Divider(color: ThemeColors.gray.shade600),
                  SizedBox(height: SizeConfig.yMargin(context, 1.4)),
                  Column(
                    children: <Widget>[
                      Container(
                        height: SizeConfig.yMargin(context, 8),
                        width: SizeConfig.xMargin(context, 90),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5.sp),
                            border:
                                Border.all(color: ThemeColors.gray.shade600)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.xMargin(context, 4),
                          ),
                          child: TextFormField(
                            initialValue: model.userName,
                            keyboardType: TextInputType.text,
                            onChanged: (value) => model.updateUserName(value),
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: AppLocalizations.of(context).userName,
                            ),
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: SizeConfig.yMargin(context, 2)),
                      Container(
                        height: SizeConfig.yMargin(context, 8),
                        width: SizeConfig.xMargin(context, 90),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.sp),
                          border: Border.all(color: ThemeColors.gray.shade600),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: SizeConfig.xMargin(context, 4),
                          ),
                          child: TextFormField(
                            onChanged: (value) =>
                                model.updateBusinessName(value),
                            initialValue: model.businessName,
                            keyboardType: TextInputType.text,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText:
                                    AppLocalizations.of(context).businessName),
                            style: TextStyle(
                              color: Theme.of(context).textSelectionColor,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 25),
                  ),
                  FlatButton(
                    color: BrandColors.primary,
                    onPressed: () {
                      model.updateProfile();
                      FlushbarHelper.createInformation(
                        duration: const Duration(seconds: 5),
                        message: AppLocalizations.of(context).comingSoon,
                      ).show(context);
                    },
                    padding: EdgeInsets.symmetric(
                      horizontal: SizeConfig.xMargin(context, 40),
                      vertical: SizeConfig.yMargin(context, 2.6),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(3),
                    ),
                    child: Text(
                      AppLocalizations.of(context).save,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: ThemeColors.background,
                        fontStyle: FontStyle.normal,
                        fontWeight: FontWeight.bold,
                        fontSize: SizeConfig.yMargin(context, 2),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: SizeConfig.yMargin(context, 2),
                  )
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => EditProfileViewModel(),
      onModelReady: (model) => model.init(),
    );
  }
}

Widget _previewImage(BuildContext context, EditProfileViewModel model) {
  final Text retrieveError = _getRetrieveErrorWidget(model);
  if (retrieveError != null) {
    return retrieveError;
  }

  return CircleAvatar(
    backgroundColor: ThemeColors.unselect,
    child: model.image == null
        ? Text(
            model.userName.isEmpty ? 'N' : model.userName.substring(0, 1),
            style: TextStyle(
              color: BrandColors.primary,
              fontSize: SizeConfig.textSize(context, 18),
              fontWeight: FontWeight.bold,
            ),
          )
        : ClipOval(
            child: Image.file(
              model.image,
              width: SizeConfig.xMargin(context, 50),
              height: SizeConfig.xMargin(context, 50),
              fit: BoxFit.cover,
            ),
          ),
    radius: 70,
  );
}

Text _getRetrieveErrorWidget(EditProfileViewModel model) {
  if (model.retrieveDataError != null) {
    final Text result = Text(model.retrieveDataError);
    model.retrieveDataError = null;
    return result;
  }
  return null;
}
