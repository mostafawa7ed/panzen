class Driver {
  int? iD;
  String? nAME;
  String? aDDRESS;
  String? fIRSTNAME;
  String? sECONDNAME;
  int? cHANGERID;
  String? tIMESTAMP;

  Driver(
      {this.iD,
      this.nAME,
      this.aDDRESS,
      this.fIRSTNAME,
      this.sECONDNAME,
      this.cHANGERID,
      this.tIMESTAMP});

  Driver.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    nAME = json['NAME'];
    aDDRESS = json['ADDRESS'];
    fIRSTNAME = json['FIRST_NAME'];
    sECONDNAME = json['SECOND_NAME'];
    cHANGERID = json['CHANGER_ID'];
    tIMESTAMP = json['TIME_STAMP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['NAME'] = this.nAME;
    data['ADDRESS'] = this.aDDRESS;
    data['FIRST_NAME'] = this.fIRSTNAME;
    data['SECOND_NAME'] = this.sECONDNAME;
    data['CHANGER_ID'] = this.cHANGERID;
    data['TIME_STAMP'] = this.tIMESTAMP;
    return data;
  }
}
