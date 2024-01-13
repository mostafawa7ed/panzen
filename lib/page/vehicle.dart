import 'dart:io';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/model/vehicle_model.dart';
import 'package:flutter/material.dart';

import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:open_file/open_file.dart';

import '../controller/provider_vehicle.dart';
import '../data/langaue.dart';
import '../data/staticdata.dart';
import '../functions/mediaquery.dart';

class VehicleTab extends StatefulWidget {
  const VehicleTab({super.key, required this.user, required this.language});
  final User user;
  final String language;
  @override
  State<VehicleTab> createState() => _VehicleTabState();
}

class _VehicleTabState extends State<VehicleTab> {
  Vehicle selectedVehicle = Vehicle();
  String selected = '';
  VehicleMap? selectedColumn;
  List<VehicleMap> vehicleColumnsItems = [
    VehicleMap("Name", "الأسم", "NAME"),
    VehicleMap("Plate Num", "رقم العربة", "PLATE_NO"),
  ];
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPlateNo = TextEditingController();
  TextEditingController _controllerSearched = TextEditingController();

  int? _selectedVehicleTypeId;
  FocusNode _focusNodeName = FocusNode();
  FocusNode _focusNodePlateNo = FocusNode();

  int? vehicletype;
  List<VehicleType> vehicleTypes = [
    VehicleType(1, 'عربة'),
    VehicleType(2, 'مقطورة'),
    // Add more VehicleType objects as needed
  ];
  Vehicle? editedvehicle;
  int addEdit = 1; //add = 1 edit =2
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: addEdit == 1 //add
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  Consumer<ProviderVehicle>(
                      builder: (context, providerVehicle, child) {
                    return IconButton(
                        onPressed: () {
                          addEdit = 2;
                        },
                        icon: Icon(Icons.edit));
                  }),
                  Consumer<ProviderVehicle>(
                      builder: (context, providerVehicle, child) {
                    return providerVehicle.message;
                  }),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerName,
                        focusNode: _focusNodeName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF000000)),
                          ),
                        ),
                        onChanged: (value) {
                          // Add your onChanged logic here
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Add your onSaved logic here
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                        controller: _controllerPlateNo,
                        focusNode: _focusNodePlateNo,
                        decoration: InputDecoration(
                          labelText: 'Plate Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        onChanged: (value) {
                          // Add your onChanged logic here
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a plate number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Add your onSaved logic here
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: getSizePage(context, 1, 55),
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Vehicle Type ID',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      value: _selectedVehicleTypeId,
                      items: vehicleTypes.map((VehicleType type) {
                        return DropdownMenuItem<int>(
                          value: type.id,
                          child: Text(type.name),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedVehicleTypeId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a vehicle type';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        vehicletype = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final ProviderVehicle providerVehicle =
                            Provider.of<ProviderVehicle>(context,
                                listen: false);
                        Vehicle vehicle = Vehicle(
                            vEHICLETYPEID: vehicletype,
                            pLATENO: _controllerPlateNo.text,
                            cHANGERID: int.tryParse(widget.user.id!),
                            nAME: _controllerName.text);
                        await providerVehicle.addVehicle(
                            StaticData.urlAddVehicle, vehicle);
                        _controllerName.clear();
                        _controllerPlateNo.clear();
                        Text message =
                            Text(getLanguage(context, 'messageSuccess'));
                        providerVehicle.changeMessage(message);
                      }
                    },
                    child: Text('add'),
                  ),
                ],
              ),
            )
          : Form(
              ///edit
              key: _formKey,
              child: Column(
                children: [
                  Consumer<ProviderVehicle>(
                      builder: (context, providerVehicle, child) {
                    return providerVehicle.message;
                  }),
                  Consumer<ProviderVehicle>(
                      builder: (context, providerVehicle, child) {
                    return Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: IconButton(
                              onPressed: () {
                                setState(() {
                                  addEdit = 1;
                                });
                              },
                              icon: Icon(Icons.add)),
                        ),
                        Expanded(flex: 10, child: Text("add")),
                        Expanded(flex: 40, child: SizedBox()),
                      ],
                    );
                  }),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(flex: 1, child: SizedBox()),
                        Expanded(
                          flex: 5,
                          child: DropdownButton(
                            value: selectedColumn,
                            items: vehicleColumnsItems
                                .map<DropdownMenuItem<VehicleMap>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(e.nameEnglish!),
                                  ),
                                )
                                .toList(),
                            onChanged: (VehicleMap? value) => setState(
                              () {
                                if (value != null) selectedColumn = value;
                              },
                            ),
                          ),
                        ),
                        Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          flex: 20,
                          child: Container(
                            width: getSizePage(context, 1, 60),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: "",
                                border: OutlineInputBorder(),
                                fillColor: Colors.white38,
                                filled: true,
                              ),
                              controller: _controllerSearched,
                              onChanged: (value) async {
                                if (selectedColumn != null) {
                                  String url = StaticData.urlVehicleSearch +
                                      '?column=${selectedColumn!.column}&value=${_controllerSearched.text}';
                                  final ProviderVehicle providerVehicle =
                                      Provider.of<ProviderVehicle>(context,
                                          listen: false);
                                  await providerVehicle
                                      .getSearchedVehicleData(url);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(flex: 8, child: SizedBox()),
                      ],
                    ),
                  ),
                  Consumer<ProviderVehicle>(
                      builder: (context, providerVehicle, child) {
                    return Container(
                      padding: EdgeInsets.only(top: 20),
                      width: getSizePage(context, 1, 60),
                      height: getSizePage(context, 2, 30),
                      child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: providerVehicle.searchedList.length,
                        itemBuilder: (context, index) {
                          Vehicle currentObject =
                              providerVehicle.searchedList[index];
                          return Card(
                            child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Container(
                                    child: Row(
                                  children: [
                                    Expanded(
                                        flex: 1,
                                        child: Text((index + 1).toString())),
                                    Expanded(
                                        flex: 2,
                                        child: Text(currentObject.nAME!)),
                                    Expanded(
                                        flex: 2,
                                        child:
                                            Text('${currentObject.pLATENO}')),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                          '${currentObject.nUMBEROFTRANSACTIONS}'),
                                    ),
                                    Expanded(
                                      child: ElevatedButton(
                                          onPressed: () {
                                            editedvehicle = providerVehicle
                                                .searchedList[index];
                                            _controllerPlateNo.text =
                                                currentObject.pLATENO
                                                    .toString();
                                            _controllerName.text =
                                                currentObject.nAME!;
                                            _selectedVehicleTypeId =
                                                currentObject.vEHICLETYPEID;
                                          },
                                          child: Text("Select")),
                                    ),
                                  ],
                                ))),
                          );
                          // return ListTile(
                          //   leading: Text((index + 1).toString()),
                          //   title: Text(currentObject.nAME!),
                          //   trailing: ElevatedButton(
                          //       onPressed: () {
                          //         editedvehicle =
                          //             providerVehicle.searchedList[index];
                          //         _controllerPlateNo.text =
                          //             currentObject.pLATENO.toString();
                          //         _controllerName.text = currentObject.nAME!;
                          //         _selectedVehicleTypeId =
                          //             currentObject.vEHICLETYPEID;
                          //       },
                          //       child: Text("Select")),
                          //   subtitle: Text(
                          //       '${currentObject.pLATENO} - ${currentObject.nUMBEROFTRANSACTIONS}'),
                          //   onTap: () {},
                          // );
                        },
                      ),
                    );
                  }),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerName,
                        focusNode: _focusNodeName,
                        decoration: InputDecoration(
                          labelText: 'Name',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0xFF000000)),
                          ),
                        ),
                        onChanged: (value) {
                          // Add your onChanged logic here
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Add your onSaved logic here
                        },
                      ),
                    ),
                  ),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                      child: TextFormField(
                        controller: _controllerPlateNo,
                        focusNode: _focusNodePlateNo,
                        decoration: InputDecoration(
                          labelText: 'Plate Number',
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green),
                          ),
                        ),
                        onChanged: (value) {
                          // Add your onChanged logic here
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a plate number';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Add your onSaved logic here
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: getSizePage(context, 1, 55),
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: 'Vehicle Type ID',
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                      ),
                      value: _selectedVehicleTypeId,
                      items: vehicleTypes.map((VehicleType type) {
                        return DropdownMenuItem<int>(
                          value: type.id,
                          child: Text(type.name),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedVehicleTypeId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a vehicle type';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        vehicletype = value;
                      },
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final ProviderVehicle providerVehicle =
                            Provider.of<ProviderVehicle>(context,
                                listen: false);
                        editedvehicle!.nAME = _controllerName.text;
                        editedvehicle!.pLATENO = _controllerPlateNo.text;
                        editedvehicle!.vEHICLETYPEID = vehicletype;
                        editedvehicle!.cHANGERID =
                            int.tryParse(widget.user.id!);
                        if (editedvehicle != null) {
                          await providerVehicle.editVehicle(
                              StaticData.urlVehicleEdit, editedvehicle!);
                          _controllerName.clear();
                          _controllerPlateNo.clear();
                          Text message =
                              Text(getLanguage(context, 'messageSuccess'));
                          providerVehicle.changeMessage(message);
                        }
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ),
    );
  }
}

class VehicleType {
  final int id;
  final String name;

  VehicleType(this.id, this.name);
}

class VehicleMap {
  String? nameArabic;
  String? nameEnglish;
  String? column;

  VehicleMap(this.nameArabic, this.nameEnglish, this.column);
}
// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);
