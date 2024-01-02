import 'dart:io';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:untitled4/model/driver_model.dart';
import 'package:untitled4/model/providerDetails_model.dart';
import 'package:adoptive_calendar/adoptive_calendar.dart';
import 'package:untitled4/model/provider_model.dart';
import 'package:untitled4/model/transportation_fee_model.dart';
import 'package:untitled4/model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:untitled4/cutomwidget/customTextFieldSearch.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/functions/mediaquery.dart';
import 'package:open_file/open_file.dart';

class TransportationFee extends StatefulWidget {
  const TransportationFee({super.key});

  @override
  State<TransportationFee> createState() => _TransportationFeeState();
}

class _TransportationFeeState extends State<TransportationFee> {
  TextEditingController numberOfTon = TextEditingController();

  TextEditingController requestDate = TextEditingController();
  TextEditingController totalValue = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  TextEditingController _providerController = TextEditingController();
  TextEditingController _providerDetailsController = TextEditingController();
  TextEditingController _driverController = TextEditingController();
  Vehicle selectedVehicle = Vehicle();
  ProviderModel selectedProviderMOdel = ProviderModel();
  ProviderDetails selectedProviderDetails = ProviderDetails();
  DriverModel selectedDriver = DriverModel();
  String selected = '';
  FocusNode _vehicleFieldFocus = FocusNode();
  FocusNode _providerFieldFocus = FocusNode();
  FocusNode _providerDetailsFieldFocus = FocusNode();
  FocusNode _driverFieldFocus = FocusNode();
  Future<void> prepareData(BuildContext context) async {
    final ProviderTransportationFee providerTransportationFee =
        Provider.of<ProviderTransportationFee>(context, listen: false);
    await providerTransportationFee
        .vehiclePrepareList(StaticData.urlGetAllVehicle);
    await providerTransportationFee
        .providerPrepareList(StaticData.urlGetAllProviders);
    await providerTransportationFee
        .driverPrepareList(StaticData.urlGetAllDriver);

    // await providerTransportationFee.addTransporationFee(
    //               StaticData.urltransportationFeeAdd, transportationFeeModel);
  }

  // @override
  // void dispose() {
  //   _vehicleController.dispose();
  //   _providerController.dispose();
  //   _providerDetailsController.dispose();
  //   _driverController.dispose();
  //   _vehicleFieldFocus.dispose();
  //   _providerFieldFocus.dispose();
  //   _vehicleFieldFocus.dispose();
  //   _providerDetailsFieldFocus.dispose();
  //   _driverFieldFocus.dispose();

  //   super.dispose();
  // }

