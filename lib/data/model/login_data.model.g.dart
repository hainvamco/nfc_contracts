// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_data.model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginData _$LoginDataFromJson(Map<String, dynamic> json) => LoginData(
      contractData: json['contractData'] == null
          ? null
          : ContractsFirebase.fromJson(
              json['contractData'] as Map<String, dynamic>),
      userData: json['userData'] == null
          ? null
          : UsersFirebase.fromJson(json['userData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LoginDataToJson(LoginData instance) => <String, dynamic>{
      'contractData': instance.contractData?.toJson(),
      'userData': instance.userData?.toJson(),
    };
