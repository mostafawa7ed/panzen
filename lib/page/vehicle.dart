import 'dart:io';
import 'package:flutter/services.dart';
import 'package:untitled4/model/user_model.dart';
import 'package:untitled4/model/vehicle_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/controller/provider_transportation_fee.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:path_provider/path_provider.dart';

import 'package:untitled4/data/staticdata.dart';
import 'package:open_file/open_file.dart';

import '../data/langaue.dart';

class VehicleTab extends StatefulWidget {
  const VehicleTab({super.key, required this.user});
  final User user;
  @override
  State<VehicleTab> createState() => _VehicleTabState();
}

class _VehicleTabState extends State<VehicleTab> {
  Vehicle selectedVehicle = Vehicle();
  String selected = '';

  // Future<void> prepareData(BuildContext context) async {
  //   final ProviderTransportationFee providerTransportationFee =
  //       Provider.of<ProviderTransportationFee>(context, listen: false);
  //   await providerTransportationFee
  //       .vehiclePrepareList(StaticData.urlGetAllVehicle);
  //   await providerTransportationFee
  //       .providerPrepareList(StaticData.urlGetAllProviders);
  //   await providerTransportationFee
  //       .driverPrepareList(StaticData.urlGetAllDriver);
  // }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: AlwaysScrollableScrollPhysics(),
      child: Column(
        children: [
          ElevatedButton(
              onPressed: () async {},
              child: Text(getLanguage(context, 'addTransportation'))),
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