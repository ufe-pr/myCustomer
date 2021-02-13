import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/data_sources/business_card/business_card_local_data_source.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/models/user.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:meta/meta.dart';

import 'business_card_repository.dart';

class BusinessCardRepositoryImpl implements BusinessCardRepository {
  final String key = 'business_card';
  final AuthService authService = locator<AuthService>();
  final BusinessCardLocalDataSource localDataSource;

  BusinessCardRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<void> saveBusinessCard(BusinessCardH businessCard) async {
    Store store = StoreRepository.currentStore;
    await localDataSource.createBusinessCardH(store.id, businessCard);
    return Future.value();
  }

  @override
  Future<BusinessCardH> getBusinessCard() async {
    Store store = StoreRepository.currentStore;

    if (store == null) return BusinessCardH.empty();

    BusinessCardH businessCardH =
        await localDataSource.getBusinessCardH(store.id);

    if (businessCardH == null) {
      User user = authService.currentUser;
      BusinessCardH businessCard = BusinessCardH(
        storeName: store.name ?? BusinessCardH.empty().storeName,
        personalName: '${user.firstName == null ? '' : user.firstName + ' '}${user.lastName ?? ''}' ??
            BusinessCardH.empty().personalName,
        phoneNumber: user.phoneNumber ?? BusinessCardH.empty().phoneNumber,
        emailAddress: user.email ?? '', // BusinessCardH.empty().emailAddress,
        address: store.address ?? BusinessCardH.empty().address,
        tagLine: store.tagline ?? '', // BusinessCardH.empty().tagLine,
        position: BusinessCardH.empty().position,
        cardDesign: BusinessCardH.empty().cardDesign,
      );
      return Future.value(businessCard);
    } else {
      return Future.value(businessCardH.copyWith(
          phoneNumber: authService.currentUser.phoneNumber ?? BusinessCardH.empty().phoneNumber,
      ));
    }
  }
}
