import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:http/http.dart';

class Crud {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        //Map<String, dynamic> responsebody = jsonDecode(response.body);
        Encoding? encoding = Encoding.getByName('utf-8');
        var decodedResponse = encoding!.decode(response.bodyBytes);
        Map<String, dynamic> responseJson = jsonDecode(decodedResponse);
        print(responseJson);
        return responseJson;
      } else {
        print("erreor ${response.statusCode}");
      }
    } catch (e) {
      print("Error catch $e");
    }
  }

  Future<Map<String, dynamic>> postRequest(
      String url, Map<String, dynamic> request) async {
    Map<String, dynamic> myMap = {};

    Map<String, dynamic> jsonMap = Map();
    try {
      final Response response = await post(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(request),
      );
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        jsonMap = jsonDecode(utf8.decode(response.bodyBytes));
        myMap = jsonMap;
        print(data['message']);
        print('parameterSearch successfully');
        return myMap;
      } else {
        print('failed');
        return myMap;
      }
    } catch (e) {
      print(e.toString());
      return myMap;
    }
  }

  Future<Map<String, dynamic>> putRequest(
    String url,
    Map<String, dynamic> dataToUpdate,
  ) async {
    Map<String, dynamic> myMap = {};
    var map = jsonEncode(dataToUpdate);
    try {
      final response = await http.put(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: map,
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        myMap = data;
        print('Data updated successfully');
        return myMap;
      } else {
        print('Failed to update data');
        return myMap;
      }
    } catch (e) {
      print('Error: $e');
      return myMap;
    }
  }

  Future<Map<String, dynamic>> deleteRequest(String url) async {
    Map<String, dynamic> myMap = {};

    try {
      final Response response = await http.delete(
        Uri.parse(url),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        myMap = data;
        print('Data deleted successfully');
        return myMap;
      } else {
        print('Failed to delete data');
        return myMap;
      }
    } catch (e) {
      print('Error: $e');
      return myMap;
    }
  }
}
