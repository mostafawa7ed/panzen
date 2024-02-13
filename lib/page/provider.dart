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
import '../model/type_model.dart';

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
  List<TypeModel> types = [
    TypeModel(id: '1', name: 'Diesel'),
    TypeModel(id: '2', name: 'Solar'),
    TypeModel(id: '3', name: 'Gasoline 80'),
    TypeModel(id: '4', name: 'Gasoline 90'),
    TypeModel(id: '5', name: 'Gasoline 92'),
    TypeModel(id: '6', name: 'Gasoline 95'),
  ];
  String? _selectedType;
  List<ProviderDetails> providerDetailsListForProvider = [];
  @override
  void initState() {
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerAddress = TextEditingController();
  TextEditingController _controllerSearched = TextEditingController();
  TextEditingController _controllerTaxNumber = TextEditingController();

  ProviderModel? providerModelEdit;
  int addEdit = 1; //add = 1 edit =2
  int? currentProvider;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: addEdit == 1 //add
          ? Form(
              key: _formKey,
              child: Column(
                children: [
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return ElevatedButton(
                        onPressed: () {
                          setState(() {
                            addEdit = 2;
                          });
                          _controllerName.clear();
                          _controllerTaxNumber.clear();
                          _controllerAddress.clear();
                        },
                        child: Text(getLanguage(context, 'searchAndEdit')));
                  }),
                  Consumer<ProviderProviderDetails>(
                      builder: (context, providerProviderDetails, child) {
                    return providerProviderDetails.message;
                  }),
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return providerProvider.message;
                  }),
                  Container(
                    width: getSizePage(context, 1, 60),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'Name'),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        controller: _controllerAddress,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'address'),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        controller: _controllerTaxNumber,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'taxNumber'),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
                          tAXNUMBER: _controllerTaxNumber.text,
                        );
                        await providerProvider.addProvider(
                            StaticData.urlAddProvider, provider);
                        _controllerAddress.clear();
                        _controllerName.clear();
                        _controllerTaxNumber.clear();

                        Text message = Text(
                          getLanguage(context, 'messageSuccess'),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              color: Color.fromARGB(255, 31, 124, 19)),
                        );
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
                            child: ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    addEdit = 1;
                                  });
                                  _controllerName.clear();
                                  _controllerTaxNumber.clear();
                                  _controllerAddress.clear();
                                },
                                child: Text(getLanguage(context, 'add')))),
                        const Expanded(flex: 50, child: SizedBox()),
                      ],
                    );
                  }),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Expanded(flex: 1, child: SizedBox()),
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
                              () async {
                                if (value != null) selectedColumn = value;
                                String url = StaticData.urlProviderSearch +
                                    '?column=NAME&value= ';
                                final ProviderProvider providerprovider =
                                    Provider.of<ProviderProvider>(context,
                                        listen: false);
                                await providerprovider
                                    .getSearchedProviderData(url);
                              },
                            ),
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                        Expanded(
                          flex: 20,
                          child: Container(
                            width: getSizePage(context, 1, 60),
                            child: TextField(
                              decoration: InputDecoration(
                                labelText: getLanguage(
                                    context, 'typeToSearchProvider'),
                                border: const OutlineInputBorder(),
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
                        ElevatedButton(
                            onPressed: () async {
                              String url = StaticData.urlProviderSearch +
                                  '?column=NAME&value= ';
                              final ProviderProvider providerprovider =
                                  Provider.of<ProviderProvider>(context,
                                      listen: false);
                              await providerprovider
                                  .getSearchedProviderData(url);
                            },
                            child: Text(getLanguage(context, 'search'))),
                        ElevatedButton(
                            onPressed: () async {
                              final ProviderProvider providerprovider =
                                  Provider.of<ProviderProvider>(context,
                                      listen: false);
                              await providerprovider
                                  .getSearchedProviderMakeEmpty();
                            },
                            child: Text(getLanguage(context, 'dismissSearch'))),
                      ],
                    ),
                  ),
                  Consumer<ProviderProvider>(
                      builder: (context, providerProvider, child) {
                    return Visibility(
                      visible: providerProvider.searchedList.length > 0,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
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
                                            onPressed: () async {
                                              currentProvider =
                                                  currentObject.iD;
                                              final ProviderProviderDetails
                                                  providerProviderDetails =
                                                  Provider.of<
                                                          ProviderProviderDetails>(
                                                      context,
                                                      listen: false);
                                              providerDetailsListForProvider =
                                                  await providerProviderDetails
                                                      .getSearchedProviderDetailsDataCustom(
                                                          StaticData
                                                                  .urlProviderDetailsSearch +
                                                              '?column=START_DATE&value= &providerId=${currentObject.iD}&type=%%');

                                              providerModelEdit =
                                                  providerProvider
                                                      .searchedList[index];
                                              _controllerName.text =
                                                  currentObject.nAME.toString();

                                              _controllerAddress.text =
                                                  currentObject.aDDRESS!;
                                              _controllerTaxNumber.text =
                                                  currentObject.tAXNUMBER!;
                                              setState(() {});
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 19),
                      child: TextFormField(
                        controller: _controllerName,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'Name'),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        controller: _controllerAddress,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'address'),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
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
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 10),
                      child: TextFormField(
                        controller: _controllerTaxNumber,
                        decoration: InputDecoration(
                          labelText: getLanguage(context, 'taxNumber'),
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const OutlineInputBorder(
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

                            if (providerModelEdit != null) {
                              providerModelEdit!.nAME = _controllerName.text;
                              providerModelEdit!.aDDRESS =
                                  _controllerAddress.text;
                              providerModelEdit!.tAXNUMBER =
                                  _controllerTaxNumber.text;
                              //providerModelEdit!.aMMOUNTPERTON = 1.0;

                              providerModelEdit!.cHANGERID =
                                  int.tryParse(widget.user.id!);

                              await providerProvider.editProvider(
                                  StaticData.urlProviderEdit,
                                  providerModelEdit!);
                              _controllerName.clear();
                              _controllerTaxNumber.clear();
                              _controllerAddress.clear();
                              Text message = Text(
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Color.fromARGB(255, 31, 124, 19)),
                                  getLanguage(context, 'messageEditSuccess'));
                              providerProvider.changeMessage(message);
                            } else {
                              Text message = Text(
                                getLanguage(
                                    context, 'messageEditFaildProvider'),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 201, 10, 10)),
                              );
                              providerProvider.changeMessage(message);
                            }
                          }
                        },
                        child: Text(getLanguage(context, 'edit')),
                      ),

                      //  List<ProviderModel> matches = await providerProvider
                      //       .getSearchedProviderDataCustom(StaticData
                      //               .urlProviderSearch +
                      //           '?column=${selectedProviderMapColumn!.column}&value=${textEditingValue.text}');

                      Visibility(
                        visible: providerModelEdit != null,
                        child: ElevatedButton(
                          onPressed: () async {
                            // List<TypeModel>? types = [];
                            // final SharedPreferences prefs =
                            //     await SharedPreferences.getInstance();

                            // String? decodeString =
                            //     await prefs.getString('types');
                            // if (decodeString != null) {
                            //   List<dynamic> deco = [decodeString];
                            //   types = deco
                            //       .map((json) => TypeModel.fromJson(json))
                            //       .toList();
                            // } else {}
                            if (providerModelEdit!.iD != null) {
                              DateTime? startDate;
                              DateTime? endDate;
                              TextEditingController _controllerAmmountPerTon =
                                  TextEditingController();
                              TextEditingController _controllerFromCity =
                                  TextEditingController();
                              TextEditingController _controllerToCity =
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
                                                        context, 'dateTo'),
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
                                                controller: _controllerFromCity,
                                                decoration: InputDecoration(
                                                  labelText: getLanguage(
                                                      context, 'fromCity'),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              TextField(
                                                controller: _controllerToCity,
                                                decoration: InputDecoration(
                                                  labelText: getLanguage(
                                                      context, 'toCity'),
                                                  enabledBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.green),
                                                  ),
                                                ),
                                              ),
                                              // TextField(
                                              //   controller: _controllerType,
                                              //   decoration: InputDecoration(
                                              //     labelText: getLanguage(
                                              //         context, 'type'),
                                              //     enabledBorder:
                                              //         OutlineInputBorder(
                                              //       borderSide: BorderSide(
                                              //           color: Colors.grey),
                                              //     ),
                                              //     focusedBorder:
                                              //         OutlineInputBorder(
                                              //       borderSide: BorderSide(
                                              //           color: Colors.green),
                                              //     ),
                                              //   ),
                                              // ),
                                              Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 20,
                                                        vertical: 20),
                                                width:
                                                    getSizePage(context, 1, 55),
                                                child: DropdownButtonFormField<
                                                    String>(
                                                  decoration: InputDecoration(
                                                    labelText: getLanguage(
                                                        context, 'type'),
                                                    enabledBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.grey),
                                                    ),
                                                    focusedBorder:
                                                        const OutlineInputBorder(
                                                      borderSide: BorderSide(
                                                          color: Colors.green),
                                                    ),
                                                  ),
                                                  value: _selectedType,
                                                  items: types
                                                      .map((TypeModel type) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: getLanguage(
                                                          context, type.name!),
                                                      child: Text(getLanguage(
                                                          context, type.name!)),
                                                    );
                                                  }).toList(),
                                                  onChanged: (String? value) {
                                                    setState(() {
                                                      _selectedType = value!;
                                                    });
                                                  },
                                                  validator: (value) {
                                                    if (value == null) {
                                                      return getLanguage(
                                                          context,
                                                          'vaildVehicleType');
                                                    }
                                                    return null;
                                                  },
                                                  onSaved: (value) {
                                                    _selectedType = value!;
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
                                                      const OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: Colors.grey),
                                                  ),
                                                  focusedBorder:
                                                      const OutlineInputBorder(
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
                                                  newProviderDetails.fROMCITY =
                                                      _controllerFromCity.text;
                                                  newProviderDetails.tOCITY =
                                                      _controllerToCity.text;
                                                  newProviderDetails.tYPE =
                                                      _selectedType;
                                                  if (newProviderDetails
                                                              .aMMOUNTPERTON !=
                                                          null &&
                                                      newProviderDetails.pROVIDERSID !=
                                                          null &&
                                                      newProviderDetails
                                                              .sTARTDATE !=
                                                          null &&
                                                      newProviderDetails.eNDDATE !=
                                                          null &&
                                                      newProviderDetails
                                                              .fROMCITY !=
                                                          null &&
                                                      newProviderDetails
                                                              .tOCITY !=
                                                          null &&
                                                      newProviderDetails.tYPE !=
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
                                                      // ignore: use_build_context_synchronously
                                                      getLanguage(context,
                                                          'messageSuccess'),
                                                      style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255,
                                                              31,
                                                              124,
                                                              19)),
                                                    );
                                                    final ProviderProvider
                                                        providerProvider =
                                                        Provider.of<
                                                                ProviderProvider>(
                                                            context,
                                                            listen: false);
                                                    providerProviderDetails
                                                        .changeMessage(message);
                                                    Navigator.of(context).pop();
                                                    message = Text(
                                                      getLanguage(context,
                                                          'messageSuccess'),
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 20,
                                                          color: Color.fromARGB(
                                                              255,
                                                              31,
                                                              124,
                                                              19)),
                                                    );
                                                    providerProvider
                                                        .changeMessage(message);

                                                    providerDetailsListForProvider =
                                                        await providerProviderDetails
                                                            .getSearchedProviderDetailsDataCustom(
                                                                StaticData
                                                                        .urlProviderDetailsSearch +
                                                                    '?column=START_DATE&value= &providerId=${newProviderDetails.pROVIDERSID}&type=%%');
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
                                      content: const Text("Must select Row "),
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
                  Consumer<ProviderProviderDetails>(
                      builder: (context, providerProviderDetails, child) {
                    return Visibility(
                      visible: providerProviderDetails
                              .searchedListRuseltBase.length >
                          0,
                      child: Container(
                        padding: const EdgeInsets.only(top: 20),
                        width: getSizePage(context, 1, 60),
                        height: getSizePage(context, 2, 30),
                        child: ListView.builder(
                          //shrinkWrap: true,
                          itemCount: providerProviderDetails
                              .searchedListRuseltBase.length,
                          itemBuilder: (context, index) {
                            ProviderDetails currentObject =
                                providerProviderDetails.searchedListRuseltBase
                                    .elementAt(index);
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
                                          child: Text(currentObject.tYPE!)),
                                      Expanded(
                                          flex: 2,
                                          child: Text(
                                              '${currentObject.aMMOUNTPERTON}')),
                                      Expanded(
                                          flex: 2,
                                          child: Text(currentObject.fROMCITY!)),
                                      Expanded(
                                          flex: 2,
                                          child:
                                              Text('${currentObject.tOCITY}')),
                                      Expanded(
                                          flex: 2,
                                          child: ElevatedButton(
                                            onPressed: () async {
                                              String messageString =
                                                  await providerProviderDetails
                                                      .deleteProviderDetailsDataCustom(
                                                          StaticData
                                                                  .urlProviderDetailsDelete +
                                                              "${currentObject.iD}");
                                              currentProvider =
                                                  currentObject.iD;
                                              await providerProviderDetails
                                                  .getSearchedProviderDetailsDataCustom(
                                                      StaticData
                                                              .urlProviderDetailsSearch +
                                                          '?column=START_DATE&value= &providerId=${currentProvider}&type=%%');
                                              final ProviderProvider
                                                  providerProvider =
                                                  Provider.of<ProviderProvider>(
                                                      context,
                                                      listen: false);
                                              if (messageString ==
                                                  "Provider detail deleted successfully") {
                                                Text message = Text(
                                                  getLanguage(
                                                      context, 'deleteSuccess'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 31, 124, 19)),
                                                );
                                                providerProvider
                                                    .changeMessage(message);
                                              } else {
                                                Text message = Text(
                                                  getLanguage(
                                                      context, 'deletefail'),
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 20,
                                                      color: Color.fromARGB(
                                                          255, 151, 23, 23)),
                                                );
                                                providerProvider
                                                    .changeMessage(message);
                                              }
                                            },
                                            child: Text(
                                                getLanguage(context, 'delete')),
                                          )),
                                    ],
                                  ))),
                            );
                          },
                        ),
                      ),
                    );
                  }),
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
