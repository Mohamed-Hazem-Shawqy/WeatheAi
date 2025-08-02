import 'package:flutter/material.dart';
import 'package:weather_ai/features/home/presentation/widgets/home_view_body.dart';

import 'package:weather_ai/features/home/presentation/widgets/home_view_body.dart';
class Home extends StatelessWidget {
  const Home({super.key, });

  @override
  Widget build(BuildContext context) {
    
    return  const Scaffold(
     
        
      body:  SafeArea(
        child: HomeViewBody(),
      ),
    );
  }
}

