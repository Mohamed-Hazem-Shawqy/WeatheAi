import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather_ai/core/cache/shared_pref.dart';
import 'package:weather_ai/core/utils/app_route.dart';
import 'package:weather_ai/core/widgets/custom_text_field.dart';
import 'package:weather_ai/features/home/presentation/view_model/cubit/home_cubit.dart';
import 'package:weather_ai/features/home/presentation/widgets/horizontial_calender.dart';
import 'package:weather_ai/features/home/presentation/widgets/precent_indecator.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  TextEditingController controller = TextEditingController(text: 'Egypt');

  @override
  void initState() {
    super.initState();
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().getForecast(controller.text);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String? userName = Pref.getData(key: 'userName') ?? 'Name';
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          if (state is HomeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is HomeSuccess) {
            return SingleChildScrollView(
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Hello\n $userName'),
                    IconButton(
                      onPressed: () async {
                        final router = GoRouter.of(context);
                        await FirebaseAuth.instance.signOut();

                        router.pushReplacement(AppRoutes.login);
                      },
                      icon: const Icon(Icons.logout),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  controller: controller,
                  obscureText: false,
                  prefixIcon: IconButton(
                    onPressed: () {
                      context.read<HomeCubit>().getForecast(controller.text);
                    },
                    icon: const Icon(Icons.search),
                  ),
                ),
                const SizedBox(height: 20),
                const HorizontialCalender(),
                const SizedBox(height: 100),
                Text(
                  state.weathers[context.read<HomeCubit>().index].text,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 100),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    PrecentIndecator(
                      temp: state
                          .weathers[context.read<HomeCubit>().index].minTemp,
                    ),
                    PrecentIndecator(
                      temp: state
                          .weathers[context.read<HomeCubit>().index].maxTemp,
                    ),
                    PrecentIndecator(
                      temp: state
                          .weathers[context.read<HomeCubit>().index].avgTemp,
                    ),
                  ],
                )
              ]),
            );
          } else if (state is HomeFailuer) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(child: Icon(state.errMessage.errIcon)),
                Center(child: Text(state.errMessage.errMessage)),
              ],
            );
          } else {
            return const Center(child: Text('OOPS.... please try later'));
          }
        },
      ),
    );
  }
}
