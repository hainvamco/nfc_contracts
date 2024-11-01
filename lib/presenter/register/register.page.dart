import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/main.route.dart';

class RegisterPage extends StatelessWidget {
  /// Constructs a [RegisterPage]
  const RegisterPage({super.key});

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
            children: [
              ElevatedButton(
                onPressed: () {
                  context.popUntilPath(routePath: '/');
                },
                child: const Text('Go Splash'),
              ),
              ElevatedButton(
                onPressed: () {
                  context.push(RouterPath.routerHome);
                },
                child: const Text('Go Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
