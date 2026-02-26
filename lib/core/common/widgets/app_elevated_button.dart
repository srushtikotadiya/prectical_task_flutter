import 'package:flutter/material.dart';

import '../app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final String buttonTitle;
  final VoidCallback onTap;
  final Color? backgroundColor;
  final bool isLoading;
  const AppElevatedButton({
    super.key,
    required this.buttonTitle,
    required this.onTap,
    this.backgroundColor,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            backgroundColor ?? AppColors.primaryColor,
          ),
        ),
        onPressed: onTap,
        child: isLoading
            ? Center(
                child: CircularProgressIndicator(color: AppColors.colorWhite),
              )
            : Text(
                buttonTitle,
                style: TextStyle(
                  fontSize: 17,
                  color: AppColors.colorWhite,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
