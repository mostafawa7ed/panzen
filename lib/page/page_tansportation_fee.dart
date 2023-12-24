import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled4/cutomwidget/customTextFieldSearch.dart';
import 'package:untitled4/data/staticdata.dart';
import 'package:untitled4/model/transportation_fee_model.dart';

import '../controller/provider_transportation_fee.dart';

class TransportationFee extends StatefulWidget {
  const TransportationFee({super.key});

  @override
  State<TransportationFee> createState() => _TransportationFeeState();
}

class _TransportationFeeState extends State<TransportationFee> {
  TextEditingController carsId = new TextEditingController();
  TextEditingController changerId = new TextEditingController();
  TextEditingController numberOfTon = new TextEditingController();
  TextEditingController providersDetailsId = new TextEditingController();
  TextEditingController requestDate = new TextEditingController();
  TextEditingController totalValue = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    final providerTransportationFee =
        Provider.of<ProviderTransportationFee>(context);
    GlobalKey<AutoCompleteTextFieldState<String>> key =
        GlobalKey<AutoCompleteTextFieldState<String>>();
    String selected = '';
    List<String> suggestions = [
      "Apple",
      "Armidillo",
      "Actual",
      "Actuary",
      "America",
      "Argentina",
      "Australia",
      "Antarctica",
      "Blueberry",
      "Cheese",
      "Danish",
      "Eclair",
      "Fudge",
      "Granola",
      "Hazelnut",
      "Ice Cream",
      "Jely",
      "Kiwi Fruit",
      "Lamb",
      "Macadamia",
      "Nachos",
      "Oatmeal",
      "Palm Oil",
      "Quail",
      "Rabbit",
      "Salad",
      "T-Bone Steak",
      "Urid Dal",
      "Vanilla",
      "Waffles",
      "Yam",
      "Zest"
    ];
    return Column(
      children: [
        AutoCompleteTextField<String>(
          decoration: InputDecoration(
              hintText: "Search Resturant:", suffixIcon: Icon(Icons.search)),
          itemSubmitted: (item) => setState(() => selected = item),
          key: key,
          suggestions: suggestions,
          itemBuilder: (context, suggestion) => Padding(
              child: ListTile(
                  title: Text(suggestion),
                  trailing: Text("Stars: ${suggestion}")),
              padding: EdgeInsets.all(8.0)),
          itemSorter: (a, b) => a == b ? 1 : 0,
          itemFilter: (suggestion, input) =>
              suggestion.toLowerCase().startsWith(input.toLowerCase()),
        ),
        CustomTextFieldSearch(
          ///asdsadsjdgs
          controllerCaseNumber: carsId,
          labelText: "carsId",
        ),
        CustomTextFieldSearch(
          controllerCaseNumber: changerId,
          labelText: "changerId",
        ),
        CustomTextFieldSearch(
          controllerCaseNumber: numberOfTon,
          labelText: "numberOfTon",
        ),
        CustomTextFieldSearch(
          controllerCaseNumber: providersDetailsId,
          labelText: "providersDetailsId",
        ),
        CustomTextFieldSearch(
          controllerCaseNumber: requestDate,
          labelText: "requestDate",
        ),
        CustomTextFieldSearch(
          controllerCaseNumber: totalValue,
          labelText: "totalValue",
        ),
        ElevatedButton(
            onPressed: () async {
              TransportationFeeModel transportationFeeModel =
                  TransportationFeeModel();
              transportationFeeModel.carsId =
                  int.tryParse(carsId.text.toString()) ?? 1;
              transportationFeeModel.changerId =
                  int.tryParse(changerId.text.toString()) ?? 1;
              transportationFeeModel.numberOfTon =
                  int.tryParse(numberOfTon.text.toString()) ?? 1;
              transportationFeeModel.providersDetailsId =
                  int.tryParse(providersDetailsId.text.toString()) ?? 1;
              transportationFeeModel.requestDate = carsId.text.toString();
              transportationFeeModel.totalValue =
                  int.tryParse(totalValue.text.toString()) ?? 1;
              await providerTransportationFee.addTransporationFee(
                  StaticData.urltransportationFeeAdd, transportationFeeModel);
            },
            child: Text("أضافة")),
      ],
    );
  }
}
