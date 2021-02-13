import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/constants/hive_boxes.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';

abstract class BusinessCardLocalDataSource {
  Future<void> init();

  Future<BusinessCardH> getBusinessCardH(String id);

  Future<BusinessCardH> updateBusinessCardH(
      String id, BusinessCardH businessCard);

  Future<void> createBusinessCardH(String id, BusinessCardH businessCard);

  Future<void> deleteBusinessCardH(String id);
}

class BusinessCardLocalDataSourceImpl implements BusinessCardLocalDataSource {
  final _hiveService = locator<HiveInterface>();

  bool get _isBoxOpen => _hiveService.isBoxOpen(HiveBox.businessCardBoxName);

  Box<BusinessCardH> get businessCardBox =>
      _hiveService.box<BusinessCardH>(HiveBox.businessCardBoxName);

  @override
  Future<void> init() async {
    _hiveService.registerAdapter<BusinessCardH>(BusinessCardAdapter());

    if (!_isBoxOpen) {
      await _hiveService.openBox<BusinessCardH>(HiveBox.businessCardBoxName);
    }
  }

  @override
  Future<BusinessCardH> getBusinessCardH(String id) async {
    final BusinessCardH businessCard = businessCardBox.get(id);
    return Future.value(businessCard);
  }

  @override
  Future<void> createBusinessCardH(String id, newBusinessCardH) async {
    businessCardBox.put(id, newBusinessCardH);
    return Future.value();
  }

  @override
  Future<void> deleteBusinessCardH(String id) {
    // TODO: implement deleteBusinessCardH
    throw UnimplementedError();
  }

  @override
  Future<BusinessCardH> updateBusinessCardH(
      String id, BusinessCardH businessCard) {
    // TODO: implement updateBusinessCardH
    throw UnimplementedError();
  }
}
