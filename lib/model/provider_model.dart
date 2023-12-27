class Provider {
  int? iD;
  String? nAME;
  String? aDDRESS;
  int? aMMOUNTPERTON;
  int? cHANGERID;
  String? tIMESTAMP;

  Provider(
      {this.iD,
      this.nAME,
      this.aDDRESS,
      this.aMMOUNTPERTON,
      this.cHANGERID,
      this.tIMESTAMP});

  Provider.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    aDDRESS = json['ADDRESS'];
    aMMOUNTPERTON = json['AMMOUNT_PER_TON'];
    cHANGERID = json['CHANGER_ID'];
    tIMESTAMP = json['TIME_STAMP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['ADDRESS'] = this.aDDRESS;
    data['AMMOUNT_PER_TON'] = this.aMMOUNTPERTON;
    data['CHANGER_ID'] = this.cHANGERID;
    data['TIME_STAMP'] = this.tIMESTAMP;
    return data;
  }
}
