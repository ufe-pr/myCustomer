import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:flutter_screenutil/size_extension.dart';

import 'saved_dialog_viewmodel.dart';

class SavedDialogView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SavedDialogViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: SafeArea(
          child: Stack(
            children: <Widget>[
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: InkWell(
                      onTap: () {
                        savedDialog(context);
                      },
                      child: Container(
                        height: 50.h,
                        decoration: BoxDecoration(
                          color: Color(0xFF333CC1),
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              AppLocalizations.of(context).save,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => SavedDialogViewModel(),
    );
  }
}

Future<void> savedDialog(BuildContext context) async {
  return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  child: Icon(
                    Icons.check_circle,
                    color: Color(0xFF333CC1),
                    size: 70,
                  ),
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  child: Text(
                    AppLocalizations.of(context).saved,
                    style: TextStyle(
                      color: Color(0xFF333CC1),
                      fontSize: 16.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      });
}
