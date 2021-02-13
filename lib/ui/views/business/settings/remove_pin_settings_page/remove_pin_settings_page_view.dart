import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:mycustomers/ui/shared/size_config.dart';
import 'package:mycustomers/ui/widgets/shared/dot_pin_field.dart';
import 'package:mycustomers/core/localization/app_localization.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'remove_pin_settings_page_viewmodel.dart';

class RemovePinSettingsPageView extends StatelessWidget {
  final String myCustomerLogo = 'assets/icons/svg/my_customer_logo.svg';

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, height: 1440, width: 720);
    TextEditingController controller = new TextEditingController(text: "");

    return ViewModelBuilder<RemovePinSettingsPageViewModel>.reactive(
      viewModelBuilder: () => RemovePinSettingsPageViewModel(),
      builder: (context, model, child) {
        return Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(SizeConfig.yMargin(context, 20)),
            child: AppBar(
              iconTheme: IconThemeData(color: ThemeColors.background),
              centerTitle: true,
              backgroundColor: BrandColors.primary,
              elevation: 0,
              flexibleSpace: Padding(
                padding: EdgeInsets.only(top: SizeConfig.yMargin(context, 6)),
                child: SvgPicture.asset(
                  myCustomerLogo,
                  color: Theme.of(context).appBarTheme.color,
                  height: SizeConfig.yMargin(context, 16),
                ),
              ),
            ),
          ),
          backgroundColor: BrandColors.primary,
          body: PinField(
            title: AppLocalizations.of(context).enterPin,
            textEditingController: controller,
            onCompleted: (value) => model.onEnterPinCompleted(value,context,controller),
          ),
        );
      },
    );
  }
}
