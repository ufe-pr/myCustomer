part of '../../views/main/main_view.dart';

class MainMenu extends HookViewModelWidget<MainViewModel> {
  MainMenu({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return AnimatedPositioned(
      width: SizeConfig.xMargin(context, 100),
      top: model.isCollapsed
          ? SizeConfig.yMargin(context, -88)
          : SizeConfig.yMargin(context, 12),
      bottom: model.isCollapsed
          ? SizeConfig.yMargin(context, 88)
          : 0,
      duration: model.duration,
      child: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (details.delta.dy < 0) {
            model.updateMenu();
          }
        },
        onHorizontalDragEnd: (DragEndDetails details) {
          //  TODO ... MOVEMENT ANIMATION
        },
        onTap: () => model.updateMenu(),
        child: Scaffold(
          backgroundColor:
              ThemeColors.black.withOpacity(model.isCollapsed ? 0 : 0.7),
          body: GestureDetector(onTap: (){},child: BusinessMenu()),
        ),
      ),
    );
  }
}
