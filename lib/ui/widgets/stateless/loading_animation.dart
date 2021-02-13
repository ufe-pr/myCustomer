import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/constants/animations.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

class LoadingAnimation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.yMargin(context, 10),
      child: FlareActor(
        Animations.loader,
        animation: Animations.loader_name,
      ),
    );
  }
}
