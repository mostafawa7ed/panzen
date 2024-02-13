import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../api/CRUD.dart';
import '../controller/provider_report.dart';
import '../data/langaue.dart';
import '../data/staticdata.dart';
import '../functions/mediaquery.dart';
import '../model/transportationfeeReportMode.dart';
import '../model/user_model.dart';

class TransportationFeeDataTable extends StatefulWidget {
  const TransportationFeeDataTable({
    Key? key,
    required this.language,
    required this.user,
  }) : super(key: key);

  final String language;
  final User user;

  @override
  _TransportationFeeDataTableState createState() =>
      _TransportationFeeDataTableState();
}

class _TransportationFeeDataTableState
    extends State<TransportationFeeDataTable> {
  List<TransportaionfeeReport> transportationList = [];
  Future<void> preparePaginationInit() async {
    final ProviderReportData providerReportData =
        Provider.of<ProviderReportData>(context, listen: false);
    await providerReportData.transportaionfeeList(
        StaticData.urlTransportationDatapagination,
        {'name': '', 'from': 1, 'to': 10, 'limit': 10});
  }

  @override
  void initState() {
    preparePaginationInit();
    super.initState();
  }

  // int total = 0;
  final TextStyle customTextStyle = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    // You can add more styles as needed
  );
  final ScrollController _scrollController = ScrollController();
  TextEditingController _controllerSearch = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      thickness: 20, // Thickness of the scrollbar

      thumbVisibility: true,

      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Container(
              width: getSizePage(context, 1, 60),
              child: TextField(
                controller: _controllerSearch,
                decoration: InputDecoration(
                  labelText: getLanguage(context, 'searchByProvider'),
                  labelStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  suffix: Icon(
                    size: 30,
                    Icons.search,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                onChanged: (value) async {
                  final ProviderReportData providerReportData =
                      Provider.of<ProviderReportData>(context, listen: false);
                  await providerReportData.transportaionfeeList(
                    StaticData.urlTransportationDatapagination,
                    {'name': value, 'from': 1, 'to': 10, 'limit': 10},
                  );
                  providerReportData.currentStart = 1;
                  providerReportData.currentEnd = 10;
                },
              ),
            ),
            Card(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.8),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                          style: customTextStyle, getLanguage(context, 's')),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                          style: customTextStyle, getLanguage(context, 'id')),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                          style: customTextStyle, getLanguage(context, 'type')),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'fromTo')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'sender')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'receiver')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'driverName')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'numberOfTon')),
                    ),
                    // Expanded(
                    //   flex: 3,
                    //   child: Text(
                    //       style: customTextStyle,
                    //       getLanguage(context, 'providerDeDateStart')),
                    // ),
                    // Expanded(
                    //   flex: 3,
                    //   child: Text(
                    //       style: customTextStyle,
                    //       getLanguage(context, 'providerDeDateEnd')),
                    // ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'requestDate')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'totalAmount')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'priceTon')),
                    ),
                    Expanded(
                        flex: 3,
                        child: Text(
                            style: customTextStyle,
                            getLanguage(context, 'delete'))),
                  ],
                ),
              ),
            ),
            Consumer<ProviderReportData>(
                builder: (context, providerReportData, child) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: providerReportData.transportaionfeeallList.length,
                itemBuilder: (context, index) {
                  //  total = total +
                  providerReportData.transportaionfeeallList[index].totalValue!;
                  return CustomRowWidget(
                    transportaionfeeReport:
                        providerReportData.transportaionfeeallList[index],
                    currentIndex: index + 1,
                  );
                },
              );
            }),
            Consumer<ProviderReportData>(
                builder: (context, providerReportData, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: (providerReportData.currentStart + 10 <=
                              providerReportData.totalCount)
                          ? () async {
                              int start = (((providerReportData.totalCount / 10)
                                          .floor()) *
                                      10 +
                                  1);
                              int end = (((providerReportData.totalCount / 10)
                                          .floor()) *
                                      10 +
                                  10);

                              providerReportData.currentStart = start;
                              providerReportData.currentEnd = end;
                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
                                'name': _controllerSearch.text,
                                'from': start, //'$start',
                                'to': end //'$end',
                              });
                              print(providerReportData.totalCount);
                              // Add your onPressed logic here
                            }
                          : null,
                      icon: const Icon(Icons.keyboard_double_arrow_right)),
                  IconButton(
                      onPressed: providerReportData.currentStart + 10 <=
                              providerReportData.totalCount
                          ? () async {
                              int start = providerReportData.currentStart + 10;
                              int end = providerReportData.currentEnd + 10;
                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
                                'name': _controllerSearch.text,
                                'from': start, //'$start',
                                'to': end //'$end',
                              });
                              print(providerReportData.totalCount);
                              // Add your onPressed logic here
                            }
                          : null,
                      icon: const Icon(Icons.arrow_back)),
                  TextButton(
                      onPressed: () {},
                      child: Text((providerReportData.currentStart / 10)
                          .ceil()
                          .toString())),
                  IconButton(
                      onPressed: providerReportData.currentStart != 1
                          ? () async {
                              int start = providerReportData.currentStart - 10;
                              int end = providerReportData.currentEnd - 10;
                              providerReportData.currentStart = start;
                              providerReportData.currentStart = end;
                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
                                'name': _controllerSearch.text,
                                'from': start, //'$start',
                                'to': end //'$end',
                              });
                              print(providerReportData.totalCount);
                              // Add your onPressed logic here
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward)),
                  IconButton(
                      onPressed: providerReportData.currentStart != 1
                          ? () async {
                              int start = 1;
                              int end = 10;
                              providerReportData.currentStart = start;
                              providerReportData.currentEnd = end;
                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
                                'name': _controllerSearch.text,
                                'from': start, //'$start',
                                'to': end //'$end',
                              });
                              print(providerReportData.totalCount);
                              // Add your onPressed logic here
                            }
                          : null,
                      icon: const Icon(Icons.keyboard_double_arrow_left)),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class CustomRowWidget extends StatefulWidget {
  final TransportaionfeeReport transportaionfeeReport;
  final int currentIndex;

  CustomRowWidget(
      {required this.transportaionfeeReport, required this.currentIndex});

  @override
  _CustomRowWidgetState createState() => _CustomRowWidgetState();
}

