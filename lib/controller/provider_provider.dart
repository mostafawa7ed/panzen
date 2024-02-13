import 'dart:async';
import 'package:flutter/material.dart';
import 'package:untitled4/api/CRUD.dart';

import '../model/provider_model.dart';

class ProviderProvider extends ChangeNotifier {
  final Crud _crud = Crud();
  List<ProviderModel> driverList = [];
  List<ProviderModel> searchedList = [];
  Text message = Text("");
  double totalvalue = 0.0;
  Future addProvider(String url, ProviderModel provider) async {
    Map<String, dynamic> mymap = {
      "name": provider.nAME,
      "address": provider.aDDRESS,
      "taxNumber": provider.tAXNUMBER,
      //    "amountPerTon": provider.aMMOUNTPERTON,
      "changerId": provider.cHANGERID,
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

  Future<void> getSearchedProviderMakeEmpty() async {
    searchedList = [];
    notifyListeners();
  }

  Future<void> getSearchedProviderData(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['providers'] != null) {
        List<dynamic> providersearchedList = dataResponse['providers'];
        searchedList = providersearchedList
            .map((json) => ProviderModel.fromJson(json))
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

  Future<List<ProviderModel>> getSearchedProviderDataCustom(String url) async {
    try {
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.getRequest(url);

      if (dataResponse['providers'] != null) {
        List<dynamic> providersearchedList = dataResponse['providers'];
        searchedList = providersearchedList
            .map((json) => ProviderModel.fromJson(json))
            .toList();
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

  Future<String?> editProvider(String url, ProviderModel provider) async {
    Map<String, dynamic> mymap = {
      "name": provider.nAME,
      "address": provider.aDDRESS,
      "taxNumber": provider.tAXNUMBER,
      //  "amountPerTon": provider.aMMOUNTPERTON,
      "changerId": provider.cHANGERID,
    };

    try {
      Map<String, dynamic> dataResponse = await _crud.putRequest(
          '$url/${provider.iD}', mymap); // Assuming user.id exists

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
