import 'package:json_annotation/json_annotation.dart';
part 'contracts_firebase.model.g.dart';

@JsonSerializable()
class ContractsFirebase {
  final String? id;
  final String? name;
  final String? callId;
  factory ContractsFirebase.fromJson(Map<String, dynamic> json) =>
      _$ContractsFirebaseFromJson(json);
  ContractsFirebase({this.id, this.name, this.callId});
  Map<String, dynamic> toJson() => _$ContractsFirebaseToJson(this);
}
