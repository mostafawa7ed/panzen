class TransportationFeeModel {
  String? providersDetailsId;
  String? providersReciverId;
  String? carsId;
  String? totalValue;
  String? numberOfTon;
  String? driversId;
  String? requestDate;
  String? changerId;
  String? type;

  TransportationFeeModel(
      {this.providersDetailsId,
      this.providersReciverId,
      this.carsId,
      this.totalValue,
      this.numberOfTon,
      this.requestDate,
      this.driversId,
      this.changerId,
      this.type});

  TransportationFeeModel.fromJson(Map<String, dynamic> json) {
    providersDetailsId = json['providersDetailsId'];
    providersReciverId = json['providersDetailsSendId'];
    carsId = json['carsId'];
    totalValue = json['totalValue'];
    numberOfTon = json['numberOfTon'];
    requestDate = json['requestDate'];
    changerId = json['changerId'];
    driversId = json['driversId'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['providersDetailsId'] = this.providersDetailsId;
    data['providersDetailsSendId'] = this.providersReciverId;
    data['carsId'] = this.carsId;
    data['totalValue'] = this.totalValue;
    data['numberOfTon'] = this.numberOfTon;
    data['requestDate'] = this.requestDate;
    data['changerId'] = this.changerId;
    data['driversId'] = this.driversId;
    data['type'] = this.type;
    return data;
  }
}
