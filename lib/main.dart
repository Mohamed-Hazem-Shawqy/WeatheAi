import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_ai/core/utils/app_route.dart';
import 'package:weather_ai/core/utils/colors.dart';
import 'package:weather_ai/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:weather_ai/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      print(
          '==================User is currently signed out!===================');
    } else {
      print('==============User is signed in!===============');
    }
  });
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(),
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: AppRoutes.routes,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: AppColors.blackBlue,
        ),
      ),
    );
  }
}
