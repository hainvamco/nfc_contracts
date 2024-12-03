import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/const/share_storage.dart';
import 'package:nfc_contracts/main.dart';
import 'package:nfc_contracts/main.route.dart';
import 'package:nfc_contracts/presenter/register/register_cubit/register_cubit.dart';

class RegisterPage extends StatelessWidget {
  /// Constructs a [RegisterPage]
  final String idUserFirebase;
  const RegisterPage({super.key, required this.idUserFirebase});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Register Screen'),
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('User id register: $idUserFirebase'),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomTextField(
                  hintText: 'Enter your name',
                  prefixIcon: Icons.account_circle_outlined,
                  controller: context.read<RegisterCubit>().nameController,
                ),
              ),
              BlocBuilder<RegisterCubit, RegisterState>(
                buildWhen: (previous, current) => previous.name != current.name,
                builder: (context, state) {
                  return Visibility(
                    visible: state.name.isNotEmpty,
                    child: ElevatedButton(
                        onPressed: () async {
                          var confirm = await showConfirmDialog(context,
                              title: 'Create Account',
                              content:
                                  'You will create account with \n name: ${state.name} \n idm : $idUserFirebase ');
                          if (confirm == true) {
                            firebaseRepo.registerContract(
                              idm: idUserFirebase,
                              name: state.name,
                              contractsName: 'demo',
                              token: PrefUtil.getToken() ?? '',
                              onSuccess: (result) {
                                context.push(RouterPath.routerHome,
                                    extra: result.toJson());
                              },
                            );
                          }
                        },
                        child: Text('CREATE USER')),
                  );
                },
              )

              // ElevatedButton(
              //   onPressed: () {
              //     context.popUntilPath(routePath: '/');
              //   },
              //   child: const Text('Go Splash'),
              // ),
              // ElevatedButton(
              //   onPressed: () {
              //     context.push(RouterPath.routerHome);
              //   },
              //   child: const Text('Go Home'),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final bool isPassword;
  final TextEditingController controller;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.isPassword = false,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: isPassword, // Ẩn/hiện mật khẩu
      controller: context.read<RegisterCubit>().nameController,
      decoration: InputDecoration(
        filled: true, // Background màu
        fillColor: Colors.grey[200],
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[600]),
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.grey[800],
              )
            : null,
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30), // Góc bo tròn
          borderSide: BorderSide.none, // Không có viền
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.transparent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
              BorderSide(color: Colors.blue, width: 2), // Viền khi focus
        ),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(Icons.visibility_off, color: Colors.grey[600]),
                onPressed: () {
                  // Thêm logic để ẩn/hiện mật khẩu nếu cần
                },
              )
            : null,
      ),
      style: TextStyle(fontSize: 16, color: Colors.black),
    );
  }
}

Future<bool?> showConfirmDialog(BuildContext context,
    {required String title, required String content}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        content: Text(content),
        actions: [
          // Nút "No"
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false); // Trả về `false`
            },
            child: Text("Cancel", style: TextStyle(color: Colors.red)),
          ),
          // Nút "Yes"
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(true); // Trả về `true`
            },
            child: Text("Create"),
          ),
        ],
      );
    },
  );
}
