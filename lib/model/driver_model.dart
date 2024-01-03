class DriverModel {
  int? iDD;
  String? nAMED;
  String? aDDRESSD;
  String? fIRSTNAMED;
  String? sECONDNAMED;
  int? cHANGERIDD;
  String? tIMESTAMPD;

  DriverModel(
      {this.iDD,
      this.nAMED,
      this.aDDRESSD,
      this.fIRSTNAMED,
      this.sECONDNAMED,
      this.cHANGERIDD,
      this.tIMESTAMPD});

  DriverModel.fromJson(Map<String, dynamic> json) {
    iDD = json['ID'];
    nAMED = json['NAME'];
    aDDRESSD = json['ADDRESS'];
    fIRSTNAMED = json['FIRST_NAME'];
    sECONDNAMED = json['SECOND_NAME'];
    cHANGERIDD = json['CHANGER_ID'];
    tIMESTAMPD = json['TIME_STAMP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iDD;
    data['NAME'] = this.nAMED;
    data['ADDRESS'] = this.aDDRESSD;
    data['FIRST_NAME'] = this.fIRSTNAMED;
    data['SECOND_NAME'] = this.sECONDNAMED;
    data['CHANGER_ID'] = this.cHANGERIDD;
    data['TIME_STAMP'] = this.tIMESTAMPD;
    return data;
  }
}
