import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/model/vehicle_model.dart';
import 'package:flutter/material.dart';

import '../controller/provider_driver.dart';

import '../data/langaue.dart';
import '../data/staticdata.dart';
import '../functions/mediaquery.dart';
import '../model/driver_model.dart';

class DriverTab extends StatefulWidget {
  const DriverTab({super.key, required this.user, required this.language});
  final User user;
  final String language;
  @override
  State<DriverTab> createState() => _DriverTabState();
}

class _DriverTabState extends State<DriverTab> {
  Vehicle selectedVehicle = Vehicle();
  String selected = '';
  DriverMap? selectedColumn;
  List<DriverMap> vehicleColumnsItems = [
    DriverMap("name", "NAME"),
    DriverMap("address", "ADDRESS"),
  ];
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerFirstName = TextEditingController();
  TextEditingController _controllerSecondName = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerSearched = TextEditingController();

  DriverModel? driverModelEdit;
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
                  Consumer<ProviderDriver>(
                      builder: (context, providerDriver, child) {
                    return IconButton(
                        onPressed: () {
                          addEdit = 2;
                        },
                        icon: Icon(Icons.edit));
                  }),
                  Consumer<ProviderDriver>(
                      builder: (context, providerDriver, child) {
                    return providerDriver.message;
                  }),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerFirstName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'firstNameDriver'),
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
                          EdgeInsets.symmetric(horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerSecondName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'secondName'),
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
                        controller: _controllerAddress,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'address'),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final ProviderDriver providerDriver =
                            Provider.of<ProviderDriver>(context, listen: false);
                        DriverModel driver = DriverModel(
                            aDDRESSD: _controllerAddress.text,
                            fIRSTNAMED: _controllerFirstName.text,
                            sECONDNAMED: _controllerSecondName.text,
                            nAMED: _controllerFirstName.text +
                                ' ' +
                                _controllerSecondName.text,
                            cHANGERIDD: int.tryParse(widget.user.id!));
                        await providerDriver.addDriver(
                            StaticData.urlAddDriver, driver);
///////////////////////////////////////TODO/////////////////////
                        _controllerAddress.clear();
                        _controllerFirstName.clear();
                        _controllerSecondName.clear();
                        Text message =
                            Text(getLanguage(context, 'messageSuccess'));
                        providerDriver.changeMessage(message);
                      }
                    },
                    child: Text(getLanguage(context, 'addDriver')),
                  ),
                ],
              ),
            )
          : Form(
              ///edit
              key: _formKey,
              child: Column(
                children: [
                  Consumer<ProviderDriver>(
                      builder: (context, providerDriver, child) {
                    return providerDriver.message;
                  }),
                  Consumer<ProviderDriver>(
                      builder: (context, providerDriver, child) {
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
                        Expanded(
                            flex: 10, child: Text(getLanguage(context, 'add'))),
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
                            hint: Text(getLanguage(context, 'filter')),
                            value: selectedColumn,
                            items: vehicleColumnsItems
                                .map<DropdownMenuItem<DriverMap>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                        getLanguage(context, e.nameEnglish!)),
                                  ),
                                )
                                .toList(),
                            onChanged: (DriverMap? value) => setState(
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
                                labelText:
                                    getLanguage(context, 'typeToSearchDriver'),
                                border: OutlineInputBorder(),
                                fillColor: Colors.white38,
                                filled: true,
                              ),
                              controller: _controllerSearched,
                              onChanged: (value) async {
                                if (selectedColumn != null) {
                                  String url = StaticData.urlDriverSearch +
                                      '?column=${selectedColumn!.column}&value=${_controllerSearched.text}';
                                  final ProviderDriver providerDriver =
                                      Provider.of<ProviderDriver>(context,
                                          listen: false);
                                  await providerDriver
                                      .getSearchedDriverData(url);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(flex: 8, child: SizedBox()),
                      ],
                    ),
                  ),
                  Consumer<ProviderDriver>(
                      builder: (context, providerDriver, child) {
                    return Visibility(
                      visible: providerDriver.searchedList.length > 0 &&
                          _controllerSearched.text != "",
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        width: getSizePage(context, 1, 60),
                        height: getSizePage(context, 2, 30),
                        child: ListView.builder(
                          //shrinkWrap: true,
                          itemCount: providerDriver.searchedList.length,
                          itemBuilder: (context, index) {
                            DriverModel currentObject =
                                providerDriver.searchedList[index];
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
                                          child: Text(currentObject.nAMED!)),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              '${currentObject.aDDRESSD}')),
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              driverModelEdit = providerDriver
                                                  .searchedList[index];
                                              _controllerFirstName.text =
                                                  currentObject.fIRSTNAMED
                                                      .toString();
                                              _controllerSecondName.text =
                                                  currentObject.sECONDNAMED
                                                      .toString();
                                              _controllerAddress.text =
                                                  currentObject.aDDRESSD!;
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
                        controller: _controllerFirstName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'firstNameDriver'),
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
                        controller: _controllerSecondName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'secondName'),
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
                        controller: _controllerAddress,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'address'),
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
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        final ProviderDriver providerDriver =
                            Provider.of<ProviderDriver>(context, listen: false);
                        driverModelEdit!.nAMED = _controllerFirstName.text +
                            ' ' +
                            _controllerSecondName.text;
                        driverModelEdit!.fIRSTNAMED = _controllerFirstName.text;
                        driverModelEdit!.sECONDNAMED =
                            _controllerSecondName.text;
                        driverModelEdit!.aDDRESSD = _controllerAddress.text;
                        driverModelEdit!.cHANGERIDD =
                            int.tryParse(widget.user.id!);

                        if (driverModelEdit != null) {
                          await providerDriver.editDriver(
                              StaticData.urlDriverEdit, driverModelEdit!);
                          _controllerFirstName.clear();
                          _controllerSecondName.clear();
                          _controllerAddress.clear();
                          Text message =
                              Text(getLanguage(context, 'messageEditSuccess'));
                          providerDriver.changeMessage(message);
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

class DriverMap {
  String? nameArabic;
  String? nameEnglish;
  String? column;

  DriverMap(this.nameEnglish, this.column);
}
// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);
