import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/log/log_local_data_source.dart';
import 'package:stacked/stacked.dart';
import 'package:mycustomers/core/services/bussiness_setting_service.dart';

class CurrencySettingPageViewModel extends ReactiveViewModel{
  final _bussinessSettingService = locator<BussinessSettingService>();
  final LogsLocalDataSourceImpl _logService = locator<LogsLocalDataSourceImpl>();
  int get index => _bussinessSettingService.currency;
  List get currencies => _bussinessSettingService.currencies;
  int tempIndex;

  void selectCurrency(int ind) {
    _bussinessSettingService.selectCurrency(ind);
    tempIndex = ind;
    notifyListeners();
  }

  void saveCurrencyIndex(){
    _bussinessSettingService.addCurrency(currencies[tempIndex]['country']);
    _logService.getValues(null, DateTime.now(), 'curr-change', currencies[tempIndex]['name'], false);
  }

  void resetCurrency(){
    _bussinessSettingService.selectCurrency(index);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_bussinessSettingService];
}