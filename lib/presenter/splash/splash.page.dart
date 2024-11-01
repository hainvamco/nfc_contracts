import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/main.route.dart';

class SplashPage extends StatelessWidget {
  /// Constructs a [SplashPage]
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Splash Page')),
      body: Center(
        child: Column(
          children: [
            // ElevatedButton(
            //   // onPressed: () => context.go(RouterPath.routerHome),
            //   onPressed: () {
            //     context.popUntilPath(routePath: '/');
            //   },
            //   child: const Text('Go Home'),
            // ),
            ElevatedButton(
              // onPressed: () => context.go(RouterPath.routerRegister),
              onPressed: () {
                context.push(RouterPath.routerRegister);
              },
              child: const Text('Go Register'),
            ),
          ],
        ),
      ),
    );
  }
}
