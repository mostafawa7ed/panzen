import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';

import 'package:untitled4/model/driver_model.dart';
import 'package:untitled4/model/providerDetails_model.dart';
import 'package:untitled4/model/provider_model.dart';
import 'package:untitled4/model/transportation_fee_model.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';

import 'package:untitled4/cutomwidget/customTextFieldSearch.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/functions/mediaquery.dart';

import '../controller/provider_driver.dart';
import '../controller/provider_provider.dart';
import '../controller/provider_providerDetails.dart';
import '../controller/provider_vehicle.dart';
import '../data/langaue.dart';
import '../model/type_model.dart';
import 'driver.dart';

class TransportationFee extends StatefulWidget {
  const TransportationFee(
      {super.key, required this.user, required this.language});
  final User user;
  final String language;
  @override
  State<TransportationFee> createState() => _TransportationFeeState();
}

class _TransportationFeeState extends State<TransportationFee> {
  TextEditingController numberOfTon = TextEditingController();
  TextEditingController totalValue = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  TextEditingController _providerController = TextEditingController();
  TextEditingController _providerReciverController = TextEditingController();
  TextEditingController _providerDetailsController = TextEditingController();
  TextEditingController _driverController = TextEditingController();

  Vehicle selectedVehicle = Vehicle();
  ProviderModel selectedProviderMOdel = ProviderModel();
  ProviderModel selectedProviderReciverMOdel = ProviderModel();
  ProviderDetails selectedProviderDetails = ProviderDetails();
  DriverModel selectedDriver = DriverModel();

  FocusNode _vehicleFieldFocus = FocusNode();
  FocusNode _providerFieldFocus = FocusNode();
  FocusNode _providerDetailsFieldFocus = FocusNode();
  FocusNode _providerDetailsReciverFieldFocus = FocusNode();
  FocusNode _driverFieldFocus = FocusNode();
  FocusNode _numberTonFieldFocus = FocusNode();

