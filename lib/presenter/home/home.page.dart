import 'package:flutter/material.dart';
import 'package:nfc_contracts/const/share_storage.dart';
import 'package:nfc_contracts/data/model/login_data.model.dart';
import 'package:nfc_contracts/data/repository/firebase_repo.dart';
import 'package:nfc_contracts/presenter/home/user_info.dart';

class HomePage extends StatefulWidget {
  final LoginData loginData;
  const HomePage({super.key, required this.loginData});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    if (widget.loginData.contractsDocId != null &&
        widget.loginData.contractsDocId!.isNotEmpty &&
        PrefUtil.getToken() != null &&
        PrefUtil.getToken()!.isNotEmpty) {
      FirebaseRepo().setTokenUserLogin(
          contractId: widget.loginData.contractsDocId ?? '',
          userDocId: widget.loginData.userDocId ?? '',
          tokenFirebase: PrefUtil.getToken() ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    print('---on build HomePage');
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
              // Text('token ${PrefUtil.getToken()}'),
              UserContractInfo(
                  userName: '${widget.loginData.userData?.name}',
                  // '${widget.loginData.userData?.name} - ${widget.loginData.userData?.id} \n- ${widget.loginData.userDocId}',
                  contractName: '${widget.loginData.contractData?.name}'),
              // '${widget.loginData.contractData?.name} - ${widget.loginData.contractData?.id} \n- ${widget.loginData.contractsDocId}'),
            ],
          ),
        ),
      ),
    );
  }
}
