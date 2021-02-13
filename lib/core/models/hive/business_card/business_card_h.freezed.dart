// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named

part of 'business_card_h.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

class _$BusinessCardHTearOff {
  const _$BusinessCardHTearOff();

  _BusinessCard call(
      {@required @HiveField(0) String storeName,
      @required @HiveField(1) String personalName,
      @required @HiveField(2) String phoneNumber,
      @required @HiveField(3) String emailAddress,
      @required @HiveField(4) String address,
      @required @HiveField(5) String tagLine,
      @required @HiveField(6) String position,
      @required @HiveField(7) String cardDesign}) {
    return _BusinessCard(
      storeName: storeName,
      personalName: personalName,
      phoneNumber: phoneNumber,
      emailAddress: emailAddress,
      address: address,
      tagLine: tagLine,
      position: position,
      cardDesign: cardDesign,
    );
  }
}

// ignore: unused_element
const $BusinessCardH = _$BusinessCardHTearOff();

mixin _$BusinessCardH {
  @HiveField(0)
  String get storeName;
  @HiveField(1)
  String get personalName;
  @HiveField(2)
  String get phoneNumber;
  @HiveField(3)
  String get emailAddress;
  @HiveField(4)
  String get address;
  @HiveField(5)
  String get tagLine;
  @HiveField(6)
  String get position;
  @HiveField(7)
  String get cardDesign;

  $BusinessCardHCopyWith<BusinessCardH> get copyWith;
}

abstract class $BusinessCardHCopyWith<$Res> {
  factory $BusinessCardHCopyWith(
          BusinessCardH value, $Res Function(BusinessCardH) then) =
      _$BusinessCardHCopyWithImpl<$Res>;
  $Res call(
      {@HiveField(0) String storeName,
      @HiveField(1) String personalName,
      @HiveField(2) String phoneNumber,
      @HiveField(3) String emailAddress,
      @HiveField(4) String address,
      @HiveField(5) String tagLine,
      @HiveField(6) String position,
      @HiveField(7) String cardDesign});
}

class _$BusinessCardHCopyWithImpl<$Res>
    implements $BusinessCardHCopyWith<$Res> {
  _$BusinessCardHCopyWithImpl(this._value, this._then);

  final BusinessCardH _value;
  // ignore: unused_field
  final $Res Function(BusinessCardH) _then;

  @override
  $Res call({
    Object storeName = freezed,
    Object personalName = freezed,
    Object phoneNumber = freezed,
    Object emailAddress = freezed,
    Object address = freezed,
    Object tagLine = freezed,
    Object position = freezed,
    Object cardDesign = freezed,
  }) {
    return _then(_value.copyWith(
      storeName: storeName == freezed ? _value.storeName : storeName as String,
      personalName: personalName == freezed
          ? _value.personalName
          : personalName as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress as String,
      address: address == freezed ? _value.address : address as String,
      tagLine: tagLine == freezed ? _value.tagLine : tagLine as String,
      position: position == freezed ? _value.position : position as String,
      cardDesign:
          cardDesign == freezed ? _value.cardDesign : cardDesign as String,
    ));
  }
}

abstract class _$BusinessCardCopyWith<$Res>
    implements $BusinessCardHCopyWith<$Res> {
  factory _$BusinessCardCopyWith(
          _BusinessCard value, $Res Function(_BusinessCard) then) =
      __$BusinessCardCopyWithImpl<$Res>;
  @override
  $Res call(
      {@HiveField(0) String storeName,
      @HiveField(1) String personalName,
      @HiveField(2) String phoneNumber,
      @HiveField(3) String emailAddress,
      @HiveField(4) String address,
      @HiveField(5) String tagLine,
      @HiveField(6) String position,
      @HiveField(7) String cardDesign});
}

class __$BusinessCardCopyWithImpl<$Res>
    extends _$BusinessCardHCopyWithImpl<$Res>
    implements _$BusinessCardCopyWith<$Res> {
  __$BusinessCardCopyWithImpl(
      _BusinessCard _value, $Res Function(_BusinessCard) _then)
      : super(_value, (v) => _then(v as _BusinessCard));

  @override
  _BusinessCard get _value => super._value as _BusinessCard;

  @override
  $Res call({
    Object storeName = freezed,
    Object personalName = freezed,
    Object phoneNumber = freezed,
    Object emailAddress = freezed,
    Object address = freezed,
    Object tagLine = freezed,
    Object position = freezed,
    Object cardDesign = freezed,
  }) {
    return _then(_BusinessCard(
      storeName: storeName == freezed ? _value.storeName : storeName as String,
      personalName: personalName == freezed
          ? _value.personalName
          : personalName as String,
      phoneNumber:
          phoneNumber == freezed ? _value.phoneNumber : phoneNumber as String,
      emailAddress: emailAddress == freezed
          ? _value.emailAddress
          : emailAddress as String,
      address: address == freezed ? _value.address : address as String,
      tagLine: tagLine == freezed ? _value.tagLine : tagLine as String,
      position: position == freezed ? _value.position : position as String,
      cardDesign:
          cardDesign == freezed ? _value.cardDesign : cardDesign as String,
    ));
  }
}

