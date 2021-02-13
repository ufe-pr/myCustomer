import 'package:json_annotation/json_annotation.dart';
import 'package:mycustomers/core/enums/message_type.dart';

part 'message.g.dart';

@JsonSerializable(nullable: true, includeIfNull: true)
class Message {
  int id;
  String message, subject;

  @JsonKey(fromJson: typeFromJson, name: 'type', toJson: typeToJson)
  MessageType messageType;

  Message({this.id, this.message, this.messageType, this.subject});

  factory Message.fromJson(Map<String, dynamic> json) => _$MessageFromJson(json);
  Map<String, dynamic> toJson() => _$MessageToJson(this);

  static MessageType typeFromJson(int type) {
    return MessageType.values[type + 1];
  }

  static int typeToJson(MessageType type) {
    return type.index + 1;
  }
}