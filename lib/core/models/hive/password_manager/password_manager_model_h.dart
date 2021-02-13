
import 'package:hive/hive.dart';

part 'password_manager_model_h.g.dart';

@HiveType(typeId: 1, adapterName: 'PasswordManagerAdapter')

class PasswordManager {
  @HiveField(0)
  final String userPassword;

  PasswordManager(this.userPassword);

}