  @override
  void initState() {
    prepareData(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Consumer<ProviderTransportationFee>(
              builder: (context, providerTransportationData, child) {
            return Container(
              width: getSizePage(context, 1, 60),
              child: Autocomplete<Vehicle>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<Vehicle>.empty();
                  } else {
                    // Replace 'otherModelList' with your list of OtherModel objects
                    List<Vehicle> matches = providerTransportationData
                        .vehicleList
                        .where((item) =>
                            item.nAME != null &&
                            item.nAME!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                        .toList();

                    return matches;
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
                      labelText: 'Type to search Vehicle',
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
                              itemBuilder: (BuildContext context, int index) {
                                final Vehicle option = options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(
                                        "${option.nAME ?? ''}  ${option.nUMBEROFTRANSACTIONS ?? ''} ${option.cHANGERID ?? ''} "),
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
          Padding(padding: EdgeInsets.only(top: 20)),
          Consumer<ProviderTransportationFee>(
              builder: (context, providerTransportationData, child) {
            return Container(
              width: getSizePage(context, 1, 60),
              child: Autocomplete<ProviderModel>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<ProviderModel>.empty();
                  } else {
                    // Replace 'otherModelList' with your list of OtherModel objects
                    List<ProviderModel> matches = providerTransportationData
                        .providerList
                        .where((item) =>
                            item.nAME != null &&
                            item.nAME!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                        .toList();

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
                  final ProviderTransportationFee providerTransportationFee =
                      Provider.of<ProviderTransportationFee>(context,
                          listen: false);

                  await providerTransportationFee.providerDetailsPrepareList(
                      "${StaticData.urlGetAllProviderDetailsByProviderId}/${selectedProviderMOdel.iD}");
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
                      labelText: 'Type to search provider',
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
                              itemBuilder: (BuildContext context, int index) {
                                final ProviderModel option =
                                    options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(
                                        "${option.nAME ?? ''}  ${option.nAME ?? ''} ${option.cHANGERID ?? ''} "),
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
          Padding(padding: EdgeInsets.only(top: 20)),
          Consumer<ProviderTransportationFee>(
              builder: (context, providerTransportationData, child) {
            return Container(
              width: getSizePage(context, 1, 60),
              child: Autocomplete<ProviderDetails>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<ProviderDetails>.empty();
                  } else {
                    // Replace 'otherModelList' with your list of OtherModel objects
                    List<ProviderDetails> matches = providerTransportationData
                        .providerDetailsList
                        .where((item) =>
                            item.sTARTDATE != null &&
                            item.sTARTDATE!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                        .toList();

                    return matches;
                  }
                },
                onSelected: (ProviderDetails selection) {
                  selectedProviderDetails = selection;

                  // Update the text in the TextFormField when a vehicle is selected
                  _providerDetailsController.text = selection.sTARTDATE ?? '';
                  print('You just selected ${selectedVehicle.nAME}');
                  FocusScope.of(context).requestFocus(_driverFieldFocus);
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
                      labelText: 'Type to search provider_details',
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
                              itemBuilder: (BuildContext context, int index) {
                                final ProviderDetails option =
                                    options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(
                                        "${option.tIMESTAMP ?? ''}  /////  ${option.eNDDATE ?? ''}  /////   ${option.aMMOUNTPERTON ?? ''} "),
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
          Padding(padding: EdgeInsets.only(top: 20)),
          Consumer<ProviderTransportationFee>(
              builder: (context, providerTransportationData, child) {
            return Container(
              width: getSizePage(context, 1, 60),
              child: Autocomplete<DriverModel>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  if (textEditingValue.text.isEmpty) {
                    return const Iterable<DriverModel>.empty();
                  } else {
                    // Replace 'otherModelList' with your list of OtherModel objects
                    List<DriverModel> matches = providerTransportationData
                        .driverList
                        .where((item) =>
                            item.nAME != null &&
                            item.nAME!
                                .toLowerCase()
                                .contains(textEditingValue.text.toLowerCase()))
                        .toList();

                    return matches;
                  }
                },
                onSelected: (DriverModel selection) {
                  selectedDriver = selection;

                  // Update the text in the TextFormField when a vehicle is selected
                  _driverController.text = selection.nAME ?? '';

                  //FocusScope.of(context).requestFocus(_);
                },
                fieldViewBuilder: (BuildContext context,
                    TextEditingController textEditingController,
                    FocusNode focusNode,
                    VoidCallback onFieldSubmitted) {
                  _driverController = textEditingController;
                  _driverFieldFocus = focusNode; // Store the controller
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
                      labelText: 'Type to search Driver',
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
                              itemBuilder: (BuildContext context, int index) {
                                final DriverModel option =
                                    options.elementAt(index);
                                return GestureDetector(
                                  onTap: () {
                                    onSelected(option);
                                  },
                                  child: ListTile(
                                    title: Text(
                                        "${option.nAME ?? ''}  /////  ${option.aDDRESS ?? ''}  /////   ${option.tIMESTAMP ?? ''} "),
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
          Container(
            width: getSizePage(context, 1, 63),
            child: CustomTextFieldSearch(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'(^-?\d*\.?\d*)'))
              ],
              onChanged: (value) {
                var inputdata = double.parse(value);
                double caltotalValue =
                    selectedProviderMOdel.aMMOUNTPERTON! * inputdata;
                totalValue.text = "$caltotalValue";
              },
              controllerCaseNumber: numberOfTon,
              labelText: "numberOfTon",
            ),
          ),
          Container(
            width: getSizePage(context, 1, 63),
            child: TextField(
                controller: requestDate, //editing controller of this TextField
                decoration: InputDecoration(
                    icon: Icon(Icons.calendar_today), //icon of text field
                    labelText: "lableString" //"من تاريخ" //label text of field
                    ),
                readOnly: true, // when true user cannot edit text
                onTap: () async {
                  DateTime? pickedDate = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AdoptiveCalendar(
                        maxYear: 2222,
                        minYear: 1111,
                        initialDate: DateTime.now(),
                        use24hFormat: true,
                      );
                    },
                  );
                  // DateTime? pickedDate = await showDatePicker(
                  //     context: context,
                  //     initialDate: DateTime.now(), //get today's date
                  //     firstDate: DateTime(
                  //         2000), //DateTime.now() - not to allow to choose before today.
                  //     lastDate: DateTime(2101));
                  if (pickedDate != null) {
                    String formattedDate = DateFormat('dd-MM-yyyy-hh-mm-ss').format(
                        pickedDate); // format date in required form here we use yyyy-MM-dd that means time is removed
                    requestDate.text =
                        formattedDate; //set foratted date to TextField value.
                  } else {
                    print("Date is not selected");
                  }
                }),
          ),
          Container(
            width: getSizePage(context, 1, 63),
            child: CustomTextFieldSearch(
              controllerCaseNumber: totalValue,
              labelText: "totalValue",
            ),
          ),
          ElevatedButton(
              onPressed: () async {
                TransportationFeeModel transportationFeeModel =
                    TransportationFeeModel();
                transportationFeeModel.carsId = selectedVehicle.iD.toString();
                transportationFeeModel.changerId = "1";
                transportationFeeModel.numberOfTon =
                    numberOfTon.text.toString();
                transportationFeeModel.providersDetailsId =
                    selectedProviderDetails.iD.toString();
                transportationFeeModel.requestDate =
                    requestDate.text.toString();
                transportationFeeModel.totalValue = totalValue.text.toString();
                final ProviderTransportationFee providerTransportationFee =
                    Provider.of<ProviderTransportationFee>(context,
                        listen: false);

                await providerTransportationFee.addTransporationFee(
                    StaticData.urltransportationFeeAdd, transportationFeeModel);
                print("object");
              },
              child: Text("أضافة")),
        ],
      ),
    );
  }
}

Future<File> generatePDF(List<Vehicle> data) async {
  final pdf = pw.Document();
  late pw.Font arFont;

  // Load the Arabic font
  ByteData fontData =
      await rootBundle.load("assets/fonts/static/Cairo-Bold.ttf");
  arFont = pw.Font.ttf(fontData.buffer.asByteData());

  List<List<String>> tableData = [
    ['اسم', 'العمر'] // Arabic column headers
  ];

  data.forEach((object) {
    tableData.add([object.nAME!, object.cREATEDAT.toString()]);
  });

  final List<dynamic> dividedData = [];
  for (var i = 0; i < tableData.length; i += 20) {
    dividedData.add(tableData.sublist(
        i, i + 20 > tableData.length ? tableData.length : i + 20));
  }

  for (var i = 0; i < dividedData.length; i++) {
    final pdfTable = pw.Table.fromTextArray(
      data: dividedData[i],
      headerCount: 1,
      cellAlignment: pw.Alignment.center,
      border: pw.TableBorder.all(width: 1),
      headerStyle: pw.TextStyle(font: arFont, fontWeight: pw.FontWeight.bold),
      cellStyle: pw.TextStyle(font: arFont),
    );

    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                if (i == 0)
                  pw.Text('قائمة الكائنات الخاصة بك',
                      style: pw.TextStyle(font: arFont, fontSize: 20)),
                pw.SizedBox(height: 20),
                pdfTable,
              ],
            ),
          );
        },
      ),
    );
  }
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/object_list.pdf');
  await file.writeAsBytes(await pdf.save());
  OpenFile.open('${output.path}/object_list.pdf');
  return file;
}


// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);