import 'package:json_annotation/json_annotation.dart';
part 'call_firebase.model.g.dart';

@JsonSerializable()
class CallFirebase {
  final String? id;
  final String? name;
  factory CallFirebase.fromJson(Map<String, dynamic> json) =>
      _$CallFirebaseFromJson(json);
  CallFirebase({this.id, this.name});
  Map<String, dynamic> toJson() => _$CallFirebaseToJson(this);
}
