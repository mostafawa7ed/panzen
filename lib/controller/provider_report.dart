import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:untitled4/api/CRUD.dart';
import 'package:untitled4/model/transportationfeeReportMode.dart';

class ProviderReportData extends ChangeNotifier {
  List<TransportaionfeeReport> transportaionfeeReportList = [];
  List<TransportaionfeeReport> transportaionfeeallList = [];
  final Crud _crud = Crud();

  Future<void> transportaionfeeReportPrepareList(
      String url, DateTime fromDate, DateTime toDate) async {
    try {
      String fromDate1 = DateFormat('yyyy-MM-dd').format(fromDate);
      String todate1 = DateFormat('yyyy-MM-dd').format(toDate);
      Map<String, dynamic> mymap = {"from": fromDate1, "to": todate1};
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.postRequest(url, mymap);

      if (dataResponse['transportaionfeeReport'] != null) {
        List<dynamic> transportaionfeeReportListjson =
            dataResponse['transportaionfeeReport'];
        transportaionfeeReportList = transportaionfeeReportListjson
            .map((json) => TransportaionfeeReport.fromJson(json))
            .toList();
        notifyListeners();
        print(transportaionfeeReportList.toString());
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

  Future<void> transportaionfeeList(String url) async {
    try {
      Map<String, dynamic> mymap = {"from": "", "to": ""};
      // Make an HTTP GET request to the provided URL
      Map<String, dynamic> dataResponse = await _crud.postRequest(url, mymap);

      if (dataResponse['transportaionfeeReport'] != null) {
        List<dynamic> transportaionfeeReportListjson =
            dataResponse['transportaionfeeReport'];
        transportaionfeeallList = transportaionfeeReportListjson
            .map((json) => TransportaionfeeReport.fromJson(json))
            .toList();
        notifyListeners();
        print(transportaionfeeReportList.toString());
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
}
