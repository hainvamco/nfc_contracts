import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/main.route.dart';
import 'package:nfc_contracts/presenter/splash/custom_loading.dart';
import 'package:nfc_contracts/presenter/splash/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  /// Constructs a [SplashPage]
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('NFC Contracts')),
      body: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (!state.isLoading) const Text('SCAN NFC Card '),
                const SizedBox(
                  height: 24,
                ),
                if (state.isLoading) const FancyLoadingIndicator(),
              ],
            ),
          );
        },
      ),
    );
  }
}
