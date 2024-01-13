import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled4/api/CRUD.dart';
import 'package:untitled4/model/driver_model.dart';

class ProviderDriver extends ChangeNotifier {
  final Crud _crud = Crud();
  List<DriverModel> driverList = [];
  List<DriverModel> searchedList = [];
  Text message = Text("");
  double totalvalue = 0.0;
  Future addDriver(String url, DriverModel driver) async {
    Map<String, dynamic> mymap = {
      "name": driver.nAMED,
      "address": driver.aDDRESSD,
      "firstName": driver.fIRSTNAMED,
      "secondName": driver.sECONDNAMED,
      "changerId": driver.cHANGERIDD,
    };
    try {
      Map<String, dynamic> dataResponse = await _crud.postRequest(url, mymap);

      if (dataResponse.containsKey('insertedId')) {
        print("${dataResponse['message']} ${dataResponse['insertedId']}");
      } else {
        print('No data inserted.');

        // Return an empty list in case of no casesData
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Return an empty list in case of an error
    }
  }

  Future<void> getSearchedDriverData(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['drivers'] != null) {
        List<dynamic> providersearchedList = dataResponse['drivers'];
        searchedList = providersearchedList
            .map((json) => DriverModel.fromJson(json))
            .toList();
        notifyListeners();

        //List<dynamic> vehicles = dataResponse['vehicles'];
      } else {
        // Handle the case where the server returned an error
        print('Request failed with status: ${dataResponse.toString()}');
        // Return or handle accordingly
      }
    } catch (e) {
      // Handle exceptions that might occur during the request
      print('Error fetching data: $e');
      // Return or handle accordingly
    }
  }

  Future<String?> editDriver(String url, DriverModel driver) async {
    Map<String, dynamic> mymap = {
      "name": driver.nAMED,
      "address": driver.aDDRESSD,
      "firstName": driver.fIRSTNAMED,
      "secondName": driver.sECONDNAMED,
      "changerId": driver.cHANGERIDD,
    };

    try {
      Map<String, dynamic> dataResponse = await _crud.putRequest(
          '$url/${driver.iDD}', mymap); // Assuming user.id exists

      if (dataResponse.isNotEmpty) {
// Extract the "message" value from the map
        String message = dataResponse['message'];
        return message;
      } else {
        print('Error: Empty response');
        return null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      return null;
    }
  }

  void changeMessage(Text m) async {
    print("befor");
    await Timer(Duration(seconds: 8), () {
      message = Text("");
    });
    print("after");
    message = m;
    notifyListeners();
  }
}
