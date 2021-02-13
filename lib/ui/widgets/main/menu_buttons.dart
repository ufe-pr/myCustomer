part of '../../views/main/main_view.dart';

class BusinessMenuOptions extends HookViewModelWidget<MainViewModel> {
  BusinessMenuOptions({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return MediaQuery.removePadding(
      removeTop: true,
      context: context,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: model.stores.length,
        itemBuilder: (BuildContext context, int index) {
          return businessIcon(
            context,
            model.stores[index],
            model,
          );
        },
      ),
    );
  }

  Widget businessIcon(
      BuildContext context, Store business, MainViewModel model) {
    return CustomPartialBuild<SettingManagerModel>(
      builder: (context, viewModel) => InkWell(
        onTap: () async {
          await viewModel.changeSelectedStore(business.id);
          model.updateMenu();
        },
        child: Container(
          height: SizeConfig.yMargin(context, 12),
          color: model.currStore.id == business.id
              ? Color(0xFF2F80ED).withOpacity(0.2)
              : Colors.transparent,
          child: Center(
            child: ListTile(
              leading: Container(
                alignment: Alignment.center,
                height: SizeConfig.xMargin(context, 13),
                width: SizeConfig.xMargin(context, 13),
                padding: EdgeInsets.all(
                  SizeConfig.yMargin(context, 0.7),
                ),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: BrandColors.primary,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.all(
                    Radius.circular(5),
                  ),
                ),
                child: Center(
                  child: Text(
                    business.name.substring(0, 1).capitalize,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).cursorColor,
                      fontSize: SizeConfig.textSize(context, 8),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              title: Text(
                business.name,
                style: TextStyle(
                  color: Theme.of(context).cursorColor,
                  fontSize: SizeConfig.textSize(context, 6),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                model.getCustomerCount(business.id) > 1 ? model.getCustomerCount(business.id).toString()+' customers' : model.getCustomerCount(business.id).toString()+' customer',
                style: TextStyle(
                  color: Theme.of(context).cursorColor,
                  fontSize: SizeConfig.textSize(context, 4),
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Icon(
                Icons.chevron_right,
                color: ThemeColors.gray[700],
                size: SizeConfig.textSize(context, 8),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _AddBusinessButton extends HookViewModelWidget<MainViewModel> {
  _AddBusinessButton({Key key}) : super(key: key, reactive: true);

  @override
  Widget buildViewModelWidget(
    BuildContext context,
    MainViewModel model,
  ) {
    return CustomRaisedButton(
      txtColor: ThemeColors.background,
      btnColor: BrandColors.primary,
      btnText: 'Add another business',
      borderColor: BrandColors.primary,
      child: Container(),
      onPressed: () => model.navigateToAddBusiness(),
    );
  }
}
