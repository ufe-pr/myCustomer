import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked_services/stacked_services.dart';

import 'const_color.dart';

Widget buildLoaderDialog(BuildContext context, DialogRequest request) {
  return Scaffold(
    backgroundColor: Colors.transparent,
    body: Center(
      // child: Card(
      //   color: Colors.transparent,
      //   shape: RoundedRectangleBorder(
      //     borderRadius: BorderRadius.circular(10),
      //   ),
      //   child: Padding(
      //     padding: const EdgeInsets.all(15),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          request.title != null
              ? Text(
                  request.title,
                  softWrap: true,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ThemeColors.background,
                  ),
                )
              : Container(),
          SizedBox(height: SizeConfig.yMargin(context, 2)),
          Container(
            height: SizeConfig.yMargin(context, 10),
            // width: SizeConfig.xMargin(context, 3),
            child: LoadingAnimation(),
          ),
        ],
      ),
    ),
    //   ),
    // ),
  );
}


