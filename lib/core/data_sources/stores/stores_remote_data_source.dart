import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/services/api_services.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
import 'package:mycustomers/core/exceptions/create_exception.dart';
import 'package:mycustomers/core/exceptions/get_exception.dart';
import 'package:mycustomers/core/utils/logger.dart';

abstract class StoreDataSource {
  Future<void> createStore(String storeName, {String shopAddress: '-'});

  Future<Store> getStore(String storeId);

  Future<List<Store>> getStores();
}

class StoreDataSourceImpl implements StoreDataSource {
  static String baseStoreRoute = ApiRoutes.user;
  HttpService _http = locator<HttpService>();
  String _newRoute = '$baseStoreRoute/new';
  IApi _api = locator<IApi>();

  @override
  Future<void> createStore(String storeName, {String shopAddress: '-'}) async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));

      // Send the request to the API with the data
      Map response = await _api.newStore(storeName, shopAddress);

      // Check if the status is true
      if (response.containsKey('success') && response['success']) {
        // TODO: Add what should happen if create is successful
        await StoreRepository.updateStores();
      } else if (response.containsKey('message')) {
        Logger.e('Error creating store: ${response['message']}');
        throw CreateException(response['message']);
      } else {
        Logger.e('Error creating store: Unknown Error');
        throw CreateException('Bad response from server');
      }

      // TODO: Add what should happen after creating new store
    } on CreateException catch (e, s) {
      Logger.e('Error creating store: ${e.message}', e: e, s: s);
      throw e;
    } catch (e, s) {
      Logger.e('Error creating store $storeName with location: $shopAddress',
          e: e, s: s);
      // throw CreateException('Unknown error occur while trying to update details');
      throw CreateException(
          'Unknown error occur while trying to create your store');
    }
  }

  @override
  Future<Store> getStore(String storeId) async {
    try {
      // Send the request to the API with the data
      Map response = await _api.getStore(storeId);

      // Check if the status is true
      if (response.containsKey('status') && response['status']) {
        return Store.fromJson(response['data']['store']);
      } else if (response.containsKey('message')) {
        Logger.e('Error fetching store: ${response['message']}');
        throw GetException(response['message']);
      } else {
        Logger.e('Error fetching store: Unknown Error');
        throw GetException('Bad response from server');
      }

      // TODO: Add what should happen after creating new store
    } on GetException catch (e, s) {
      Logger.e('Error getting store: ${e.message}', e: e, s: s);
      throw e;
    } catch (e, s) {
      Logger.e('Error fetching store  with ID: $storeId', e: e, s: s);
      throw GetException('Unknown error while trying to get store');
    }
  }

  @override
  Future<List<Store>> getStores() async {
    try {
      // authenticate with server
      await Future.delayed(Duration(milliseconds: 250));
      // Send the request to the API with the data
      Map response = await _api.getAllStores();

      // Check if the status is true
      if (response.containsKey('success') && response['success']) {
        return List.from(
            response['data']['stores'].map((elem) => Store.fromJson(elem)));
      } else if (response.containsKey('message')) {
        Logger.e('Error fetching stores: ${response['message']}');
        throw GetException(response['message']);
      } else {
        Logger.e('Error fetching stores: Unknown Error');
        throw GetException('Bad response from server');
      }

      // TODO: Add what should happen after creating new store
    } on GetException catch (e, s) {
      Logger.e('Error getting stores: ${e.message}', e: e, s: s);
      throw e;
    } catch (e, s) {
      Logger.e('Error fetching all stores', e: e, s: s);
      throw GetException('Unknown error while trying to get store');
    }
  }
}
