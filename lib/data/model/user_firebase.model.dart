import 'package:json_annotation/json_annotation.dart';
part 'user_firebase.model.g.dart';
@JsonSerializable()
class UsersFirebase{
  final String? id;
  final String? name;
  factory UsersFirebase.fromJson(Map<String, dynamic> json) => _$UsersFirebaseFromJson(json);
  UsersFirebase({this.id, this.name});
  Map<String, dynamic> toJson() => _$UsersFirebaseToJson(this);
}
