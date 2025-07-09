import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_ai/core/utils/app_route.dart';
import 'package:weather_ai/core/utils/colors.dart';
import 'package:weather_ai/core/widgets/custom_button.dart';


class AuthWaySelect extends StatelessWidget {
  const AuthWaySelect({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(clipBehavior: Clip.none, children: [
      Positioned(
        bottom: 0,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.8,
          decoration: const BoxDecoration(
            color: AppColors.blackBlue,
          ),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const SizedBox(height: 80),
            CustomAuthButton(
              width: 150,
              height: 20,
              onPressed: () {
                GoRouter.of(context).pushReplacement(AppRoutes.signup);
              },
              text: 'SignUp',
              backgroundColor: AppColors.blue,
              textColor: AppColors.white,
            ),
            const SizedBox(height: 20),
            CustomAuthButton(
              width: 150,
              height: 20,
              onPressed: () {
                GoRouter.of(context).pushReplacement(AppRoutes.login);
              },
              text: 'LogIn',
              backgroundColor: AppColors.white,
              textColor: AppColors.black,
            ),
          ]),
        ),
      ),
      Positioned(
        top: 0,
        left: -25,
        right: -25,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height / 1.65,
          decoration: const BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(250),
              bottomRight: Radius.circular(250),
            ),
          ),
        ),
      ),
    ]));
  }
}
