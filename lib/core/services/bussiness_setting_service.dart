import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/country_currency_model.dart';
import 'package:observable_ish/observable_ish.dart';
import 'package:stacked/stacked.dart';

@lazySingleton
class BussinessSettingService with ReactiveServiceMixin{
  

  RxValue<int> _currency = RxValue<int>(initial: 0);
  RxValue<int> _language = RxValue<int>(initial: 0);

  RxValue<int> _tempcurrency = RxValue<int>(initial: 0);
  RxValue<int> _templanguage = RxValue<int>(initial: 0);

  RxValue<CountryCurrency> _curren = RxValue<CountryCurrency>(initial: null);
  CountryCurrency get curren => _curren.value;

  List langs = [
    { 'name': 'English', 'selected': true, 'code': 'en' },
    { 'name': 'Francias', 'selected': false, 'code': 'fr' },
  ];
  List currencies = [
    { 'name': 'Naira(NGN)', 'country': 'Nigeria',  'selected': true,  'code': 'NGN' },
    { 'name': 'Dollar(USD)', 'country': 'United States of America (USA)', 'selected': false, 'code': 'USD' },
    { 'name': 'Indian Rubies(INR)', 'country': 'India', 'selected': false, 'code': 'INR' },
  ];

  int get currency => _currency.value;
  int get language => _language.value;

  int get tempcurrency => _tempcurrency.value;
  int get templanguage => _templanguage.value;

  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.currency);
  Box<CountryCurrency> get _currencyBox => _hiveService.box<CountryCurrency>(HiveBox.currency);

  BussinessSettingService(){
    listenToReactiveValues([_currency, _language, langs, currencies]);
  }

  Future<void> init() async {
    _hiveService.registerAdapter(CountryCurrencyAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<CountryCurrency>(HiveBox.currency);
    }
  }

  void getCurrency(){
    if(_currencyBox.values.toList().length == 0){
      _curren.value = CountryCurrency(country: 'Nigeria', symbol:'₦');
      _currency.value = 0;
    } else {
      _curren.value = _currencyBox.values.toList()[0];
      for(var item in currencies) {
      if(_curren.value.country == item['country']){
        _currency.value = currencies.indexOf(item);
        _tempcurrency.value = currencies.indexOf(item);
        currencies[0]['selected'] = false;
        item['selected'] = true;
      }
    }
    }
  }

  void addCurrency(String country)async {
    for(var item in CountryCurrency.getCurrencySymbol()) {
      if(item.country == country) {
        if(_currencyBox.values.toList().length == 0){
          await _currencyBox.add(item);
        } else {
          await _currencyBox.putAt(0, item);
        }
      }
    }
    getCurrency();
  }

  void selectLangs(int ind){
    langs[templanguage]['selected'] = !langs[templanguage]['selected'];
    langs[ind]['selected'] = !langs[ind]['selected'];
    _templanguage.value = ind;
  }

  void selectCurrency(int ind) {
    currencies[tempcurrency]['selected'] = !currencies[tempcurrency]['selected'];
    currencies[ind]['selected'] = !currencies[ind]['selected'];
    _tempcurrency.value = ind;
  }

  void setCurrencyIndex(int ind){
    _currency.value = ind;
  }

  void setLanguageIndex(int ind){
    _language.value = ind;
  }

 

}