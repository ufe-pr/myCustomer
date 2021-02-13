import 'package:hive/hive.dart';
import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/models/store.dart';
import 'package:mycustomers/core/models/hive/store/store_h.dart';
import 'package:mycustomers/core/repositories/store/store_repository.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:uuid/uuid.dart';

abstract class StoresLocalDataSource {
  Future<void> init();

  Store getStore(String id);

  Iterable<Store> getStores();

  Iterable<Store> getStoresWhere(Function(StoreH) test);

  Future<Store> updateStore(String id, Store update);

  Future<bool> createStore(Store newStore, [String id]);

  Future<bool> deleteStore(String id);
}

class StoresLocalDataSourceImpl implements StoresLocalDataSource {
  
  StoresLocalDataSourceImpl() {
    init();
  }
  static const STORE_HIVE_BOX_NAME = 'STORE';

   final _hiveService = locator<HiveInterface>();
  final _auth = locator<AuthService>();

  static Box<StoreH> storeBox;

  @override
  Future<void> init() async {
    //Write Function to initialize Hive
    await _hiveService.openBox<StoreH>(STORE_HIVE_BOX_NAME);
    storeBox = _hiveService.box<StoreH>(STORE_HIVE_BOX_NAME);
  }

  String genUuid() {
    return Uuid().v1();
  }

  //
  // Read Operations
  //

  @override
  Store getStore(String id) {
    var store = storeBox.get(id);
    return Store.fromStoreH(store);
  }

  @override
  Iterable<Store> getStores() {
    return storeBox.values.where((element) => element.ownerId == _auth.currentUser.id).map((e) => Store.fromStoreH(e));
  }

  @override
  Iterable<Store> getStoresWhere(Function(StoreH p1) test) {
    return storeBox.values.where((element) => element.id == _auth.currentUser.id).where(test).map((e) => Store.fromStoreH(e));
  }

  List<int> splitPhone(String phone) {
    try {
      var pNum = phone.substring(phone.length - 10);
      var ctyCode = phone.substring(0, phone.length - 10);
      return [int.parse(pNum), int.parse(ctyCode)];
    } catch (e) {
      return [null, null];
    }
  }

  //
  // Create operation
  //

  @override
  Future<bool> createStore(Store newStore, [String id]) async {
    print(newStore.phone);
    var splitP = splitPhone(newStore.phone);
    var newStoreH = StoreH(
        id ?? genUuid(),
        newStore.address,
        newStore.name,
        splitP[0],
        splitP[1],
        newStore.tagline,
        _auth.currentUser.id,
        newStore.email);
    await storeBox.put(newStoreH.id, newStoreH);
    await StoreRepository.updateStores();
    StoreRepository.changeSelectedStore(newStoreH.id);
    return true;
  }

  //
  // Update Operations
  //

  @override
  Future<Store> updateStore(String id, Store update) async {
    var splitP = splitPhone(update.phone);
    var sToUpdate = storeBox.get(id);
    var updatedStore = StoreH(
        id,
        update.address ?? sToUpdate.address,
        update.name ?? sToUpdate.name,
        splitP[0] ?? sToUpdate.pNum,
        splitP[1] ?? sToUpdate.ctyCode,
        update.tagline ?? sToUpdate.tagline,
        sToUpdate.ownerId,
        sToUpdate.email);
    await storeBox.put(updatedStore.id, updatedStore);
    return Store.fromStoreH(updatedStore);
  }

  @override
  Future<bool> deleteStore(String id) async {
    try {
      await storeBox.delete(id);
      return true;
    } catch (e) {
      return false;
    }
  }

  //
  // Delete ops
  //

}
