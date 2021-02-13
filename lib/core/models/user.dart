import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable(explicitToJson: true, nullable: true, includeIfNull: true, ignoreUnannotated: true)
class User {
  String id;

  @JsonKey(name: 'email')
  String email;

  @JsonKey(name: 'first_name')
  String firstName;

  @JsonKey(name: 'last_name')
  String lastName;

  @JsonKey(name: 'user_role')
  String userRole;

  @JsonKey(name: 'phone_number')
  var phoneNumber;
  

  User({this.id, this.email, this.firstName, this.lastName, this.userRole, this.phoneNumber});

   factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
   Map<String, dynamic> toJson() => _$UserToJson(this);

}