  DateTime? requestDate;
  VehicleMap? selectedVehicleColumn; //= VehicleMap("Name", "الأسم", "NAME");
  List<VehicleMap> vehicleColumnsItems = [
    VehicleMap("Name", "NAME"),
    VehicleMap("PlateNum", "PLATE_NO"),
  ];
  ProviderMap? selectedProviderMapColumn;
  List<ProviderMap> providerColumnsItems = [
    ProviderMap("Name", "NAME"),
    ProviderMap("Address", "ADDRESS"),
  ];
  ProviderMap? selectedProviderMapColumn2;
  List<ProviderMap> providerColumnsItems2 = [
    ProviderMap("Name", "NAME"),
    ProviderMap("Address", "ADDRESS"),
  ];
  DriverMap? selectedDriverColumn;
  List<DriverMap> driverColumnsItems = [
    DriverMap("Name", "NAME"),
    DriverMap("license", "ADDRESS"),
  ];
  String SelectedColumn = 'Item 1';
  String type = '';
  List<VehicleType> vehicleTypes = [
    VehicleType(1, 'vehiclee'),
    VehicleType(2, 'trailer'),
    // Add more VehicleType objects as needed
  ];
  List<TypeModel> types = [
    TypeModel(id: '1', name: 'Diesel'),
    TypeModel(id: '2', name: 'Solar'),
    TypeModel(id: '3', name: 'Gasoline 80'),
    TypeModel(id: '4', name: 'Gasoline 90'),
    TypeModel(id: '5', name: 'Gasoline 92'),
    TypeModel(id: '6', name: 'Gasoline 95'),
  ];
  TypeModel? _selectedType;
  @override
  void initState() {
    //   prepareData(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FocusScope.of(context).requestFocus(_vehicleFieldFocus);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  hint: Text(getLanguage(context, 'filter')),
                  dropdownColor: Colors.white,
                  value: selectedVehicleColumn,
                  items: vehicleColumnsItems
                      .map<DropdownMenuItem<VehicleMap>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(getLanguage(context, e.nameEnglish!)),
                        ),
                      )
                      .toList(),
                  onChanged: (VehicleMap? value) => setState(
                    () {
                      if (value != null) selectedVehicleColumn = value;
                    },
                  ),
                ),
              ),
              Consumer<ProviderVehicle>(
                  builder: (context, providerVehicleData, child) {
                return Container(
                  width: getSizePage(context, 1, 60),
                  child: Autocomplete<Vehicle>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (!textEditingValue.text.isEmpty &&
                          selectedVehicleColumn != null) {
                        // Replace 'otherModelList' with your list of OtherModel objects
                        List<Vehicle>? matches = await providerVehicleData
                            .getSearchedVehicleDataAsReturn(StaticData
                                    .urlVehicleSearch +
                                '?column=${selectedVehicleColumn!.column}&value=${textEditingValue.text}');

                        return matches;
                      } else {
                        return const Iterable<Vehicle>.empty();
                      }
                    },
                    onSelected: (Vehicle selection) {
                      selectedVehicle = selection;

                      // Update the text in the TextFormField when a vehicle is selected
                      _vehicleController.text = selection.nAME ?? '';
                      print('You just selected ${selectedVehicle.nAME}');
                      FocusScope.of(context).requestFocus(_providerFieldFocus);
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      _vehicleController = textEditingController;
                      _vehicleFieldFocus = focusNode;
                      //Store the controller
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onChanged: (String value) {
                          // Additional actions while the text changes, if needed
                        },
                        onFieldSubmitted: (String value) {
                          // Handle the submitted value, if needed
                        },
                        decoration: InputDecoration(
                          labelText:
                              getLanguage(context, 'typeToSearchVehicle'),
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<Vehicle> onSelected,
                        Iterable<Vehicle> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 6.0,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 200.0),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                width: getSizePage(context, 1, 60),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final Vehicle option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            "${getLanguage(context, 'name')}:${option.nAME ?? ''} ${getLanguage(context, 'PlateNum')}: ${option.pLATENO ?? ''} ${getLanguage(context, 'type')}: ${option.vEHICLETYPEID == 1 ? getLanguage(context, 'vehiclee') : getLanguage(context, 'trailer')} "),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  hint: Text(getLanguage(context, 'filter')),
                  value: selectedProviderMapColumn,
                  items: providerColumnsItems
                      .map<DropdownMenuItem<ProviderMap>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(getLanguage(context, e.nameEnglish!)),
                        ),
                      )
                      .toList(),
                  onChanged: (ProviderMap? value) => setState(
                    () {
                      if (value != null) selectedProviderMapColumn = value;
                    },
                  ),
                ),
              ),
              Consumer<ProviderProvider>(
                  builder: (context, providerProvider, child) {
                return Container(
                  width: getSizePage(context, 1, 60),
                  child: Autocomplete<ProviderModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty ||
                          selectedProviderMapColumn == null) {
                        return const Iterable<ProviderModel>.empty();
                      } else {
                        // Replace 'otherModelList' with your list of OtherModel objects
                        List<ProviderModel> matches = await providerProvider
                            .getSearchedProviderDataCustom(StaticData
                                    .urlProviderSearch +
                                '?column=${selectedProviderMapColumn!.column}&value=${textEditingValue.text}');

                        return matches;
                      }
                    },
                    onSelected: (ProviderModel selection) async {
                      selectedProviderMOdel = selection;

                      // Update the text in the TextFormField when a vehicle is selected
                      _providerController.text = selection.nAME ?? '';
                      print('You just selected ${selectedVehicle.nAME}');
                      FocusScope.of(context)
                          .requestFocus(_providerDetailsFieldFocus);
                      // final ProviderTransportationFee
                      //     providerTransportationFee =
                      //     Provider.of<ProviderTransportationFee>(context,
                      //         listen: false);

                      // await providerTransportationFee.providerDetailsPrepareList(
                      //     "${StaticData.urlGetAllProviderDetailsByProviderId}/${selectedProviderMOdel.iD}");
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      _providerController = textEditingController;
                      _providerFieldFocus = focusNode; // Store the controller
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onChanged: (String value) {
                          // Additional actions while the text changes, if needed
                        },
                        onFieldSubmitted: (String value) {
                          // Handle the submitted value, if needed
                        },
                        decoration: InputDecoration(
                          labelText:
                              getLanguage(context, 'typeToSearchProvider'),
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<ProviderModel> onSelected,
                        Iterable<ProviderModel> options) {
                      // ListTile(
                      //           title: Text(getLanguage(context, 'provider') +
                      //               ": " +
                      //               "${option.nAME ?? ''}${getLanguage(context, 'address')}: ${option.aDDRESS ?? ''} ${getLanguage(context, 'taxNumber')}: ${option.tAXNUMBER ?? ''} "),
                      //         ),
                      // return SingleChildScrollView(
                      //   physics: BouncingScrollPhysics(),
                      //   child: ListView.builder(
                      //     shrinkWrap: true,
                      //     itemCount: options.length,
                      //     itemBuilder: (BuildContext context, int index) {
                      //       final ProviderModel option =
                      //           options.elementAt(index);
                      //       return GestureDetector(
                      //         onTap: () {
                      //           onSelected(option);
                      //         },
                      //         child: ListTile(
                      //           title: Text(getLanguage(context, 'provider') +
                      //               ": " +
                      //               "${option.nAME ?? ''}${getLanguage(context, 'address')}: ${option.aDDRESS ?? ''} ${getLanguage(context, 'taxNumber')}: ${option.tAXNUMBER ?? ''} "),
                      //         ),
                      //       );
                      //     },
                      //   ),
                      // );
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 6.0,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 200.0),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                width: getSizePage(context, 1, 60),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final ProviderModel option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(getLanguage(
                                                context, 'provider') +
                                            ": " +
                                            "${option.nAME ?? ''}${getLanguage(context, 'address')}: ${option.aDDRESS ?? ''} ${getLanguage(context, 'taxNumber')}: ${option.tAXNUMBER ?? ''} "),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  hint: Text(getLanguage(context, 'filter')),
                  value: _selectedType,
                  items: types
                      .map<DropdownMenuItem<TypeModel>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(getLanguage(context, e.name!)),
                        ),
                      )
                      .toList(),
                  onChanged: (TypeModel? value) => setState(
                    () {
                      if (value != null) _selectedType = value;
                    },
                  ),
                ),
              ),
              Consumer<ProviderProviderDetails>(
                  builder: (context, providerProviderDetails, child) {
                return Container(
                  width: getSizePage(context, 1, 60),
                  child: Autocomplete<ProviderDetails>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty ||
                          _selectedType == null) {
                        return const Iterable<ProviderDetails>.empty();
                      } else {
                        // Replace 'otherModelList' with your list of OtherModel objects

                        List<ProviderDetails> matches =
                            await providerProviderDetails
                                .getSearchedProviderDetailsDataCustom(StaticData
                                        .urlProviderDetailsSearch +
                                    '?column=START_DATE&value=${textEditingValue.text}&providerId=${selectedProviderMOdel.iD}&type=${getLanguage(context, _selectedType!.name ?? '')}');

                        return matches;
                      }
                    },
                    onSelected: (ProviderDetails selection) {
                      selectedProviderDetails = selection;

                      // Update the text in the TextFormField when a vehicle is selected
                      _providerDetailsController.text = selection.tYPE! +
                          ' / ' +
                          selection.fROMCITY! +
                          '--' +
                          selection.tOCITY! +
                          selection.sTARTDATE!;
                      print('You just selected ${selectedVehicle.nAME}');
                      FocusScope.of(context)
                          .requestFocus(_providerDetailsReciverFieldFocus);
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      _providerDetailsController = textEditingController;
                      _providerDetailsFieldFocus =
                          focusNode; // Store the controller
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onChanged: (String value) {
                          // Additional actions while the text changes, if needed
                        },
                        onFieldSubmitted: (String value) {
                          // Handle the submitted value, if needed
                        },
                        decoration: InputDecoration(
                          labelText: getLanguage(
                              context, 'typeToSearchProviderDerails'),
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<ProviderDetails> onSelected,
                        Iterable<ProviderDetails> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 6.0,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 200.0),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                width: getSizePage(context, 1, 60),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final ProviderDetails option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            "${getLanguage(context, 'type')}: ${option.tYPE ?? ''} ${getLanguage(context, 'costPerTon')}:  ${option.aMMOUNTPERTON ?? ''} ${getLanguage(context, 'date')}:  ${option.sTARTDATE ?? ''} "),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  hint: Text(getLanguage(context, 'filter')),
                  value: selectedProviderMapColumn2,
                  items: providerColumnsItems2
                      .map<DropdownMenuItem<ProviderMap>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(getLanguage(context, e.nameEnglish!)),
                        ),
                      )
                      .toList(),
                  onChanged: (ProviderMap? value) => setState(
                    () {
                      if (value != null) selectedProviderMapColumn2 = value;
                    },
                  ),
                ),
              ),
              Consumer<ProviderProvider>(
                  builder: (context, providerProvider, child) {
                return Container(
                  width: getSizePage(context, 1, 60),
                  child: Autocomplete<ProviderModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty ||
                          selectedProviderMapColumn2 == null) {
                        return const Iterable<ProviderModel>.empty();
                      } else {
                        // Replace 'otherModelList' with your list of OtherModel objects
                        List<ProviderModel> matches = await providerProvider
                            .getSearchedProviderDataCustom(StaticData
                                    .urlProviderSearch +
                                '?column=${selectedProviderMapColumn2!.column}&value=${textEditingValue.text}');

                        return matches;
                      }
                    },
                    onSelected: (ProviderModel selection) async {
                      selectedProviderReciverMOdel = selection;

                      // Update the text in the TextFormField when a vehicle is selected
                      _providerReciverController.text = selection.nAME ?? '';
                      FocusScope.of(context).requestFocus(_driverFieldFocus);
                      print('You just selected ${selectedVehicle.nAME}');
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      _providerReciverController = textEditingController;
                      _providerDetailsReciverFieldFocus = focusNode;
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onChanged: (String value) {
                          // Additional actions while the text changes, if needed
                        },
                        onFieldSubmitted: (String value) {
                          // Handle the submitted value, if needed
                        },
                        decoration: InputDecoration(
                          labelText:
                              getLanguage(context, 'typeToSearchProvider'),
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<ProviderModel> onSelected,
                        Iterable<ProviderModel> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 6.0,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 200.0),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                width: getSizePage(context, 1, 60),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final ProviderModel option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(getLanguage(
                                                context, 'provider') +
                                            ": " +
                                            "${option.nAME ?? ''}${getLanguage(context, 'address')}: ${option.aDDRESS ?? ''} ${getLanguage(context, 'taxNumber')}: ${option.tAXNUMBER ?? ''} "),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
          Padding(padding: EdgeInsets.only(top: 20)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton(
                  dropdownColor: Colors.white,
                  hint: Text(getLanguage(context, 'filter')),
                  value: selectedDriverColumn,
                  items: driverColumnsItems
                      .map<DropdownMenuItem<DriverMap>>(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(getLanguage(context, e.nameEnglish!)),
                        ),
                      )
                      .toList(),
                  onChanged: (DriverMap? value) => setState(
                    () {
                      if (value != null) selectedDriverColumn = value;
                    },
                  ),
                ),
              ),
              Consumer<ProviderDriver>(
                  builder: (context, providerDriver, child) {
                return Container(
                  width: getSizePage(context, 1, 60),
                  child: Autocomplete<DriverModel>(
                    optionsBuilder: (TextEditingValue textEditingValue) async {
                      if (textEditingValue.text.isEmpty ||
                          selectedDriverColumn == null) {
                        return const Iterable<DriverModel>.empty();
                      } else {
                        // Replace 'otherModelList' with your list of OtherModel objects
                        List<DriverModel> matches = await providerDriver
                            .getSearchedDriverDataCustoms(StaticData
                                    .urlDriverSearch +
                                '?column=${selectedDriverColumn!.column}&value=${textEditingValue.text}');

                        return matches;
                      }
                    },
                    onSelected: (DriverModel selection) {
                      selectedDriver = selection;

                      // Update the text in the TextFormField when a vehicle is selected
                      _driverController.text = selection.nAMED ?? '';
                      print('You just selected ${selection.nAMED}');
                      FocusScope.of(context).requestFocus(_numberTonFieldFocus);
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController textEditingController,
                        FocusNode focusNode,
                        VoidCallback onFieldSubmitted) {
                      _driverController = textEditingController;
                      _driverFieldFocus = focusNode;
                      //Store the controller
                      return TextFormField(
                        controller: textEditingController,
                        focusNode: focusNode,
                        onChanged: (String value) {
                          // Additional actions while the text changes, if needed
                        },
                        onFieldSubmitted: (String value) {
                          // Handle the submitted value, if needed
                        },
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'typeToSearchDriver'),
                          border: OutlineInputBorder(),
                        ),
                      );
                    },
                    optionsViewBuilder: (BuildContext context,
                        AutocompleteOnSelected<DriverModel> onSelected,
                        Iterable<DriverModel> options) {
                      return Align(
                        alignment: Alignment.topLeft,
                        child: Material(
                          elevation: 6.0,
                          child: Container(
                            constraints: BoxConstraints(maxHeight: 200.0),
                            child: SingleChildScrollView(
                              physics: AlwaysScrollableScrollPhysics(),
                              child: Container(
                                width: getSizePage(context, 1, 60),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: options.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    final DriverModel option =
                                        options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text(
                                            " ${getLanguage(context, 'name')}: ${option.nAMED ?? ''} ${getLanguage(context, 'license')}: ${option.aDDRESSD ?? ''} "),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            ],
          ),
          Container(
            width: getSizePage(context, 1, 63),
            child: CustomTextFieldSearch(
              focusNode: _numberTonFieldFocus,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
              ],
              onChanged: (value) {
                if (value != "" &&
                    selectedProviderDetails.aMMOUNTPERTON != null) {
                  var inputdata = double.parse(value);
                  totalValue.text =
                      (selectedProviderDetails.aMMOUNTPERTON! * inputdata)
                          .toString();
                  // double caltotalValue =
                  //     selectedProviderMOdel.! * inputdata;
                  //  totalValue.text = "$caltotalValue";
                } else {
                  totalValue.text = 0.0.toString();
                }
              },
              controllerCaseNumber: numberOfTon,
              labelText: getLanguage(context, 'numberOfTon'),
            ),
          ),
          Container(
            width: getSizePage(context, 1, 63),
            child: DateTimeFormField(
              style: const TextStyle(
                color: Colors.black,
                decorationStyle: TextDecorationStyle.solid,
              ),
              decoration: InputDecoration(
                labelText: getLanguage(context, 'dateTo'),
              ),
              firstDate: DateTime.now().add(const Duration(days: -222222)),
              lastDate: DateTime.now().add(const Duration(days: 222222)),
              initialPickerDateTime: DateTime.now(),
              onChanged: (DateTime? value) {
                requestDate = value;
                //selectedDate = value;
              },
            ),
          ),
          Container(
            width: getSizePage(context, 1, 63),
            child: CustomTextFieldSearch(
              controllerCaseNumber: totalValue,
              labelText: getLanguage(context, 'totalValue'),
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                final ProviderTransportationFee providerTransportationFee =
                    Provider.of<ProviderTransportationFee>(context,
                        listen: false);
                type = selectedProviderDetails.tYPE!;
                if (selectedVehicle.iD == null &&
                    numberOfTon.text == "" &&
                    selectedProviderDetails.iD == null &&
                    requestDate == null &&
                    totalValue.text == "" &&
                    selectedDriver.iDD == null &&
                    selectedProviderReciverMOdel.iD == null &&
                    type == "") {
                  providerTransportationFee.changeMessage(Text(
                    getLanguage(context, 'messageFaild'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 158, 62, 55)),
                  ));
                } else {
                  TransportationFeeModel transportationFeeModel =
                      TransportationFeeModel();
                  transportationFeeModel.carsId = selectedVehicle.iD.toString();
                  transportationFeeModel.changerId =
                      widget.user.id.toString(); //widget.user.id
                  transportationFeeModel.numberOfTon =
                      numberOfTon.text.toString();
                  transportationFeeModel.providersDetailsId =
                      selectedProviderDetails.iD.toString();
                  transportationFeeModel.requestDate = requestDate.toString();
                  transportationFeeModel.totalValue =
                      totalValue.text.toString();
                  transportationFeeModel.driversId =
                      selectedDriver.iDD.toString();
                  transportationFeeModel.providersReciverId =
                      selectedProviderReciverMOdel.iD.toString();
                  transportationFeeModel.type = type;
                  await providerTransportationFee.addTransporationFee(
                      StaticData.urltransportationFeeAdd,
                      transportationFeeModel,
                      requestDate);
                  providerTransportationFee.changeMessage(Text(
                    getLanguage(context, 'messageSuccess'),
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color.fromARGB(255, 31, 124, 19)),
                  ));

                  numberOfTon.clear();
                  totalValue.clear();
                  _vehicleController.clear();
                  _providerController.clear();
                  _providerDetailsController.clear();
                  _driverController.clear();
                  _providerReciverController.clear();
                  selectedVehicle = Vehicle();
                  selectedProviderReciverMOdel = ProviderModel();
                  selectedProviderMOdel = ProviderModel();
                  selectedProviderDetails = ProviderDetails();
                  selectedDriver = DriverModel();
                }
              },
              child: Text(getLanguage(context, 'addTransportation'))),
        ],
      ),
    );
  }
}

// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);
class VehicleMap {
  String? nameEnglish;
  String? column;

  VehicleMap(this.nameEnglish, this.column);
}

class ProviderMap {
  String? nameEnglish;
  String? column;

  ProviderMap(this.nameEnglish, this.column);
}

class DriverMap {
  String? nameEnglish;
  String? column;

  DriverMap(this.nameEnglish, this.column);
}
