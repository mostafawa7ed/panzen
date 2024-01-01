import 'dart:io';
import 'package:flutter/services.dart';
import 'package:untitled4/cutomwidget/customAutoComplete.dart';
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
  TextEditingController carsId = TextEditingController();
  TextEditingController changerId = TextEditingController();
  TextEditingController numberOfTon = TextEditingController();
  TextEditingController providersDetailsId = TextEditingController();
  TextEditingController requestDate = TextEditingController();
  TextEditingController totalValue = TextEditingController();
  TextEditingController _vehicleController = TextEditingController();
  TextEditingController _providerController = TextEditingController();
  Vehicle selectedVehicle = Vehicle();
  ProviderModel selectedProviderMOdel = ProviderModel();
  String selected = '';
  FocusNode _vehicleFieldFocus = FocusNode();
  FocusNode _providerFieldFocus = FocusNode();
  Future<void> prepareData(BuildContext context) async {
    final ProviderTransportationFee providerTransportationFee =
        Provider.of<ProviderTransportationFee>(context, listen: false);
    await providerTransportationFee
        .vehiclePrepareList(StaticData.urlGetAllVehicle);
    await providerTransportationFee
        .providerPrepareList(StaticData.urlGetAllProviders);
    // await providerTransportationFee.addTransporationFee(
    //               StaticData.urltransportationFeeAdd, transportationFeeModel);
  }

  @override
  void dispose() {
    _vehicleController.dispose();
    _providerController.dispose();
    _vehicleFieldFocus.dispose();
    _providerFieldFocus.dispose();
    super.dispose();
  }

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
                onSelected: (ProviderModel selection) {
                  selectedProviderMOdel = selection;

                  // Update the text in the TextFormField when a vehicle is selected
                  _providerController.text = selection.nAME ?? '';
                  print('You just selected ${selectedVehicle.nAME}');
                  FocusScope.of(context).requestFocus(_vehicleFieldFocus);
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
                      labelText: 'Type to search Vehicle',
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
          // TextField(
          //   focusNode: _nextFieldFocus,
          // ),
          CustomTextFieldSearch(
            ///asdsadsjdgs
            controllerCaseNumber: carsId,
            labelText: "carsId",
          ),
          CustomTextFieldSearch(
            controllerCaseNumber: changerId,
            labelText: "changerId",
          ),
          CustomTextFieldSearch(
            controllerCaseNumber: numberOfTon,
            labelText: "numberOfTon",
          ),
          CustomTextFieldSearch(
            controllerCaseNumber: providersDetailsId,
            labelText: "providersDetailsId",
          ),
          CustomTextFieldSearch(
            controllerCaseNumber: requestDate,
            labelText: "requestDate",
          ),
          CustomTextFieldSearch(
            controllerCaseNumber: totalValue,
            labelText: "totalValue",
          ),
          ElevatedButton(
              onPressed: () async {
                TransportationFeeModel transportationFeeModel =
                    TransportationFeeModel();
                transportationFeeModel.carsId =
                    int.tryParse(carsId.text.toString()) ?? 1;
                transportationFeeModel.changerId =
                    int.tryParse(changerId.text.toString()) ?? 1;
                transportationFeeModel.numberOfTon =
                    int.tryParse(numberOfTon.text.toString()) ?? 1;
                transportationFeeModel.providersDetailsId =
                    int.tryParse(providersDetailsId.text.toString()) ?? 1;
                transportationFeeModel.requestDate = carsId.text.toString();
                transportationFeeModel.totalValue =
                    int.tryParse(totalValue.text.toString()) ?? 1;
                final ProviderTransportationFee providerTransportationFee =
                    Provider.of<ProviderTransportationFee>(context,
                        listen: false);
                File pdfFile =
                    await generatePDF(providerTransportationFee.vehicleList);
                // await providerTransportationFee.addTransporationFee(
                //     StaticData.urltransportationFeeAdd, transportationFeeModel);
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
