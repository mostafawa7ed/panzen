import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';

import 'package:untitled4/cutomwidget/customTextFieldSearch.dart';
import 'package:untitled4/data/staticdata.dart';

import 'package:untitled4/model/transportation_fee_model.dart';
import 'package:untitled4/model/vehicle_model.dart';

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
  TextEditingController _textEditingController = TextEditingController();
  Vehicle selectedVehicle = Vehicle();
  String selected = '';
  Future<void> prepareData(BuildContext context) async {
    final ProviderTransportationFee providerTransportationFee =
        Provider.of<ProviderTransportationFee>(context, listen: false);
    await providerTransportationFee
        .vehiclePrepareList(StaticData.urlGetAllVehicle);
    // await providerTransportationFee.addTransporationFee(
    //               StaticData.urltransportationFeeAdd, transportationFeeModel);
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() async {
      await prepareData(context);
      // TODO: implement initState
      super.initState();
    }

    prepareData(context);
    List<String> suggestons = [
      "USA",
      "UK",
      "Uganda",
      "Uruguay",
      "United Arab Emirates"
    ];
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          Consumer<ProviderTransportationFee>(
              builder: (context, providerTransportationData, child) {
            return Autocomplete<Vehicle>(
              optionsBuilder: (TextEditingValue textEditingValue) {
                if (textEditingValue.text.isEmpty) {
                  return const Iterable<Vehicle>.empty();
                } else {
                  // Replace 'otherModelList' with your list of OtherModel objects
                  List<Vehicle> matches = providerTransportationData.vehicleList
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
                _textEditingController.text = selection.nAME ?? '';
                print('You just selected ${selectedVehicle.nAME}');
              },
              fieldViewBuilder: (BuildContext context,
                  TextEditingController textEditingController,
                  FocusNode focusNode,
                  VoidCallback onFieldSubmitted) {
                _textEditingController =
                    textEditingController; // Store the controller
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
                      width: MediaQuery.of(context).size.width,
                      height: 200,
                      child: SingleChildScrollView(
                        physics: AlwaysScrollableScrollPhysics(),
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
                );
              },
            );
          }),

          // Consumer<ProviderTransportationFee>(
          //     builder: (context, providerTransportationData, child) {
          //   return Autocomplete<Vehicle>(
          //     optionsBuilder: (TextEditingValue textEditingValue) {
          //       if (textEditingValue.text.isEmpty) {
          //         return const Iterable<Vehicle>.empty();
          //       } else {
          //         // Replace 'otherModelList' with your list of OtherModel objects
          //         List<Vehicle> matches = providerTransportationData.vehicleList
          //             .where((item) =>
          //                 item.nAME != null &&
          //                 item.nAME!
          //                     .toLowerCase()
          //                     .contains(textEditingValue.text.toLowerCase()))
          //             .toList();

          //         return matches;
          //       }
          //     },
          //     onSelected: (Vehicle selection) {
          //       selectedVehicle = selection;
          //       print('You just selected ${selectedVehicle.nAME}');
          //     },
          //     fieldViewBuilder: (BuildContext context,
          //         TextEditingController textEditingController,
          //         FocusNode focusNode,
          //         VoidCallback onFieldSubmitted) {
          //       return TextFormField(
          //         controller: textEditingController,
          //         focusNode: focusNode,
          //         onChanged: (String value) {
          //           // Additional actions while the text changes, if needed
          //         },
          //         onFieldSubmitted: (String value) {
          //           // Handle the submitted value, if needed
          //         },
          //         decoration: InputDecoration(
          //           labelText: 'Type to search OtherModel',
          //           border: OutlineInputBorder(),
          //         ),
          //       );
          //     },
          //     optionsViewBuilder: (BuildContext context,
          //         AutocompleteOnSelected<Vehicle> onSelected,
          //         Iterable<Vehicle> options) {
          //       return Align(
          //         alignment: Alignment.topLeft,
          //         child: Material(
          //           elevation: 4.0,
          //           child: Container(
          //             constraints: BoxConstraints(maxHeight: 200.0),
          //             width: MediaQuery.of(context).size.width,
          //             child: ListView.builder(
          //               itemCount: options.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 final Vehicle option = options.elementAt(index);
          //                 return GestureDetector(
          //                   onTap: () {
          //                     onSelected(option);
          //                   },
          //                   child: ListTile(
          //                     title: Text(
          //                         "${option.nAME ?? ''}  ${option.nUMBEROFTRANSACTIONS ?? ''} ${option.cHANGERID ?? ''} "),
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   );
          // }),
          // Padding(
          //   padding: EdgeInsets.only(left: 20, right: 20, top: 30),
          //   child: Autocomplete<String>(
          //     optionsBuilder: (TextEditingValue textEditingValue) {
          //       if (textEditingValue.text.isEmpty) {
          //         return const Iterable<String>.empty();
          //       } else {
          //         List<String> matches = <String>[];
          //         matches.addAll(suggestons);

          //         matches.retainWhere((s) {
          //           return s
          //               .toLowerCase()
          //               .contains(textEditingValue.text.toLowerCase());
          //         });
          //         return matches;
          //       }
          //     },
          //     onSelected: (String selection) {
          //       print('You just selected $selection');
          //     },
          //     fieldViewBuilder: (BuildContext context,
          //         TextEditingController textEditingController,
          //         FocusNode focusNode,
          //         VoidCallback onFieldSubmitted) {
          //       return TextFormField(
          //         controller: textEditingController,
          //         focusNode: focusNode,
          //         onChanged: (String value) {
          //           // You can perform additional actions while the text changes, if needed
          //         },
          //         onFieldSubmitted: (String value) {
          //           // You can handle the submitted value, if needed
          //         },
          //         decoration: InputDecoration(
          //           labelText: 'Type to search',
          //           border: OutlineInputBorder(),
          //         ),
          //       );
          //     },
          //     optionsViewBuilder: (BuildContext context,
          //         AutocompleteOnSelected<String> onSelected,
          //         Iterable<String> options) {
          //       return Align(
          //         alignment: Alignment.topLeft,
          //         child: Material(
          //           elevation: 4.0,
          //           child: Container(
          //             constraints: BoxConstraints(maxHeight: 200.0),
          //             width: MediaQuery.of(context).size.width,
          //             child: ListView.builder(
          //               itemCount: options.length,
          //               itemBuilder: (BuildContext context, int index) {
          //                 final String option = options.elementAt(index);
          //                 return GestureDetector(
          //                   onTap: () {
          //                     onSelected(option);
          //                   },
          //                   child: ListTile(
          //                     title: Text(option),
          //                   ),
          //                 );
          //               },
          //             ),
          //           ),
          //         ),
          //       );
          //     },
          //   ),
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
