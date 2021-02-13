import 'package:mycustomers/app/locator.dart';
import 'package:mycustomers/core/services/auth/auth_service.dart';
import 'package:mycustomers/core/services/http/http_service.dart';
import 'package:mycustomers/core/constants/api_routes.dart';
//import 'package:mycustomers/core/exceptions/auth_exception.dart';
import 'package:mycustomers/core/exceptions/create_exception.dart';
import 'package:mycustomers/core/utils/logger.dart';


class UserService {
  static String baseUserRoute = ApiRoutes.user;
  HttpService _http = locator<HttpService>();
  AuthService _auth = locator<AuthService>();
  String _newRoute = '$baseUserRoute/new';
//  String _getRoute = baseUserRoute;
//  String _deleteRoute = '$baseUserRoute/delete';

  Future<void> createAssistant(String name, {Map extraData, String phoneNumber}) async {
    try {
      // Send the request to the API with the data
      Map response = await _http.postHttp(_newRoute, {
        'phone_number': phoneNumber ?? _auth.currentUser.phoneNumber,
        'name': name,
      }..addAll(extraData ?? {}));

      // Check if the status is true
      if (response.containsKey('status') && response['status']) {
        // TODO: Add what should happen if update is successful
      } else if (response.containsKey('message')) {
        Logger.e('Error creating Assistant: ${response['message']}');
        throw CreateException(response['message']);
      } else {
        Logger.e('Error creating Assistant: Unknown Error');
        throw CreateException('Bad response from server');
      }

      // TODO: Add what to do after creating new assistant
    } on CreateException catch(e, s) {
      Logger.e('Error creating Assistant: ${e.message}', e: e, s: s);
      throw e;
    } catch(e, s) {
      Logger.e('Error creating Assistant $name with phone number: ${phoneNumber ?? _auth.currentUser.phoneNumber} and extra data: $extraData', e: e, s: s);
      throw CreateException('Unknown error while trying to create Assistant');
    }
  }
}
