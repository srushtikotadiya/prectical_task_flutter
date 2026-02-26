import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../core/common/models/user_model.dart';
import '../../../core/repositories/auth_repository.dart';
import '../../../core/utilities/helper/injactable.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  AuthRepository _authRepository;

  HomeBloc(BuildContext context)
    : _authRepository = getIt<AuthRepository>(),
      super(HomeState.initialState) {
    on<PageAppear>(_pageAppear);
    on<DeleteUserEvent>(_onDeleteUser);
    on<UpdateUserEvent>(_onUpdateUser);
    add(PageAppear());
  }
  _pageAppear(PageAppear event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final List<UserModel> users = await _authRepository.getUsers();

      emit(state.copyWith(users: users, isLoading: false));
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  _onDeleteUser(DeleteUserEvent event, Emitter<HomeState> emit) async {
    try {
      emit(state.copyWith(isLoading: true));

      final bool isSuccess = await _authRepository.deleteUser(event.id);
      final List<UserModel> users = await _authRepository.getUsers();

      emit(
        state.copyWith(
          isLoading: false,
          isDeleteSuccess: isSuccess,
          users: users,
        ),
      );
    } catch (e) {
      emit(state.copyWith(error: e.toString()));
    }
  }

  _onUpdateUser(UpdateUserEvent event, Emitter<HomeState> emit) async {
    emit(state.copyWith(isUpdateSuccess: true, userModel: event.userModel));
  }
}
