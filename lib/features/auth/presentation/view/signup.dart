import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_ai/core/utils/app_route.dart';
import 'package:weather_ai/core/utils/colors.dart';
import 'package:weather_ai/core/utils/responsive.dart';
import 'package:weather_ai/core/widgets/custom_button.dart';
import 'package:weather_ai/features/auth/presentation/view_model/cubit/auth_cubit.dart';
import 'package:weather_ai/features/auth/presentation/widgets/custom_text_field.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> globalKey = GlobalKey();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final responsiveHeight = Responsive.height(context);
    final responsiveWidth = Responsive.width(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: responsiveHeight / 9,
            horizontal: responsiveWidth / 9,
          ),
          child: Form(
            key: globalKey,
            child: BlocConsumer<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Sign up successful! ')),
                  );
                  GoRouter.of(context).pushReplacement(AppRoutes.login);
                } else if (state is AuthFailuer) {
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(state.errMessage)));
                }
              },
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'SIGN UP ',
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
                  const SizedBox(height: 40),
                  const Text(
                    'FULL NAME ',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  CustomTextField(
                    controller: nameController,
                    obscureText: false,
                  ),
                  const SizedBox(height: 20),
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
                  const SizedBox(height: 10),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: responsiveWidth / 7.0),
                    child: state is AuthLoading
                        ? const Center(child: CircularProgressIndicator())
                        : CustomAuthButton(
                            onPressed: () async {
                              if (globalKey.currentState!.validate()) {
                                await context.read<AuthCubit>().userSignUp(
                                      emailController.text,
                                      passwordController.text,
                                    );
                                // await FirebaseAuth.instance.currentUser!
                                //     .sendEmailVerification();
                              }
                            },
                            text: 'SignUp',
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
                      GoRouter.of(context).pushReplacement(AppRoutes.login);
                    },
                    child: const Text(
                      ' HAVE AN ACCOUNT?',
                      textAlign: TextAlign.end,
                      style: TextStyle(
                        fontSize: 10,
                        color: AppColors.blue,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
