import 'dart:convert';

import 'package:http/http.dart';
import '../network/app_api.dart';

import '../common/models/user_model.dart';

class AuthRepository {
  Future<List<UserModel>> getUsers() async {
    try {
      final Response response = await get(
        Uri.parse(AppApi.usersList),
        headers: {'content-type': 'application/json'},
      );

      if (response.statusCode == 200) {
        final List decodeResponse = jsonDecode(response.body);
        final List<UserModel> users = decodeResponse
            .map((user) => UserModel.fromJson(user))
            .toList();
        return users;
      } else {
        return [];
      }
    } catch (error) {
      return [];
    }
  }

  Future<bool> login(UserModel userModel) async {
    try {
      final Response response = await get(
        Uri.parse(
          "${AppApi.usersList}?email=${userModel.email}&password=${userModel.password}",
        ),
        headers: {'content-type': 'application/json'},
      );
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> createAccount(UserModel userModel) async {
    final Response response = await post(
      Uri.parse(AppApi.usersList),
      body: userModel.toJson(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteUser(String uid) async {
    final Response response = await delete(
      Uri.parse("${AppApi.usersList}/$uid"),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> updateUser(UserModel userModel) async {
    final Response response = await put(
      Uri.parse("${AppApi.usersList}/${userModel.id}"),
      body: userModel.toJson(),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
