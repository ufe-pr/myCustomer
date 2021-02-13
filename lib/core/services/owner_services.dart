import 'package:mycustomers/core/models/customer.dart';
import 'permission_service.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:mockito/mockito.dart';

class IOwnerServices {
  getPhoneContacts({String query}) {}
}

class MockOwnerService extends Mock implements IOwnerServices {
  
}

class OwnerServices implements IOwnerServices {

  PermissionService _permission = new PermissionService();

  // method to get contacts from the user's device
  @override
  Future<Iterable<Customer>> getPhoneContacts({String query}) async {
    final bool isPermitted =
        await _permission.getContactsPermission();
    if (isPermitted) {
      Iterable<Contact> rawContacts = await ContactsService.getContacts(query: query, withThumbnails: false, photoHighResolution: false,);
      return rawContacts.where((element) => element?.givenName != null || element?.displayName != null || (element?.givenName?.isNotEmpty ?? false) || (element?.displayName?.isNotEmpty ?? false) || (element?.phones?.isNotEmpty ?? false)).map((contact) => Customer.fromJson({
        'name': contact?.givenName?.isEmpty ?? true ? contact.displayName : contact.givenName,
        'lastname': contact?.familyName?.isEmpty??true?'':contact.familyName,
        'phone': contact?.phones?.toList()?.isEmpty ?? true ? '' : contact.phones.toList()[0].value,
        'email': contact?.emails?.toList()?.isEmpty ?? true ? '' : contact.emails.toList()[0].value,
        'initials': contact?.initials()?.isEmpty ?? true ? '' : contact.initials()
      }));
    }
    return Iterable<Customer>.empty();
  }

}
