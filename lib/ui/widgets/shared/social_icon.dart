import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class SocialIconButton extends StatelessWidget {
  final Function onTap;
  final socialIconUrl;

  SocialIconButton({
    @required this.onTap,
    @required this.socialIconUrl,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(SizeConfig.xMargin(context, 2)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          padding: EdgeInsets.all(SizeConfig.yMargin(context, 2)),
          child: Image.asset(
            socialIconUrl,
            width: SizeConfig.xMargin(context, 4),
            height: SizeConfig.yMargin(context, 2),
          ),
        ),
      ),
    );
  }
}
