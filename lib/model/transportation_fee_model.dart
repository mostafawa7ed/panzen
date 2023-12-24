class TransportationFeeModel {
  int? providersDetailsId;
  int? carsId;
  int? totalValue;
  int? numberOfTon;
  int? driversId;
  String? requestDate;
  int? changerId;

  TransportationFeeModel(
      {this.providersDetailsId,
      this.carsId,
      this.totalValue,
      this.numberOfTon,
      this.requestDate,
      this.driversId,
      this.changerId});

  TransportationFeeModel.fromJson(Map<String, dynamic> json) {
    providersDetailsId = json['providersDetailsId'];
    carsId = json['carsId'];
    totalValue = json['totalValue'];
    numberOfTon = json['numberOfTon'];
    requestDate = json['requestDate'];
    changerId = json['changerId'];
    driversId = json['driversId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providersDetailsId'] = this.providersDetailsId;
    data['carsId'] = this.carsId;
    data['totalValue'] = this.totalValue;
    data['numberOfTon'] = this.numberOfTon;
    data['requestDate'] = this.requestDate;
    data['changerId'] = this.changerId;
    data['driversId'] = this.driversId;
    return data;
  }
}
