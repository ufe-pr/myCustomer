import 'package:flutter/material.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/stateless/loading_animation.dart';
import 'package:stacked/stacked.dart';
import 'startup_viewmodel.dart';

class StartupView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<StartupViewModel>.nonReactive(
      builder: (context, model, child) => Container(
        color: Theme.of(context).backgroundColor,
        child: Stack(
          children: <Widget>[
            Container(
              height: SizeConfig.yMargin(context, 100),
              width: SizeConfig.xMargin(context, 100),
              color: Color.fromRGBO(0, 0, 0, 0.8),
              child: Opacity(
                opacity: 0.2,
                child: Transform.translate(
                  offset: Offset(SizeConfig.yMargin(context, 1), 0),
                  child: Container(
                    child: Image.asset(
                      'assets/images/startup_bg.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
            ),
            Center(child: LoadingAnimation())
          ],
        ),
      ),
      viewModelBuilder: () => StartupViewModel(),
      onModelReady: (model) => model.setup(),
    );
  }
}
