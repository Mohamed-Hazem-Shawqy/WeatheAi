import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_ai/core/utils/app_route.dart';
import 'package:weather_ai/core/utils/colors.dart';
import 'package:weather_ai/core/utils/responsive.dart';
import 'package:weather_ai/core/widgets/custom_button.dart';
import 'package:weather_ai/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:weather_ai/features/auth/presentation/widgets/custom_text_field.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveHeight = Responsive.height(context);
    final responsiveWidth = Responsive.width(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: responsiveHeight / 7,
          horizontal: responsiveWidth / 9,
        ),
        child: Form(
          key: globalKey,
          child: BlocConsumer<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('LOIN Success')),
                );
                GoRouter.of(context).pushReplacement(AppRoutes.home);
              } else if (state is AuthFailuer) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.errMessage)));
              }
            },
            builder: (context, state) {
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'LOGIN ',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'CREATE AN ACCOUNT TO MAKE SDFSDF ',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 10),
                    ),
                    const SizedBox(height: 100),
                    const Text(
                      'Email ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      controller: emailController,
                      obscureText: false,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Passowrd ',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    CustomTextField(
                      controller: passwordController,
                      obscureText: true,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        overlayColor: const WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                        padding: WidgetStatePropertyAll(
                          EdgeInsets.only(
                            left: responsiveWidth / 3,
                          ),
                        ),
                      ),
                      onPressed: () {
                        // if (emailController.text.isNotEmpty) {
                        //   BlocProvider.of<AuthCubit>(context)
                        //       .restPassowrd(emailController.text);
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     const SnackBar(
                        //       content: Text('please enter you email'),
                        //     ),
                        //   );
                        // }
                      },
                      child: const Text(
                        'Forget your password?',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 12,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: responsiveWidth / 7.0),
                      child: state is AuthLoading
                          ? const Center(child: CircularProgressIndicator())
                          : CustomAuthButton(
                              onPressed: () {
                                if (globalKey.currentState!.validate()) {
                                  context.read<AuthCubit>().userLogIN(
                                        emailController.text,
                                        passwordController.text,
                                      );
                                }
                              },
                              text: 'LOGIN',
                              backgroundColor: AppColors.blue,
                              textColor: AppColors.white,
                              width: responsiveWidth / 20,
                              height: responsiveHeight / 13,
                            ),
                    ),
                    TextButton(
                      style: const ButtonStyle(
                        overlayColor: WidgetStatePropertyAll(
                          Colors.transparent,
                        ),
                      ),
                      onPressed: () {
                        GoRouter.of(context).pushReplacement(AppRoutes.signup);
                      },
                      child: const Text(
                        'DON"T HAVE AN ACCOUNT?',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
