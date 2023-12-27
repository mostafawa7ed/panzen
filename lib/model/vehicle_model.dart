class Vehicle {
  int? iD;
  String? nAME;
  String? pLATENO;
  int? vEHICLETYPEID;
  int? cHANGERID;
  int? nUMBEROFTRANSACTIONS;
  String? cREATEDAT;

  Vehicle(
      {this.iD,
      this.nAME,
      this.pLATENO,
      this.vEHICLETYPEID,
      this.cHANGERID,
      this.nUMBEROFTRANSACTIONS,
      this.cREATEDAT});

  Vehicle.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    pLATENO = json['PLATE_NO'];
    vEHICLETYPEID = json['VEHICLE_TYPE_ID'];
    cHANGERID = json['CHANGER_ID'];
    nUMBEROFTRANSACTIONS = json['NUMBER_OF_TRANSACTIONS'];
    cREATEDAT = json['CREATED_AT'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['PLATE_NO'] = this.pLATENO;
    data['VEHICLE_TYPE_ID'] = this.vEHICLETYPEID;
    data['CHANGER_ID'] = this.cHANGERID;
    data['NUMBER_OF_TRANSACTIONS'] = this.nUMBEROFTRANSACTIONS;
    data['CREATED_AT'] = this.cREATEDAT;
    return data;
  }
}
