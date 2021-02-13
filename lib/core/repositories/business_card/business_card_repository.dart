import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';

abstract class BusinessCardRepository {

  Future<void> saveBusinessCard(BusinessCardH businessCard);

  Future<BusinessCardH> getBusinessCard();
}
