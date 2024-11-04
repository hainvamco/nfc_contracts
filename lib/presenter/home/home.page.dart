import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_contracts/main.dart';
import 'package:nfc_contracts/main.route.dart';
import 'package:nfc_contracts/presenter/splash/cubit/splash_cubit.dart';

class HomePage extends StatelessWidget {
  /// Constructs a [HomePage]
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home Page'),
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
              BlocBuilder<SplashCubit, SplashState>(
                builder: (context, state) {
                  return Text(state.count.toString());
                },
              ),
              ElevatedButton(
                onPressed: () {
                  context.read<SplashCubit>().increateCount();
                },
                child: const Text('Increate splash'),
              ),
              ElevatedButton(
                onPressed: () {
                  firebaseRepo.updateUserFirebase(userId: idUserFirebase);
                },
                child: const Text('Change'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
