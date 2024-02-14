import 'dart:io';
import 'dart:typed_data';
import 'package:open_file/open_file.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_report.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/model/transportationfeeReportMode.dart';

import '../controller/provider_provider.dart';
import '../data/langaue.dart';
import '../functions/mediaquery.dart';
import '../model/provider_model.dart';
import '../model/vehicle_model.dart';

class ReportTap extends StatefulWidget {
  const ReportTap({super.key});

  @override
  State<ReportTap> createState() => _ReportTapState();
}

class _ReportTapState extends State<ReportTap> {
  DateTime? fromDate;
  DateTime? toDate;
  ProviderMap? selectedProviderMapColumn;
  List<ProviderMap> providerColumnsItems = [
    ProviderMap("Name", "NAME"),
    ProviderMap("Address", "ADDRESS"),
  ];
  ProviderModel selectedProviderMOdel = ProviderModel();
  Vehicle selectedVehicle = Vehicle();
  TextEditingController _providerController = TextEditingController();
  final formate = DateFormat('yyyy-MM-dd-HH-mm');
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            getLanguage(context, 'reportTransportationFee')),
        Row(
          children: [
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
                Padding(padding: EdgeInsets.only(right: 27)),
                Consumer<ProviderProvider>(
                    builder: (context, providerProvider, child) {
                  return Container(
                    width: getSizePage(context, 1, 60),
                    child: Autocomplete<ProviderModel>(
                      optionsBuilder:
                          (TextEditingValue textEditingValue) async {
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
                        //   print('You just selected ${selectedVehicle.nAME}');
                      },
                      fieldViewBuilder: (BuildContext context,
                          TextEditingController textEditingController,
                          FocusNode focusNode,
                          VoidCallback onFieldSubmitted) {
                        _providerController = textEditingController;
                        //_providerFieldFocus = focusNode; // Store the controller
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
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DateTimeFormField(
                      style: const TextStyle(
                        color: Colors.black,
                        decorationStyle: TextDecorationStyle.solid,
                      ),
                      dateFormat: formate,
                      decoration: InputDecoration(
                        labelText: getLanguage(context, 'dateFrom'),
                      ),
                      firstDate:
                          DateTime.now().add(const Duration(days: -222222)),
                      lastDate:
                          DateTime.now().add(const Duration(days: 222222)),
                      initialPickerDateTime: DateTime.now(),
                      onChanged: (DateTime? value) {
                        fromDate = value;
                        //selectedDate = value;
                      },
                    ),
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: DateTimeFormField(
                  //     style: const TextStyle(
                  //       color: Colors.black,
                  //       decorationStyle: TextDecorationStyle.solid,
                  //     ),
                  //     dateFormat: formate,
                  //     decoration: InputDecoration(
                  //       labelText: getLanguage(context, 'dateTo'),
                  //     ),
                  //     firstDate:
                  //         DateTime.now().add(const Duration(days: -222222)),
                  //     lastDate:
                  //         DateTime.now().add(const Duration(days: 222222)),
                  //     initialPickerDateTime: DateTime.now(),
                  //     onChanged: (DateTime? value) {
                  //       toDate = value;
                  //       //selectedDate = value;
                  //     },
                  //   ),
                  // ),
                ],
              ),
            ),
            Expanded(
                child: ElevatedButton(
                    onPressed: () async {
                      if (fromDate != null) {
                        final ProviderReportData providerReportData =
                            Provider.of<ProviderReportData>(context,
                                listen: false);
                        if (toDate == null) {
                          toDate = DateTime.now();
                        }
                        await providerReportData
                            .transportaionfeeReportPrepareList(
                                StaticData.urlGetTransportationFeeReport,
                                fromDate!,
                                toDate!,
                                selectedProviderMOdel.iD!);
                        File pdfFile = await generatePDF(
                            providerReportData.transportaionfeeReportList,
                            fromDate!,
                            toDate!,
                            context);
                      } else {
                        print("enter date");
                      }
                    },
                    child: Text(getLanguage(context, 'displayReport'))))
          ],
        ),
      ],
    );
  }
}

