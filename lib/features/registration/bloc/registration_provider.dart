import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/common/app_colors.dart';
import '../../../core/common/app_strings.dart';
import '../../../core/common/widgets/app_elevated_button.dart';
import '../../../core/common/widgets/app_text_field.dart';
import '../../home/bloc/home_provider.dart';
import 'registration_bloc.dart';
import 'registration_event.dart';
import 'registration_state.dart';

class RegistrationProvider extends BlocProvider<RegistrationBloc> {
  RegistrationProvider({super.key})
    : super(
        create: (context) => RegistrationBloc(context),
        child: RegistrationView(),
      );
}

class RegistrationView extends StatelessWidget {
  final TextEditingController nameContorller = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  RegistrationView({super.key});

  @override
  Widget build(BuildContext context) {
    final registrationBloc = BlocProvider.of<RegistrationBloc>(context);

    final scaffold = Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<RegistrationBloc, RegistrationState>(
        buildWhen: (pre, current) => true,
        builder: (context, state) {
          return SingleChildScrollView(
            child: Center(
              child: Form(
                key: _globalKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.registration,
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      AppTextField(
                        title: AppStrings.name,
                        controller: nameContorller,
                        hintText: AppStrings.nameHint,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.namevalidate;
                          }

                          return null;
                        },
                        onChanged: (String name) {
                          registrationBloc.add(OnNameChanged(name));
                        },
                      ),
                      AppTextField(
                        title: AppStrings.phone,
                        controller: phoneController,
                        hintText: AppStrings.phoneHint,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.phoneValidate;
                          }

                          if (!RegExp(r'^[6-9]\d{9}$').hasMatch(value)) {
                            return AppStrings.phoneValidateFormat;
                          }

                          return null;
                        },
                        onChanged: (String phone) {
                          registrationBloc.add(OnPhoneNumberChanged(phone));
                        },
                      ),
                      AppTextField(
                        title: AppStrings.email,
                        controller: emailController,
                        hintText: AppStrings.emailHint,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.emailValidate;
                          }
                          if (!value.contains("@")) {
                            return AppStrings.emailValidValidate;
                          }
                          return null;
                        },
                        onChanged: (String email) {
                          registrationBloc.add(OnEmailChanged(email));
                        },
                      ),
                      AppTextField(
                        title: AppStrings.passowrd,
                        hintText: AppStrings.passowrdHint,
                        controller: passwordController,
                        onChanged: (String passowrd) {
                          registrationBloc.add(OnPasswordChanged(passowrd));
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.passwordValidate;
                          }
                          if (value.length < 6) {
                            return AppStrings.passwordlengthValidate;
                          }
                          return null;
                        },
                      ),
                      AppTextField(
                        title: AppStrings.passowrd,
                        hintText: AppStrings.passowrdHint,
                        controller: confirmPasswordController,
                        onChanged: (String passowrd) {
                          registrationBloc.add(
                            OnConfirmPasswordChanged(passowrd),
                          );
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppStrings.passwordValidate;
                          }
                          if (value.length < 6) {
                            return AppStrings.passwordlengthValidate;
                          }
                          if (value != passwordController.text) {
                            return AppStrings.passwordmatchValidate;
                          }
                          return null;
                        },
                      ),
                      SizedBox(width: 20),
                      Align(
                        alignment: AlignmentGeometry.centerRight,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegistrationProvider(),
                              ),
                            );
                          },
                          child: Text(
                            AppStrings.loginRoute,
                            style: TextStyle(color: AppColors.primaryColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      AppElevatedButton(
                        buttonTitle: AppStrings.registration,
                        isLoading: state.isLoading,
                        onTap: () {
                          if (_globalKey.currentState!.validate()) {
                            registrationBloc.add(HandleRegistration());
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<RegistrationBloc, RegistrationState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeProvider()),
              );
            } else if (state.error.isNotEmpty) {
              Fluttertoast.showToast(
                msg: state.error,
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0,
              );
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
