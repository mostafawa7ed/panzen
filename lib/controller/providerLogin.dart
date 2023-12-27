import 'package:flutter/material.dart';
import 'package:untitled4/api/CRUD.dart';
import 'package:untitled4/model/user_model.dart';

class ProviderLogin extends ChangeNotifier {
  final Crud _crud = Crud();
  User? currentUser;
  Future<User?> login(String url, User user) async {
    Map<String, dynamic> mymap = {
      "userName": user.userName ?? 1,
      "password": user.password ?? 1,
    };
    try {
      Map<String, dynamic> dataResponse = await _crud.postRequest(url, mymap);

      if (dataResponse.isNotEmpty) {
        final userData = dataResponse['user'] as Map<String, dynamic>;

        currentUser = User.fromMap(userData);

        return currentUser;
      } else {
        print('errorelse');
        return null;
        // Return an empty list in case of no casesData
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
      // Return an empty list in case of an error
    }
  }

  Future<User?> changeUserPassword(String url, User user) async {
    Map<String, dynamic> mymap = {
      "userName": user.userName ?? '',
      "password": user.password ?? '',
    };

    try {
      Map<String, dynamic> dataResponse = await _crud.putRequest(
          '$url/${user.id}', mymap); // Assuming user.id exists

      if (dataResponse.isNotEmpty) {
        currentUser = User.fromJson(dataResponse);
        return User.fromJson(dataResponse);
      } else {
        print('Error: Empty response');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }
}