class _CustomRowWidgetState extends State<CustomRowWidget> {
  final TextStyle customTextStyle = const TextStyle(
    color: Color.fromARGB(255, 0, 0, 0),
    fontSize: 16.0,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
    // You can add more styles as needed
  );
  DateFormat formatter = DateFormat('yyyy-MM-dd HH:mm:ss');

  @override
  Widget build(BuildContext context) {
    String? endDate;
    String? startDate = getDateCasting(DateTime.parse(
        widget.transportaionfeeReport.providerDetailsStartDate!));
    if (widget.transportaionfeeReport.providerDetailsEndDate != null) {
      endDate = getDateCasting(DateTime.parse(
          widget.transportaionfeeReport.providerDetailsEndDate!));
    } else {
      endDate = "";
    }
    String? daterequest;
    if (widget.transportaionfeeReport.requestDate != null) {
      daterequest = getDateCasting(
          DateTime.parse(widget.transportaionfeeReport.requestDate!));
    } else {
      daterequest = "";
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: Text(
                    style: customTextStyle, widget.currentIndex.toString()),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.transportationFeeId
                        .toString()),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.type.toString()),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.fromCity.toString() +
                        ' / ' +
                        widget.transportaionfeeReport.toCity.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.providerName.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.providerReceiverName
                        .toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.driverName.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.numberOfTon.toString()),
              ),
              // Expanded(
              //   flex: 3,
              //   child: Text(style: customTextStyle, startDate.toString()),
              // ),
              // Expanded(
              //   flex: 3,
              //   child: Text(style: customTextStyle, endDate!),
              // ),
              Expanded(
                flex: 3,
                child: Text(style: customTextStyle, daterequest!),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.totalValue.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    widget.transportaionfeeReport.providerDetailsAmountPerTon
                        .toString()),
              ),
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: () async {
                    AwesomeDialog(
                      context: context,
                      dialogType: DialogType.warning,
                      headerAnimationLoop: false,
                      animType: AnimType.scale,
                      title: getLanguage(context, 'deleteAlter'),
                      desc: getLanguage(context, 'messageDelete'),
                      btnOkText: getLanguage(context, 'delete'),
                      btnOkOnPress: () async {
                        Crud crud = Crud();
                        String url = StaticData.urlTransportationFeeDelete +
                            "${widget.transportaionfeeReport.transportationFeeId}";
                        await crud.deleteRequest(url).then((response) async {
                          final ProviderReportData providerReportData =
                              Provider.of<ProviderReportData>(context,
                                  listen: false);
                          await providerReportData.transportaionfeeList(
                              StaticData.urlTransportationDatapagination,
                              {'name': '', 'from': 1, 'to': 10, 'limit': 10});
                          providerReportData.currentStart = 1;
                          providerReportData.currentEnd = 10;
                          print(response);
                        });
                      },
                      btnCancelOnPress: () {},
                      btnCancelText: getLanguage(context, 'cancel'),
                      btnOkIcon: Icons.check_circle,
                    ).show();
                  },
                  child: Text(getLanguage(context, 'delete')),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String? getDateCasting(DateTime? date) {
  String formattedDateTime = '${date!.year}-${(date.month)}-${(date.day)} \n'
      '${(date.hour)}:${(date.minute)}:${(date.second)}';
  return formattedDateTime;
}
