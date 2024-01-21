import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../controller/provider_report.dart';
import '../data/langaue.dart';
import '../data/staticdata.dart';
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
        {'from': 1, 'to': 10, 'limit': 10});
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
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'providerSender')),
                    ),
                    Expanded(
                      flex: 3,
                      child: Text(
                          style: customTextStyle,
                          getLanguage(context, 'providerReceiver')),
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
                          getLanguage(context, 'amount')),
                    ),
                    // Expanded(
                    //     flex: 3,
                    //     child: Text(
                    //         style: customTextStyle,
                    //         getLanguage(context, 'providerDeDateEnd'))),
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
                      onPressed: providerReportData.currentPage !=
                              providerReportData.totalPages
                          ? () async {
                              int start = 0;
                              int end = 0;
                              start = providerReportData.totalCount % 10;
                              if (start == 0) {
                                start = providerReportData.totalCount - 10 + 1;
                              } else {
                                start =
                                    (providerReportData.totalPages - 1) * 10 +
                                        providerReportData.totalCount % 10 +
                                        1;
                              }
                              end = start + 9;

                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
                                'from': start, //'$start',
                                'to': end //'$end',
                              });
                              print(providerReportData.totalCount);
                              // Add your onPressed logic here
                            }
                          : null,
                      icon: const Icon(Icons.keyboard_double_arrow_right)),
                  IconButton(
                      onPressed: providerReportData.currentPage !=
                              providerReportData.totalPages
                          ? () async {
                              int start =
                                  providerReportData.currentPage * 10 + 1;
                              int end = start + 9;

                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
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
                      child: Text(providerReportData.currentPage.toString())),
                  IconButton(
                      onPressed: providerReportData.currentPage != 1
                          ? () async {
                              int start = 0;
                              int end = 0;
                              start = providerReportData.totalPages * 10 - 10;
                              end = start + 9;
                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
                                'from': start, //'$start',
                                'to': end //'$end',
                              });
                              print(providerReportData.totalCount);
                              // Add your onPressed logic here
                            }
                          : null,
                      icon: const Icon(Icons.arrow_forward)),
                  IconButton(
                      onPressed: providerReportData.currentPage != 1
                          ? () async {
                              int start = 0;
                              int end = 0;
                              start = 1;
                              end = start + 9;
                              await providerReportData.transportaionfeeList(
                                  StaticData.urlTransportationDatapagination, {
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
class CustomRowWidget extends StatelessWidget {
  final TransportaionfeeReport transportaionfeeReport;
  final int currentIndex;
  CustomRowWidget(
      {required this.transportaionfeeReport, required this.currentIndex});
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
    String? startDate = getDateCasting(
        DateTime.parse(transportaionfeeReport.providerDetailsStartDate!));
    if (transportaionfeeReport.providerDetailsEndDate != null) {
      endDate = getDateCasting(
          DateTime.parse(transportaionfeeReport.providerDetailsEndDate!));
    } else {
      endDate = "";
    }
    String? daterequest;
    if (transportaionfeeReport.requestDate != null) {
      daterequest =
          getDateCasting(DateTime.parse(transportaionfeeReport.requestDate!));
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
                child: Text(style: customTextStyle, currentIndex.toString()),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.transportationFeeId.toString()),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.type.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.providerName.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.providerReceiverName.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.driverName.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.numberOfTon.toString()),
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
                    transportaionfeeReport.totalValue.toString()),
              ),
              Expanded(
                flex: 3,
                child: Text(
                    style: customTextStyle,
                    transportaionfeeReport.providerDetailsAmountPerTon
                        .toString()),
              ),
              // Expanded(
              //   flex: 3,
              //   child: ElevatedButton(
              //     onPressed: () {},
              //     child: const Text("Action"),
              //   ),
              // ),
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
