import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/main.route.dart';
import 'package:nfc_contracts/presenter/splash/custom_loading.dart';

class SplashPage extends StatelessWidget {
  /// Constructs a [SplashPage]
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('SCAN NFC Card to login'),
            SizedBox(
              height: 24,
            ),
            FancyLoadingIndicator(),
          ],
        ),
      ),
    );
  }
}
