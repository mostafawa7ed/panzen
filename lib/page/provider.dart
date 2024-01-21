import 'package:date_field/date_field.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/model/user_model.dart';

import 'package:flutter/material.dart';

import '../controller/provider_provider.dart';
import '../controller/provider_providerDetails.dart';

import '../data/langaue.dart';
import '../data/staticdata.dart';
import '../functions/mediaquery.dart';

import '../model/providerDetails_model.dart';
import '../model/provider_model.dart';

class ProviderTab extends StatefulWidget {
  const ProviderTab({super.key, required this.user, required this.language});
  final User user;
  final String language;
  @override
  State<ProviderTab> createState() => _ProviderTabState();
}

class _ProviderTabState extends State<ProviderTab> {
  ProviderModel selectedProvider = ProviderModel();
  String selected = '';
  ProviderMap? selectedColumn;
  List<ProviderMap> providerColumnsItems = [
    ProviderMap("Name", "NAME"),
    ProviderMap("Address", "ADDRESS"),
  ];
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerSearched = TextEditingController();

  ProviderModel? providerModelEdit;
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
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return IconButton(
                        onPressed: () {
                          addEdit = 2;
                        },
                        icon: Icon(Icons.edit));
                  }),
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return providerProvider.message;
                  }),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerName,
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
                        final ProviderProvider providerProvider =
                            Provider.of<ProviderProvider>(context,
                                listen: false);
                        ProviderModel provider = ProviderModel(
                          nAME: _controllerName.text,
                          aDDRESS: _controllerAddress.text,
                          //aMMOUNTPERTON: 1.0,
                          cHANGERID: int.tryParse(widget.user.id!),
                        );
                        await providerProvider.addProvider(
                            StaticData.urlAddProvider, provider);
                        _controllerAddress.clear();
                        _controllerName.clear();

                        Text message =
                            Text(getLanguage(context, 'messageSuccess'));
                        providerProvider.changeMessage(message);
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
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return providerProvider.message;
                  }),
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
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
                            items: providerColumnsItems
                                .map<DropdownMenuItem<ProviderMap>>(
                                  (e) => DropdownMenuItem(
                                    value: e,
                                    child: Text(
                                        getLanguage(context, e.nameEnglish!)),
                                  ),
                                )
                                .toList(),
                            onChanged: (ProviderMap? value) => setState(
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
                                labelText: getLanguage(
                                    context, 'typeToSearchProvider'),
                                border: OutlineInputBorder(),
                                fillColor: Colors.white38,
                                filled: true,
                              ),
                              controller: _controllerSearched,
                              onChanged: (value) async {
                                if (selectedColumn != null) {
                                  String url = StaticData.urlProviderSearch +
                                      '?column=${selectedColumn!.column}&value=${_controllerSearched.text}';
                                  final ProviderProvider providerprovider =
                                      Provider.of<ProviderProvider>(context,
                                          listen: false);
                                  await providerprovider
                                      .getSearchedProviderData(url);
                                }
                              },
                            ),
                          ),
                        ),
                        Expanded(flex: 8, child: SizedBox()),
                      ],
                    ),
                  ),
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return Visibility(
                      visible: providerProvider.searchedList.length > 0 &&
                          _controllerSearched.text != "",
                      child: Container(
                        padding: EdgeInsets.only(top: 20),
                        width: getSizePage(context, 1, 60),
                        height: getSizePage(context, 2, 30),
                        child: ListView.builder(
                          //shrinkWrap: true,
                          itemCount: providerProvider.searchedList.length,
                          itemBuilder: (context, index) {
                            ProviderModel currentObject =
                                providerProvider.searchedList[index];
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
                                              Text('${currentObject.aDDRESS}')),
                                      Expanded(
                                        child: ElevatedButton(
                                            onPressed: () {
                                              providerModelEdit =
                                                  providerProvider
                                                      .searchedList[index];
                                              _controllerName.text =
                                                  currentObject.nAME.toString();

                                              _controllerAddress.text =
                                                  currentObject.aDDRESS!;
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            final ProviderProvider providerProvider =
                                Provider.of<ProviderProvider>(context,
                                    listen: false);
                            providerModelEdit!.nAME = _controllerName.text;
                            providerModelEdit!.aDDRESS =
                                _controllerAddress.text;
                            //providerModelEdit!.aMMOUNTPERTON = 1.0;

                            providerModelEdit!.cHANGERID =
                                int.tryParse(widget.user.id!);

                            if (providerModelEdit != null) {
                              await providerProvider.editProvider(
                                  StaticData.urlProviderEdit,
                                  providerModelEdit!);
                              _controllerName.clear();

                              _controllerAddress.clear();
                              Text message = Text(
                                  getLanguage(context, 'messageEditSuccess'));
                              providerProvider.changeMessage(message);
                            }
                          }
                        },
                        child: Text(getLanguage(context, 'edit')),
                      ),
                      Visibility(
                        visible: providerModelEdit != null,
                        child: ElevatedButton(
                          onPressed: () {
                            if (providerModelEdit!.iD != null) {
                              DateTime? startDate;
                              DateTime? endDate;
                              TextEditingController _controllerAmmountPerTon =
                                  TextEditingController();
                              final formate = DateFormat('yyyy-MM-dd HH:mm:ss');
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: ChangeNotifierProvider(
                                        create: (context) {
                                          return ProviderProviderDetails();
                                        },
                                        child: AlertDialog(
                                          title: Text(getLanguage(
                                              context, 'addNewPricing')),
                                          content: Column(
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DateTimeFormField(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                  ),
                                                  dateFormat: formate,
                                                  decoration: InputDecoration(
                                                    labelText: getLanguage(
                                                        context, 'dateFrom'),
                                                  ),
                                                  firstDate: DateTime.now().add(
                                                      const Duration(
                                                          days: -222222)),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 222222)),
                                                  initialPickerDateTime:
                                                      DateTime.now(),
                                                  onChanged: (DateTime? value) {
                                                    startDate = value;
                                                    //selectedDate = value;
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: DateTimeFormField(
                                                  style: const TextStyle(
                                                    color: Colors.black,
                                                    decorationStyle:
                                                        TextDecorationStyle
                                                            .solid,
                                                  ),
                                                  dateFormat: formate,
                                                  decoration: InputDecoration(
                                                    labelText: getLanguage(
                                                        context, 'dateFrom'),
                                                  ),
                                                  firstDate: DateTime.now().add(
                                                      const Duration(
                                                          days: -222222)),
                                                  lastDate: DateTime.now().add(
                                                      const Duration(
                                                          days: 222222)),
                                                  initialPickerDateTime:
                                                      DateTime.now(),
                                                  onChanged: (DateTime? value) {
                                                    endDate = value;
                                                    //selectedDate = value;
                                                  },
                                                ),
                                              ),
                                              TextField(
                                                inputFormatters: [
                                                  FilteringTextInputFormatter
                                                      .allow(RegExp(
                                                          r'(^-?\d*\.?\d*)'))
                                                ],
                                                controller:
                                                    _controllerAmmountPerTon,
                                                decoration: InputDecoration(
                                                  labelText: getLanguage(
                                                      context, 'costPerTon'),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text(getLanguage(
                                                  context, 'cancel')),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                                child: Text(getLanguage(
                                                    context, 'confirm')),
                                                onPressed: () async {
                                                  final ProviderProviderDetails
                                                      providerProviderDetails =
                                                      Provider.of<
                                                              ProviderProviderDetails>(
                                                          context,
                                                          listen: false);
                                                  ProviderDetails
                                                      newProviderDetails =
                                                      ProviderDetails();
                                                  newProviderDetails.sTARTDATE =
                                                      startDate.toString();
                                                  newProviderDetails.eNDDATE =
                                                      endDate.toString();
                                                  newProviderDetails
                                                          .aMMOUNTPERTON =
                                                      double.tryParse(
                                                          _controllerAmmountPerTon
                                                              .text);
                                                  newProviderDetails.cHANGERID =
                                                      int.tryParse(
                                                          widget.user.id!);
                                                  newProviderDetails
                                                          .pROVIDERSID =
                                                      providerModelEdit!.iD;
                                                  if (newProviderDetails
                                                              .aMMOUNTPERTON !=
                                                          null &&
                                                      newProviderDetails
                                                              .pROVIDERSID !=
                                                          null &&
                                                      newProviderDetails
                                                              .sTARTDATE !=
                                                          null &&
                                                      newProviderDetails
                                                              .eNDDATE !=
                                                          null) {
                                                    await providerProviderDetails
                                                        .addProviderDetails(
                                                            StaticData
                                                                .urlAddProviderDetails,
                                                            newProviderDetails);
                                                    _controllerName.clear();
                                                    _controllerAmmountPerTon
                                                        .clear();
                                                    _controllerAddress.clear();
                                                    providerModelEdit =
                                                        ProviderModel();
                                                    Text message = Text(
                                                        getLanguage(context,
                                                            'messageSuccess'));
                                                    providerProviderDetails
                                                        .changeMessage(message);
                                                    Navigator.of(context).pop();
                                                  }
                                                }),
                                          ],
                                        )),
                                  );
                                },
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return Container(
                                    child: AlertDialog(
                                      title: const Text('Custom Alert Dialog'),
                                      content: Text("Must select Row "),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Cancel'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: Text(getLanguage(context, 'addNewPricing')),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

class ProviderMap {
  String? nameEnglish;
  String? column;

  ProviderMap(this.nameEnglish, this.column);
}
// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);
