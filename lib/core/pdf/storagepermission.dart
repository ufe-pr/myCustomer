import 'package:permission_handler/permission_handler.dart';

storagePermission() async {
  final _permission = Permission.storage;
  var status = await _permission.status;
  if (status != PermissionStatus.granted) {
    status = await _permission.request();
  }
  print(status);
}
