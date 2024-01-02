import 'package:flutter/material.dart';
import 'package:untitled4/api/CRUD.dart';
import 'package:untitled4/model/driver_model.dart';
import 'package:untitled4/model/providerDetails_model.dart';
import 'package:untitled4/model/provider_model.dart';
import 'package:untitled4/model/transportation_fee_model.dart';
import 'package:untitled4/model/vehicle_model.dart';

class ProviderTransportationFee extends ChangeNotifier {
  final Crud _crud = Crud();
  List<Vehicle> vehicleList = [];
  List<ProviderModel> providerList = [];
  List<ProviderDetails> providerDetailsList = [];
  List<DriverModel> driverList = [];
  double totalvalue = 0.0;
  Future addTransporationFee(
      String url, TransportationFeeModel transportationFee) async {
    Map<String, dynamic> mymap = {
      "providersDetailsId": transportationFee.providersDetailsId ?? 1,
      "driversId": transportationFee.driversId ?? 1,
      "carsId": transportationFee.carsId ?? 1,
      "totalValue": transportationFee.totalValue ?? 1,
      "numberOfTon": transportationFee.numberOfTon ?? 1,
      "requestDate":
          DateTime.now().toIso8601String().substring(0, 10).toString(),
      "changerId": transportationFee.changerId ?? 1
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

  Future<void> vehiclePrepareList(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['vehicles'] != null) {
        List<dynamic> vehiclesData = dataResponse['vehicles'];
        vehicleList =
            vehiclesData.map((json) => Vehicle.fromJson(json)).toList();
        notifyListeners();
        print(vehicleList.toString());
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

  Future<void> providerPrepareList(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['providers'] != null) {
        List<dynamic> providersData = dataResponse['providers'];
        providerList =
            providersData.map((json) => ProviderModel.fromJson(json)).toList();
        notifyListeners();
        print(providerList.toString());
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

  Future<void> providerDetailsPrepareList(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['providerDetail'] != null) {
        List<dynamic> providerDetailsData = dataResponse['providerDetail'];
        providerDetailsList = providerDetailsData
            .map((json) => ProviderDetails.fromJson(json))
            .toList();
        notifyListeners();
        print(providerDetailsList.toString());
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

  Future<void> driverPrepareList(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['drivers'] != null) {
        List<dynamic> data = dataResponse['drivers'];
        driverList = data.map((json) => DriverModel.fromJson(json)).toList();
        notifyListeners();
        print(driverList.toString());
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

  void changeTotalValue(double value) {
    totalvalue = value;
    notifyListeners();
  }
}
