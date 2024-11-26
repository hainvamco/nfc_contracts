import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_contracts/data/model/contracts_firebase.model.dart';
import 'package:nfc_contracts/data/model/user_firebase.model.dart';

part 'login_data.model.g.dart';

@JsonSerializable()
class LoginData {
  final ContractsFirebase? contractData;
  final UsersFirebase? userData;
  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  LoginData({this.contractData, this.userData});
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}
