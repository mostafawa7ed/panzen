class StaticData {
  static const String urlConnectionConst =
      'http://localhost:5000/api/'; //10.0.15.117 10.9.100.225:7011   10.0.65.51:7001   10.0.65.164
  static const String urltransportationFeeAdd =
      '${urlConnectionConst}transportationFee/add';
  static const String urlLogin = '${urlConnectionConst}user/login';
  static const String urlChangeUserPassword =
      '${urlConnectionConst}user/update';
  static const String urlGetAllVehicle = '${urlConnectionConst}vehicles/all';
  static const String urlGetAllProviders = '${urlConnectionConst}provider/all';
  static const String urlGetAllProviderDetails =
      '${urlConnectionConst}providerDetails/all';
  static const String urlGetAllProviderDetailsByProviderId =
      '${urlConnectionConst}providerDetails/provider'; //driver/all
  static const String urlGetAllDriver = '${urlConnectionConst}driver/all';

  static const String urlGetTransportationFeeReport =
      '${urlConnectionConst}joins/rangTransportationfee';
  static const String urlAddUser = '${urlConnectionConst}user/add';
//http://localhost:5000/api/transportationFee/add
////////////////////////// textDirection /////////////////////
////////////////////   Images path  //////////////////////////////////
}
