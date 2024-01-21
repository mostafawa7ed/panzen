import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled4/api/CRUD.dart';
import 'package:untitled4/model/driver_model.dart';
import 'package:untitled4/model/vehicle_model.dart';

class ProviderVehicle extends ChangeNotifier {
  final Crud _crud = Crud();
  List<Vehicle> vehicleList = [];
  List<Vehicle> searchedList = [];
  Text message = Text("");
  double totalvalue = 0.0;
  Future addVehicle(String url, Vehicle vehicle) async {
    Map<String, dynamic> mymap = {
      "name": vehicle.nAME,
      "plateNo": vehicle.pLATENO,
      "vehicleTypeId": vehicle.vEHICLETYPEID,
      "changerId": vehicle.cHANGERID,
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

  Future<List<DriverModel>> driverPrepareList(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['drivers'] != null) {
        List<dynamic> data = dataResponse['drivers'];
//        driverList = data.map((json) => DriverModel.fromJson(json)).toList();
        notifyListeners();
        //      print(driverList.toString());
        return [];
        //List<dynamic> vehicles = dataResponse['vehicles'];
      } else {
        // Handle the case where the server returned an error
        print('Request failed with status: ${dataResponse.toString()}');
        return [];
        // Return or handle accordingly
      }
    } catch (e) {
      // Handle exceptions that might occur during the request
      print('Error fetching data: $e');
      // Return or handle accordingly
      return [];
    }
  }

  Future<void> getSearchedVehicleData(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['vehicles'] != null) {
        List<dynamic> providersearchedList = dataResponse['vehicles'];
        searchedList =
            providersearchedList.map((json) => Vehicle.fromJson(json)).toList();
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

  Future<List<Vehicle>> getSearchedVehicleDataAsReturn(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['vehicles'] != null) {
        List<dynamic> providersearchedList = dataResponse['vehicles'];
        searchedList =
            providersearchedList.map((json) => Vehicle.fromJson(json)).toList();

        return searchedList;
        //List<dynamic> vehicles = dataResponse['vehicles'];
      } else {
        // Handle the case where the server returned an error
        print('Request failed with status: ${dataResponse.toString()}');
        // Return or handle accordingly
        return [];
      }
    } catch (e) {
      // Handle exceptions that might occur during the request
      print('Error fetching data: $e');
      // Return or handle accordingly
      return [];
    }
  }

  Future<String?> editVehicle(String url, Vehicle vehicle) async {
    Map<String, dynamic> mymap = {
      "name": vehicle.nAME,
      "plateNo": vehicle.pLATENO,
      "vehicleTypeId": vehicle.vEHICLETYPEID,
      "changerId": vehicle.cHANGERID,
    };

    try {
      Map<String, dynamic> dataResponse = await _crud.putRequest(
          '$url/${vehicle.iD}', mymap); // Assuming user.id exists

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
