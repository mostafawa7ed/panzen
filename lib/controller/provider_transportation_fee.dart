import 'package:flutter/material.dart';
import 'package:untitled4/api/CRUD.dart';
import 'package:untitled4/model/transportation_fee_model.dart';

class ProviderTransportationFee extends ChangeNotifier {
  final Crud _crud = Crud();

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

  void filterData(String searchString) {
    notifyListeners();
  }

  Future<Map<String, dynamic>> funGetResponse(String url) async {
    return await _crud.getRequest(url); // Await the response
  }

  // Future<List<dynamic>> getUnreadNotifications(String url, String type) async {
  //   try {
  //     Map<String, dynamic> data_response = await funGetResponse(url);
  //     if (data_response.isNotEmpty) {
  //       List<NotificationModel> caseDataList =
  //           data_response['mobileNotificationsMessagesData'] != null
  //               ? (data_response['mobileNotificationsMessagesData'] as List)
  //                   .map((i) {
  //                   return NotificationModel.fromJson(i);
  //                 }).toList()
  //               : [];

  //       if (type == "dataNotificationModel") {
  //         dataNotificationModel = await changeDate(caseDataList);
  //       }

  //       notifyListeners();

  //       return caseDataList;
  //     } else {
  //       print('No  found in the response.');
  //       return []; // Return an empty list in case of no casesData
  //     }
  //   } catch (e) {
  //     print('Error fetching data: $e');
  //     return []; // Return an empty list in case of an error
  //   }
  // }

  deleteTempData() {
    notifyListeners();
  }

  // Future<List<NotificationModel>> changeDate(
  //     List<NotificationModel> currentList) async {
  //   for (int i = 0; currentList.length - 1 > i; i++) {
  //     currentList[i].notificationDataArabic =
  //         await dataWithCurrentLanguage(currentList[i].notificationData!, "ar");
  //     currentList[i].notificationDataEnglish =
  //         await dataWithCurrentLanguage(currentList[i].notificationData!, "en");
  //   }

  //   return currentList;
  // }
}
