import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../model/transportationfeeReportMode.dart';
import '../model/user_model.dart';

class TransportationFeeDataTable extends StatefulWidget {
  const TransportationFeeDataTable({
    Key? key,
    required this.language,
    required this.user,
    required this.transportationList,
  }) : super(key: key);

  final String language;
  final User user;
  final List<TransportaionfeeReport> transportationList;

  @override
  _TransportationFeeDataTableState createState() =>
      _TransportationFeeDataTableState();
}

class _TransportationFeeDataTableState
    extends State<TransportationFeeDataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: PaginatedDataTable(
            arrowHeadColor: Colors.grey,
            header: Text('Transportation Data Table'),
            rowsPerPage: _rowsPerPage,
            availableRowsPerPage: [5, 10],
            onRowsPerPageChanged: (int? value) {
              setState(() {
                _rowsPerPage = value ?? PaginatedDataTable.defaultRowsPerPage;
              });
            },
            sortColumnIndex: _sortColumnIndex,
            sortAscending: false,
            columnSpacing: 20,
            showCheckboxColumn: true,
            columns: [
              DataColumn(
                label: Text('ID'),
                onSort: (columnIndex, ascending) {
                  setState(() {
                    _sortColumnIndex = columnIndex;
                    _sortAscending = ascending;
                    // Implement your sorting logic here
                  });
                },
              ),
              DataColumn(
                  label: Text(
                'Driver Name',
                style: TextStyle(fontSize: 10),
              )),
              DataColumn(label: Text('Provider Name')),
              DataColumn(label: Text('Total Value')),
              DataColumn(label: Text('Driver Name')),
              DataColumn(label: Text('Provider Name')),
              DataColumn(label: Text('Total Value')),
              DataColumn(label: Text('Driver Name')),
              DataColumn(label: Text('Provider Name')),

              // Add more DataColumn widgets as needed
            ],
            source: _TransportationDataSource(
              transportationList: widget.transportationList,
              context: context,
            ),
          ),
        ),
      ),
    );
  }
}

class _TransportationDataSource extends DataTableSource {
  final List<TransportaionfeeReport> transportationList;
  final BuildContext context;

  _TransportationDataSource({
    required this.transportationList,
    required this.context,
  });

  @override
  DataRow? getRow(int index) {
    if (index >= transportationList.length) return null;
    final row = transportationList[index];
    return DataRow(
      onSelectChanged: (value) {
        print(value);
      },
      selected: true,
      cells: [
        DataCell(Text(row.transportationFeeId?.toString() ?? '')),
        DataCell(Text(row.driverName ?? '')),
        DataCell(Text(row.providerName ?? '')),
        DataCell(Text(row.totalValue?.toString() ?? '')),
        DataCell(Text(row.totalValue.toString())),
        DataCell(Text(row.providerDetailsAmountPerTon.toString())),
        DataCell(Text(row.requestDate.toString())),
        DataCell(Text(row.providerDetailsStartDate.toString())),
        DataCell(Text(row.providerDetailsEndDate.toString())),
        // Add more cells based on your requirements
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => transportationList.length;

  @override
  int get selectedRowCount => 0;
}
