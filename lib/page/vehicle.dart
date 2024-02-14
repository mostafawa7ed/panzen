import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/model/vehicle_model.dart';
import 'package:flutter/material.dart';

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
  int flage = 1;
  List<VehicleMap> vehicleColumnsItems = [
    VehicleMap("Name", "NAME"),
    VehicleMap("PlateNum", "PLATE_NO"),
    VehicleMap("DrivierLicence", "DRIVIER_LICENCE"),
  ];
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPlateNo = TextEditingController();
  TextEditingController _controllerSearched = TextEditingController();
  TextEditingController _controllerDrivierLicence = TextEditingController();

  int? _selectedVehicleTypeId;
  // FocusNode _focusNodeName = FocusNode();
  // FocusNode _focusNodePlateNo = FocusNode();
  final formate = DateFormat('yyyy-MM-dd-HH-mm');
  DateTime? fromDate;
  int? vehicletype;
  String? date;
  List<VehicleType> vehicleTypes = [
    VehicleType(1, 'vehiclee'),
    VehicleType(2, 'trailer'),
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
                    return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            addEdit = 2;
                          });
                          _controllerName.clear();
                          _controllerPlateNo.clear();
                          _controllerSearched.clear();
                        },
                        child: Text(getLanguage(context, 'searchAndEdit')));
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
                        //      focusNode: _focusNodeName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'Name'),
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
                            return getLanguage(context, 'fieldsEmpty');
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
                        //  focusNode: _focusNodePlateNo,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'PlateNum'),
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
                            return getLanguage(context, 'fieldsEmpty');
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
                        controller: _controllerDrivierLicence,
                        //      focusNode: _focusNodePlateNo,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'drivierLicence'),
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
                            return getLanguage(context, 'fieldsEmpty');
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
                    child: DateTimeFormField(
                      style: const TextStyle(
                        color: Colors.black,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      dateFormat: formate,
                      decoration: InputDecoration(
                        labelText: getLanguage(context, 'expirationDate'),
                      ),
                      firstDate:
                          DateTime.now().add(const Duration(days: -222222)),
                      lastDate:
                          DateTime.now().add(const Duration(days: 222222)),
                      initialPickerDateTime:
                          fromDate != null ? fromDate! : DateTime.now(),
                      initialDate: fromDate ?? DateTime.now(),
                      onChanged: (DateTime? value) {
                        fromDate = value;
                        //selectedDate = value;
                      },
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: getSizePage(context, 1, 55),
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: getLanguage(context, 'vehicleType'),
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
                          child: Text(getLanguage(context, type.name)),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedVehicleTypeId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return getLanguage(context, 'vaildVehicleType');
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
                          nAME: _controllerName.text,
                          dRIVIERLICENCE: _controllerDrivierLicence.text,
                          eXPIRATIONDATE: fromDate.toString(),
                        );
                        await providerVehicle.addVehicle(
                            StaticData.urlAddVehicle, vehicle);
                        _controllerName.clear();
                        _controllerPlateNo.clear();
                        _controllerDrivierLicence.clear();

                        Text message = Text(
                          getLanguage(context, 'messageSuccess'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 31, 124, 19)),
                        );
                        providerVehicle.changeMessage(message);
                      }
                    },
                    child: Text(getLanguage(context, 'add')),
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
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    addEdit = 1;
                                  });

                                  _controllerName.clear();
                                  _controllerPlateNo.clear();
                                  _controllerSearched.clear();
                                },
                                child: Text(getLanguage(context, 'add')))),
                        Expanded(flex: 50, child: SizedBox()),
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
                            hint: Text(getLanguage(context, 'filter')),
                            value: selectedColumn,
                            items: vehicleColumnsItems
                                .map<DropdownMenuItem<VehicleMap>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                        getLanguage(context, e.nameEnglish!)),
                                  ),
                                )
                                .toList(),
                            onChanged: (VehicleMap? value) async {
                              if (value != null) selectedColumn = value;
                              String url = StaticData.urlVehicleSearch +
                                  '?column=NAME&value= ';
                              final ProviderVehicle providerVehicle =
                                  Provider.of<ProviderVehicle>(context,
                                      listen: false);
                              await providerVehicle.getSearchedVehicleData(url);
                              setState(() {});
                            },
                          ),
                        ),
                        Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          flex: 20,
                          child: Container(
                            width: getSizePage(context, 1, 60),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText:
                                    getLanguage(context, 'typeToSearchVehicle'),
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
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        ),
                        ElevatedButton(
                            onPressed: () async {
                              String url = StaticData.urlVehicleSearch +
                                  '?column=NAME&value= ';
                              final ProviderVehicle providerVehicle =
                                  Provider.of<ProviderVehicle>(context,
                                      listen: false);
                              await providerVehicle.getSearchedVehicleData(url);
                              setState(() {});
                            },
                            child: Text(getLanguage(context, 'search'))),
                        ElevatedButton(
                            onPressed: () async {
                              final ProviderVehicle providerVehicle =
                                  Provider.of<ProviderVehicle>(context,
                                      listen: false);
                              await providerVehicle
                                  .getSearchedVehicleMakeEmpty();
                              setState(() {});
                            },
                            child: Text(getLanguage(context, 'dismissSearch'))),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  Consumer<ProviderVehicle>(
                      builder: (context, providerVehicle, child) {
                    return Visibility(
                      visible: providerVehicle.searchedList.length > 0,
                      //visible: true,
                      child: Container(
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
                                              if (currentObject
                                                      .eXPIRATIONDATE! !=
                                                  "") {
                                                DateTime? dateTime =
                                                    DateTime.parse(currentObject
                                                        .eXPIRATIONDATE!);
                                                editedvehicle = providerVehicle
                                                    .searchedList[index];
                                                _controllerPlateNo.text =
                                                    currentObject.pLATENO
                                                        .toString();
                                                _controllerName.text =
                                                    currentObject.nAME!;
                                                _selectedVehicleTypeId =
                                                    currentObject.vEHICLETYPEID;
                                                _controllerDrivierLicence.text =
                                                    currentObject
                                                        .dRIVIERLICENCE!;
                                                fromDate = dateTime;
                                                date = currentObject
                                                    .eXPIRATIONDATE
                                                    .toString();
                                                setState(() {
                                                  flage = 2;
                                                });
                                              }
                                            },
                                            child: Text(getLanguage(
                                                context, 'select'))),
                                      ),
                                    ],
                                  ))),
                            );
                          },
                        ),
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
                        //        focusNode: _focusNodeName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'Name'),
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
                            return getLanguage(context, 'fieldsEmpty');
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
                        //     focusNode: _focusNodePlateNo,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'PlateNum'),
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
                            return getLanguage(context, 'fieldsEmpty');
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
                        controller: _controllerDrivierLicence,
                        //            focusNode: _focusNodePlateNo,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'drivierLicence'),
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
                            return getLanguage(context, 'fieldsEmpty');
                          }
                          return null;
                        },
                        onSaved: (value) {
                          // Add your onSaved logic here
                        },
                      ),
                    ),
                  ),
                  Visibility(
                      visible: flage == 2,
                      child: Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                                fromDate.toString()),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    flage = 3;
                                  });
                                },
                                child: Text(getLanguage(
                                    context, 'changeExpirationDate')))
                          ],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                        width: getSizePage(context, 1, 55),
                      )),
                  Visibility(
                    visible: flage == 3,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      width: getSizePage(context, 1, 55),
                      child: DateTimeFormField(
                        style: const TextStyle(
                          color: Colors.black,
                          decorationStyle: TextDecorationStyle.solid,
                        ),
                        dateFormat: formate,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'expirationDate'),
                        ),
                        firstDate:
                            DateTime.now().add(const Duration(days: -222222)),
                        lastDate:
                            DateTime.now().add(const Duration(days: 222222)),
                        initialPickerDateTime: DateTime.now(),
                        initialDate: fromDate,
                        onChanged: (DateTime? value) {
                          fromDate = value;
                          //selectedDate = value;
                        },
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                    width: getSizePage(context, 1, 55),
                    child: DropdownButtonFormField<int>(
                      decoration: InputDecoration(
                        labelText: getLanguage(context, 'vehicleType'),
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
                          child: Text(getLanguage(context, type.name)),
                        );
                      }).toList(),
                      onChanged: (int? value) {
                        setState(() {
                          _selectedVehicleTypeId = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return getLanguage(context, 'vaildVehicleType');
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

                        if (editedvehicle != null) {
                          editedvehicle!.nAME = _controllerName.text;
                          editedvehicle!.pLATENO = _controllerPlateNo.text;
                          editedvehicle!.vEHICLETYPEID = vehicletype;
                          editedvehicle!.cHANGERID =
                              int.tryParse(widget.user.id!);
                          editedvehicle!.eXPIRATIONDATE = fromDate.toString();
                          editedvehicle!.dRIVIERLICENCE =
                              _controllerDrivierLicence.text;

                          await providerVehicle.editVehicle(
                              StaticData.urlVehicleEdit, editedvehicle!);
                          _controllerName.clear();
                          _controllerPlateNo.clear();
                          Text message =
                              Text(getLanguage(context, 'messageEditSuccess'));
                          providerVehicle.changeMessage(message);
                        } else {
                          Text message = Text(
                              getLanguage(context, 'messageEditFaildvehicle'));
                          providerVehicle.changeMessage(message);
                        }
                      }
                    },
                    child: Text(getLanguage(context, 'edit')),
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
  String? nameEnglish;
  String? column;

  VehicleMap(this.nameEnglish, this.column);
}
// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);
