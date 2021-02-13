import 'dart:io';
import 'dart:typed_data';

import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/app/router.dart';
import 'package:mycustomers/core/models/hive/business_card/business_card_h.dart';
import 'package:mycustomers/core/repositories/business_card/business_card_repository.dart';
import 'package:mycustomers/core/services/permission_service.dart';
import 'package:mycustomers/core/utils/logger.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_view.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:wc_flutter_share/wc_flutter_share.dart';

class BusinessCardPageViewModel extends BaseViewModel {
  /// Fields
  final BusinessCardRepository _businessCardRepository =
      locator<BusinessCardRepository>();
  final NavigationService _navigationService = locator<NavigationService>();

  final PermissionService _permissionService = locator<IPermissionService>();
  BusinessCardH _businessCard = BusinessCardH.empty();
  File imageFile;

  /// Getters
  BusinessCardH get businessCard => _businessCard;

  /// Setters
  /// Methods
  void updateBusinessCard({
    String storeName,
    String personalName,
    String phoneNumber,
    String emailAddress,
    String address,
    String position,
    String tagLine,
    String cardDesign,
  }) {
    _businessCard = _businessCard.copyWith(
      storeName: storeName ?? _businessCard.storeName,
      personalName: personalName ?? _businessCard.personalName,
      phoneNumber: phoneNumber ?? _businessCard.phoneNumber,
      emailAddress: emailAddress ?? _businessCard.emailAddress,
      address: address ?? _businessCard.address,
      position: position ?? _businessCard.position,
      tagLine: tagLine ?? _businessCard.tagLine,
      cardDesign: cardDesign ?? _businessCard.cardDesign,
    );
    notifyListeners();
  }

  Future<void> saveBusinessCard() async {
    await _businessCardRepository.saveBusinessCard(businessCard);
    notifyListeners();
  }

  Future<void> shareImageAndText() async {
    try {
      final Uint8List bytes = await imageFile.readAsBytes();
      final String fileName =
          '${businessCard.storeName}-businesscard${businessCard.cardDesign}.png';

      await WcFlutterShare.share(
        sharePopupTitle: 'Share Your Business Card',
        subject: businessCard.storeName,
        text: 'My Business Card',
        fileName: fileName,
        mimeType: 'image/png',
        bytesOfFile: bytes.buffer.asUint8List(),
      );
    } catch (e) {
      Logger.e(e);
      throw Exception("Unable to save image");
    }
  }

  Future<void> downloadImage() async {
    try {
      if (await _permissionService.getStoragePermission()) {
        final Uint8List bytes = await imageFile.readAsBytes();

        final String internalStorage = '/storage/emulated/0/myCustomer';

        final String fileName =
            '${businessCard.storeName}-businesscard${businessCard.cardDesign}.png';

        bool isDirExist = await Directory(internalStorage).exists();
        if (!isDirExist) Directory(internalStorage).create();
        String tempPath = '$internalStorage/$fileName';
        File(tempPath).writeAsBytes(bytes);
      }
    } catch (e) {
      Logger.e(e);
      throw Exception("Unable to download image");
    }
  }

  Future<void> init() async {
    _businessCard = await _businessCardRepository.getBusinessCard();
    notifyListeners();
  }

  Future navigateToBusinessCardPage() async {
    await _navigationService.navigateTo(Routes.businessCardRoute);
  }
}
