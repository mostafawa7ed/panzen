class SelectedData {
  int? transportationFeeId;
  String? driverName;
  String? driverAddress;
  int? providerDetailsAmountPerTon;
  String? providerDetailsStartDate;
  String? providerDetailsEndDate;
  String? providerName;
  String? providerAddress;
  int? providerAmountPerTon;
  String? changerUsername;
  String? changerAddress;
  int? totalValue;
  int? numberOfTon;
  String? requestDate;
  String? timeStamp;

  SelectedData(
      {this.transportationFeeId,
      this.driverName,
      this.driverAddress,
      this.providerDetailsAmountPerTon,
      this.providerDetailsStartDate,
      this.providerDetailsEndDate,
      this.providerName,
      this.providerAddress,
      this.providerAmountPerTon,
      this.changerUsername,
      this.changerAddress,
      this.totalValue,
      this.numberOfTon,
      this.requestDate,
      this.timeStamp});

  SelectedData.fromJson(Map<String, dynamic> json) {
    transportationFeeId = json['transportation_fee_id'];
    driverName = json['driver_name'];
    driverAddress = json['driver_address'];
    providerDetailsAmountPerTon = json['provider_details_amount_per_ton'];
    providerDetailsStartDate = json['provider_details_start_date'];
    providerDetailsEndDate = json['provider_details_end_date'];
    providerName = json['provider_name'];
    providerAddress = json['provider_address'];
    providerAmountPerTon = json['provider_amount_per_ton'];
    changerUsername = json['changer_username'];
    changerAddress = json['changer_address'];
    totalValue = json['total_value'];
    numberOfTon = json['number_of_ton'];
    requestDate = json['request_date'];
    timeStamp = json['time_stamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['transportation_fee_id'] = this.transportationFeeId;
    data['driver_name'] = this.driverName;
    data['driver_address'] = this.driverAddress;
    data['provider_details_amount_per_ton'] = this.providerDetailsAmountPerTon;
    data['provider_details_start_date'] = this.providerDetailsStartDate;
    data['provider_details_end_date'] = this.providerDetailsEndDate;
    data['provider_name'] = this.providerName;
    data['provider_address'] = this.providerAddress;
    data['provider_amount_per_ton'] = this.providerAmountPerTon;
    data['changer_username'] = this.changerUsername;
    data['changer_address'] = this.changerAddress;
    data['total_value'] = this.totalValue;
    data['number_of_ton'] = this.numberOfTon;
    data['request_date'] = this.requestDate;
    data['time_stamp'] = this.timeStamp;
    return data;
  }
}
