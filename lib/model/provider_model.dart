class ProviderModel {
  int? iD;
  String? nAME;
  String? aDDRESS;
  int? aMMOUNTPERTON;
  int? cHANGERID;
  String? tIMESTAMP;

  ProviderModel(
      {this.iD,
      this.nAME,
      this.aDDRESS,
      this.aMMOUNTPERTON,
      this.cHANGERID,
      this.tIMESTAMP});

  ProviderModel.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    aDDRESS = json['ADDRESS'];
    aMMOUNTPERTON = json['AMMOUNT_PER_TON'];
    cHANGERID = json['CHANGER_ID'];
    tIMESTAMP = json['TIME_STAMP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = iD;
    data['NAME'] = nAME;
    data['ADDRESS'] = aDDRESS;
    data['AMMOUNT_PER_TON'] = aMMOUNTPERTON;
    data['CHANGER_ID'] = cHANGERID;
    data['TIME_STAMP'] = tIMESTAMP;
    return data;
  }
}
