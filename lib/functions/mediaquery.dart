import 'package:flutter/material.dart';

double getSizePage(BuildContext context, int dimestion, int precentage) {
  try {
    double size;

    if (dimestion == 1) //width
    {
      size = (MediaQuery.of(context).size.width * precentage) / 100;
      return size;
    } else if (dimestion == 2) //hieght
    {
      size = (MediaQuery.of(context).size.height * precentage) / 100;
      return size;
    }
  } catch (e) {
    return 1.0;
  }
  return 1.0;
}