Future<File> generatePDF(List<TransportaionfeeReport> data, DateTime fromDate,
    DateTime toDate, BuildContext mycontext) async {
  Locale currentLocal = Localizations.localeOf(mycontext);
  final pdf = pw.Document();
  late pw.Font arFont;
  String fromDate1 = DateFormat('yyyy-MM-dd').format(fromDate);
  String todate1 = DateFormat('yyyy-MM-dd').format(toDate);

  // Load the Arabic font
  ByteData fontData =
      await rootBundle.load("assets/fonts/static/Cairo-Bold.ttf");
  arFont = pw.Font.ttf(fontData.buffer.asByteData());

  List<List<String>> tableData = currentLocal == const Locale('ar')
      ? [
          [
            'رقم العملية',
            'تاريخ الشحن',
            'عدد الاطنان',
            'سعر الكمية كاملة',
            'سعر الطن',
            //'رقم العربية',
            'السائق',
            'الشركة المستلمة',
            'الشركة المسلمة',
            'الجهة من والي',
            'النوع',
            '  س  ',
          ] // Arabic column headers
        ]
      : [
          [
            '  S  ',
            'type',
            'from to',
            'provider',
            'Company Receiver',
            'Driver',
            //'Car Number',
            'value for one Ton',
            'Cal Total Value',
            'Number Of Ton',
            'Date Request',
            'Number of Transportation'
          ]
        ];
  int index = 1;
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');
  double quantity = 0.0;
  currentLocal == const Locale('ar')
      ? data.forEach((object) {
          DateTime daterequest = DateTime.parse(object.requestDate!);
          final String formatted = formatter.format(daterequest);
          quantity = quantity + object.numberOfTon!;
          tableData.add([
            object.transportationFeeId.toString(),
            formatted,
            object.providerDetailsAmountPerTon.toString(),
            object.totalValue.toString(),
            //object.providerAmountPerTon.toString(),
            object.numberOfTon.toString(),
            object.driverName.toString(),
            object.providerReceiverName.toString(),
            object.providerName.toString(),
            object.fromCity.toString() + '/' + object.toCity.toString(),
            object.type.toString(),
            index.toString(),
          ]);
          index = index + 1;
        })
      : data.forEach((object) {
          DateTime daterequest = DateTime.parse(object.requestDate!);
          final String formatted = formatter.format(daterequest);
          quantity = quantity + object.numberOfTon!;
          tableData.add([
            index.toString(),
            object.type.toString(),
            object.fromCity.toString() + '/' + object.toCity.toString(),
            object.providerName.toString(),
            object.providerReceiverName.toString(),
            object.driverName.toString(),
            object.numberOfTon.toString(),
            //object.providerAmountPerTon.toString(),
            object.totalValue.toString(),
            object.providerDetailsAmountPerTon.toString(),
            formatted,
            object.transportationFeeId.toString()
          ]);
          index = index + 1;
        });

  final List<dynamic> dividedData = [];
  for (var i = 0; i < tableData.length; i += 20) {
    dividedData.add(tableData.sublist(
        i, i + 20 > tableData.length ? tableData.length : i + 20));
  }

  for (var i = 0; i < dividedData.length; i++) {
    final pdfTable = pw.TableHelper.fromTextArray(
      data: dividedData[i],
      headerCount: 1,
      headerAlignment: pw.Alignment.center,
      cellAlignment: pw.Alignment.center,
      border: pw.TableBorder.all(width: 1),
      headerStyle: pw.TextStyle(
          fontSize: 7, font: arFont, fontWeight: pw.FontWeight.bold),
      cellStyle: pw.TextStyle(fontSize: 7, font: arFont),
      tableDirection: pw.TextDirection.rtl,
    );
    int page = 0;
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        build: (pw.Context context) {
          page = page + 1;
          return pw.Column(
            children: [
              if (i == 0)
                pw.Column(children: [
                  pw.Text(
                      textAlign: pw.TextAlign.left,
                      ' ${getLanguage(mycontext, "companyName")}',
                      style: pw.TextStyle(font: arFont, fontSize: 5)),
                  pw.Text(
                      textAlign: pw.TextAlign.left,
                      ' ${getLanguage(mycontext, "DMG")}',
                      style: pw.TextStyle(font: arFont, fontSize: 5)),
                  pw.Text(
                      textAlign: pw.TextAlign.left,
                      ' ${getLanguage(mycontext, "dahpmashor")}',
                      style: pw.TextStyle(font: arFont, fontSize: 5)),
                  pw.Text(
                      textAlign: pw.TextAlign.left,
                      ' ${getLanguage(mycontext, "companyNokeName")}',
                      style: pw.TextStyle(font: arFont, fontSize: 5)),
                  pw.Text(
                      textAlign: pw.TextAlign.center,
                      ' ${getLanguage(mycontext, "allDataFromdate")} $fromDate1 ${getLanguage(mycontext, 'toDate')} $todate1',
                      style: pw.TextStyle(font: arFont, fontSize: 8))
                ]),
              pw.SizedBox(height: 20),
              pdfTable,
              if (dividedData.length == page)
                pw.Text(
                    style: pw.TextStyle(font: arFont, fontSize: 8),
                    '${getLanguage(mycontext, "total")}            $quantity'),
            ],
          );
        },
      ),
    );
  }
  final output = await getTemporaryDirectory();
  final file = File('${output.path}/transportationfee.pdf');
  await file.writeAsBytes(await pdf.save());
  OpenFile.open('${output.path}/transportationfee.pdf');
  return file;
}

class ProviderMap {
  String? nameEnglish;
  String? column;

  ProviderMap(this.nameEnglish, this.column);
}
// File pdfFile =
//                     await generatePDF(providerTransportationFee.vehicleList);