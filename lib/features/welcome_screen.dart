import 'package:flutter/material.dart';

import 'login/bloc/login_provider.dart';
import '../core/common/app_colors.dart';
import '../core/common/widgets/app_elevated_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, bottom: 30),
        child: AppElevatedButton(
          buttonTitle: 'Start',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoginProvider()),
            );
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: AlignmentGeometry.topCenter,
            end: AlignmentGeometry.center,
            colors: [
              AppColors.primaryColor.withOpacity(0.2),
              AppColors.colorWhite,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Welcome to the App",
                style: TextStyle(fontSize: 32, color: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
