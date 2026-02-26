import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../core/common/app_strings.dart';
import '../../home/bloc/home_provider.dart';
import '../../../core/common/app_colors.dart';
import '../../../core/common/widgets/app_elevated_button.dart';
import '../../../core/common/widgets/app_text_field.dart';
import '../../registration/bloc/registration_provider.dart';
import 'login_event.dart';

import 'login_bloc.dart';
import 'login_state.dart';

class LoginProvider extends BlocProvider<LoginBloc> {
  LoginProvider({super.key})
    : super(create: (context) => LoginBloc(context), child: LoginView());
}

class LoginView extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    final scaffold = Scaffold(
      body: BlocBuilder<LoginBloc, LoginState>(
        buildWhen: (pre, current) => true,
        builder: (context, state) {
          return Center(
            child: Form(
              key: _globalKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      AppStrings.loginSignupTitle,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryColor,
                      ),
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
                        loginBloc.add(OnEmailChanged(email));
                      },
                    ),
                    AppTextField(
                      title: AppStrings.passowrd,
                      hintText: AppStrings.passowrdHint,
                      controller: passwordController,
                      onChanged: (String passowrd) {
                        loginBloc.add(OnPasswordChanged(passowrd));
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
                          AppStrings.createAccountRoute,
                          style: TextStyle(color: AppColors.primaryColor),
                        ),
                      ),
                    ),

                    AppElevatedButton(
                      buttonTitle: AppStrings.loginTitle,
                      isLoading: state.isLoading,
                      onTap: () {
                        if (_globalKey.currentState!.validate()) {
                          loginBloc.add(HandleLogin());
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

    return MultiBlocListener(
      listeners: [
        BlocListener<LoginBloc, LoginState>(
          listener: (BuildContext context, LoginState state) {
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
