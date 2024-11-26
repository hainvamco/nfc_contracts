import 'package:flutter/material.dart';
import 'package:nfc_contracts/data/model/login_data.model.dart';
import 'package:nfc_contracts/presenter/home/user_info.dart';

class HomePage extends StatelessWidget {
  /// Constructs a [HomePage]
  final LoginData loginData;
  const HomePage({super.key, required this.loginData});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('NFC Contracts'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UserContractInfo(
                  userName: loginData.userData?.name,
                  contractName: loginData.contractData?.name),
            ],
          ),
        ),
      ),
    );
  }
}
