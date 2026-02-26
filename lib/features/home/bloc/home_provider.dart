import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prectical_task_flutter/core/common/app_colors.dart';
import 'package:prectical_task_flutter/core/common/app_strings.dart';
import 'package:prectical_task_flutter/features/UpdateUser/bloc/UpdateUser_provider.dart';
import 'package:prectical_task_flutter/features/home/bloc/home_event.dart';

import 'home_bloc.dart';
import 'home_state.dart';

class HomeProvider extends BlocProvider<HomeBloc> {
  HomeProvider({super.key})
    : super(create: (context) => HomeBloc(context), child: HomeView());
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final homeBloc = BlocProvider.of<HomeBloc>(context);

    final scaffold = Scaffold(
      body: BlocBuilder<HomeBloc, HomeState>(
        buildWhen: (pre, current) => true,
        builder: (context, state) {
          return state.isLoading
              ? Center(child: CircularProgressIndicator())
              : state.users.isEmpty
              ? Text("No data Fond")
              : Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.center,
                      colors: [
                        AppColors.lightPrimaryColor,
                        AppColors.colorWhite,
                      ],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Users",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Expanded(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: state.users.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                  shadowColor: AppColors.lightPrimaryColor,
                                  child: Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          state.users[index].name.toString(),
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        Divider(),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                homeBloc.add(
                                                  UpdateUserEvent(
                                                    userModel:
                                                        state.users[index],
                                                  ),
                                                );
                                              },
                                              child: Icon(Icons.edit),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                homeBloc.add(
                                                  DeleteUserEvent(
                                                    id:
                                                        state.users[index].id ??
                                                        "",
                                                  ),
                                                );
                                              },
                                              child: Icon(
                                                Icons.delete,
                                                color: Colors.red,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${AppStrings.email}: ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.users[index].email
                                                  .toString(),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              "${AppStrings.phone}: ",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              state.users[index].phone
                                                  .toString(),
                                              style: TextStyle(fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
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
        BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {
            if (state.isDeleteSuccess) {
            } else if (state.isUpdateSuccess) {
              if (state.userModel != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateUserProvider(state.userModel!),
                  ),
                ).then((value) {
                  homeBloc.add(PageAppear());
                });
              }
            }
          },
        ),
      ],
      child: scaffold,
    );
  }
}
