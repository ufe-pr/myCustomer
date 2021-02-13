part of '../../views/main/main_view.dart';

class BusinessMenu extends HookViewModelWidget<MainViewModel> {
  BusinessMenu({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return Container(
      padding: EdgeInsets.symmetric(
        vertical: SizeConfig.yMargin(context, 2),
      ),
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
      ),
      height: SizeConfig.yMargin(context, 45),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: BusinessMenuOptions(),
          ),
          SizedBox(
            height: SizeConfig.yMargin(context, 2),
          ),
          _AddBusinessButton(),
        ],
      ),
    );
  }
}
