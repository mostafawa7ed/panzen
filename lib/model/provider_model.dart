class ProviderModel {
  int? iD;
  String? nAME;
  String? aDDRESS;
//  double? aMMOUNTPERTON;
  int? cHANGERID;
  String? tIMESTAMP;
  String? tAXNUMBER;

  ProviderModel({
    this.iD,
    this.nAME,
    this.aDDRESS,
    //    this.aMMOUNTPERTON,
    this.cHANGERID,
    this.tIMESTAMP,
    this.tAXNUMBER,
  });

  ProviderModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    aDDRESS = json['ADDRESS'];
    // aMMOUNTPERTON = json['AMMOUNT_PER_TON'];
    cHANGERID = json['CHANGER_ID'];
    tIMESTAMP = json['TIME_STAMP'];
    tAXNUMBER = json['TAX_NUMBER'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['ADDRESS'] = aDDRESS;
    // data['AMMOUNT_PER_TON'] = aMMOUNTPERTON;
    data['CHANGER_ID'] = cHANGERID;
    data['TIME_STAMP'] = tIMESTAMP;
    data['TAX_NUMBER'] = tAXNUMBER;
    return data;
  }
}
