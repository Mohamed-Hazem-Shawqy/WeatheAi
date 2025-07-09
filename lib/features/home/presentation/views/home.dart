import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_ai/core/utils/app_route.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IconButton(
            onPressed: () async {
              final router = GoRouter.of(context);
              await FirebaseAuth.instance.signOut();

              router.pushReplacement(AppRoutes.login);
            },
            icon: const Icon(Icons.logout)),
      ),
    );
  }
}
