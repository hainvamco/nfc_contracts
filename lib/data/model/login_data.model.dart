import 'package:json_annotation/json_annotation.dart';
import 'package:nfc_contracts/data/model/contracts_firebase.model.dart';
import 'package:nfc_contracts/data/model/user_firebase.model.dart';

// part 'login_data.model.g.dart';

@JsonSerializable()
class LoginData {
  final ContractsFirebase? contractData;
  final String? contractsDocId;
  final String? userDocId;
  final UsersFirebase? userData;
  factory LoginData.fromJson(Map<String, dynamic> json) =>
      _$LoginDataFromJson(json);
  LoginData(
      {this.contractData, this.userData, this.contractsDocId, this.userDocId});
  Map<String, dynamic> toJson() => _$LoginDataToJson(this);
}

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      contractData: json['contractData'] == null
          ? null
          : ContractsFirebase.fromJson(
              json['contractData'] as Map<String, dynamic>),
      userData: json['userData'] == null
          ? null
          : UsersFirebase.fromJson(json['userData'] as Map<String, dynamic>),
      contractsDocId: json['contractsDocId'] as String?,
      userDocId: json['userDocId'] as String?,
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'contractData': instance.contractData?.toJson(),
      'contractsDocId': instance.contractsDocId,
      'userDocId': instance.userDocId,
      'userData': instance.userData?.toJson(),
    };