@HiveType(typeId: 0, adapterName: 'BusinessCardAdapter')
class _$_BusinessCard implements _BusinessCard {
  _$_BusinessCard(
      {@required @HiveField(0) this.storeName,
      @required @HiveField(1) this.personalName,
      @required @HiveField(2) this.phoneNumber,
      @required @HiveField(3) this.emailAddress,
      @required @HiveField(4) this.address,
      @required @HiveField(5) this.tagLine,
      @required @HiveField(6) this.position,
      @required @HiveField(7) this.cardDesign})
      : assert(storeName != null),
        assert(personalName != null),
        assert(phoneNumber != null),
        assert(emailAddress != null),
        assert(address != null),
        assert(tagLine != null),
        assert(position != null),
        assert(cardDesign != null);

  @override
  @HiveField(0)
  final String storeName;
  @override
  @HiveField(1)
  final String personalName;
  @override
  @HiveField(2)
  final String phoneNumber;
  @override
  @HiveField(3)
  final String emailAddress;
  @override
  @HiveField(4)
  final String address;
  @override
  @HiveField(5)
  final String tagLine;
  @override
  @HiveField(6)
  final String position;
  @override
  @HiveField(7)
  final String cardDesign;

  @override
  String toString() {
    return 'BusinessCardH(storeName: $storeName, personalName: $personalName, phoneNumber: $phoneNumber, emailAddress: $emailAddress, address: $address, tagLine: $tagLine, position: $position, cardDesign: $cardDesign)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _BusinessCard &&
            (identical(other.storeName, storeName) ||
                const DeepCollectionEquality()
                    .equals(other.storeName, storeName)) &&
            (identical(other.personalName, personalName) ||
                const DeepCollectionEquality()
                    .equals(other.personalName, personalName)) &&
            (identical(other.phoneNumber, phoneNumber) ||
                const DeepCollectionEquality()
                    .equals(other.phoneNumber, phoneNumber)) &&
            (identical(other.emailAddress, emailAddress) ||
                const DeepCollectionEquality()
                    .equals(other.emailAddress, emailAddress)) &&
            (identical(other.address, address) ||
                const DeepCollectionEquality()
                    .equals(other.address, address)) &&
            (identical(other.tagLine, tagLine) ||
                const DeepCollectionEquality()
                    .equals(other.tagLine, tagLine)) &&
            (identical(other.position, position) ||
                const DeepCollectionEquality()
                    .equals(other.position, position)) &&
            (identical(other.cardDesign, cardDesign) ||
                const DeepCollectionEquality()
                    .equals(other.cardDesign, cardDesign)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(storeName) ^
      const DeepCollectionEquality().hash(personalName) ^
      const DeepCollectionEquality().hash(phoneNumber) ^
      const DeepCollectionEquality().hash(emailAddress) ^
      const DeepCollectionEquality().hash(address) ^
      const DeepCollectionEquality().hash(tagLine) ^
      const DeepCollectionEquality().hash(position) ^
      const DeepCollectionEquality().hash(cardDesign);

  @override
  _$BusinessCardCopyWith<_BusinessCard> get copyWith =>
      __$BusinessCardCopyWithImpl<_BusinessCard>(this, _$identity);
}

abstract class _BusinessCard implements BusinessCardH {
  factory _BusinessCard(
      {@required @HiveField(0) String storeName,
      @required @HiveField(1) String personalName,
      @required @HiveField(2) String phoneNumber,
      @required @HiveField(3) String emailAddress,
      @required @HiveField(4) String address,
      @required @HiveField(5) String tagLine,
      @required @HiveField(6) String position,
      @required @HiveField(7) String cardDesign}) = _$_BusinessCard;

  @override
  @HiveField(0)
  String get storeName;
  @override
  @HiveField(1)
  String get personalName;
  @override
  @HiveField(2)
  String get phoneNumber;
  @override
  @HiveField(3)
  String get emailAddress;
  @override
  @HiveField(4)
  String get address;
  @override
  @HiveField(5)
  String get tagLine;
  @override
  @HiveField(6)
  String get position;
  @override
  @HiveField(7)
  String get cardDesign;
  @override
  _$BusinessCardCopyWith<_BusinessCard> get copyWith;
}
