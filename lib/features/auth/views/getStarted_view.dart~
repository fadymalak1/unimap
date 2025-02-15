// TODO: Implement features/feature_name/getStarted_view.dart

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unimap/config/themes.dart';
import 'package:unimap/shared/utils.dart';
import 'package:unimap/shared/widgets/custom_elevated_button.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Image.asset(AppImages.background, fit: BoxFit.cover, width:800,),
            SizedBox(height: 20,),
            Text("UniMap", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30,color:AppTheme.primaryColor ),),
            Spacer(),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: CustomElevatedButton(onPressed: ()=> context.push("/login") , child: Text("Get Started"),),
            ),
          ],
        )
    );
  }
}
