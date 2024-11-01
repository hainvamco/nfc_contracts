// Copyright 2024 hainguyen8086. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:app_links/app_links.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nfc_contracts/data/repository/firebase_repo.dart';
import 'package:nfc_contracts/main.route.dart';
import 'package:go_router/go_router.dart';
import 'package:nfc_contracts/presenter/splash/cubit/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();
final firebaseRepo = FirebaseRepo();

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late AppLinks _appLinks;
  StreamSubscription<Uri>? _linkSubscription;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initDeepLinks();
  }

  @override
  void dispose() {
    _linkSubscription?.cancel();

    super.dispose();
  }

  Future<void> initDeepLinks() async {
    _appLinks = AppLinks();

    // Handle links
    _linkSubscription = _appLinks.uriLinkStream.listen((uri) {
      debugPrint('onAppLink: $uri');
      debugPrint('onAppLink--: ${uri.path}');
      debugPrint('onAppLink--fragment: ${uri.fragment}');
      debugPrint('onAppLink--data: ${getQueryValue(uri.query)}');
      openAppLink(uri);
    });
  }

  void openAppLink(Uri uri) async {
    var data = getQueryValue(uri.query);
    // navigatorKey.currentState?.pushNamed(uri.fragment);
    var userFirebase = await firebaseRepo.getUserById(idUser: data);

    // if (data == 'gogo') {
    if (userFirebase.id != null && userFirebase.id!.isNotEmpty) {
      navigatorKey.currentContext?.push(RouterPath.routerHome);
    } else {
      navigatorKey.currentContext?.push(RouterPath.routerRegister);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) => SplashCubit(),
      child: MaterialApp.router(
        routerConfig: routerMain,
      ),
    );
  }
}

String getQueryValue(String query) {
  if (query.contains("=")) {
    return query.split("=").last;
  } else {
    return query;
  }
}
