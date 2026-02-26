import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:prectical_task_flutter/core/common/models/user_model.dart';

import '../../../core/common/app_colors.dart';
import '../../../core/common/app_strings.dart';
import '../../../core/common/widgets/app_elevated_button.dart';
import '../../../core/common/widgets/app_text_field.dart';
import 'UpdateUser_bloc.dart';
import 'UpdateUser_event.dart';
import 'UpdateUser_state.dart';

class UpdateUserProvider extends BlocProvider<UpdateUserBloc> {
  UpdateUserProvider(UserModel userModel, {super.key})
    : super(
        create: (context) => UpdateUserBloc(context, userModel),
        child: UpdateUserView(userModel: userModel),
      );
}

class UpdateUserView extends StatefulWidget {
  final UserModel? userModel;

  UpdateUserView({super.key, this.userModel});

  @override
  State<UpdateUserView> createState() => _UpdateUserViewState();
}

class _UpdateUserViewState extends State<UpdateUserView> {
  final TextEditingController nameContorller = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  @override
  void initState() {
    nameContorller.text = widget.userModel?.name ?? "";
    emailController.text = widget.userModel?.email ?? "";
    phoneController.text = widget.userModel?.phone ?? "";
    super.initState();
  }

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final updateUserBloc = BlocProvider.of<UpdateUserBloc>(context);
    final scaffold = Scaffold(
      body: BlocBuilder<UpdateUserBloc, UpdateUserState>(
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
                        AppStrings.updateUser,
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
                          updateUserBloc.add(OnNameChanged(name));
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
                          updateUserBloc.add(OnPhoneNumberChanged(phone));
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
                          updateUserBloc.add(OnEmailChanged(email));
                        },
                      ),
                      SizedBox(height: 50),
                      AppElevatedButton(
                        buttonTitle: AppStrings.registration,
                        isLoading: state.isLoading,
                        onTap: () {
                          if (_globalKey.currentState!.validate()) {
                            updateUserBloc.add(EditUserEvent());
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
        BlocListener<UpdateUserBloc, UpdateUserState>(
          listener: (context, state) {
            if (state.isSuccess) {
              Navigator.pop(context);
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
