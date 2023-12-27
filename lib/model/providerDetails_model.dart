class ProviderDetails {
  int? iD;
  int? pROVIDERSID;
  String? sTARTDATE;
  String? eNDDATE;
  int? aMMOUNTPERTON;
  int? cHANGERID;
  String? tIMESTAMP;

  ProviderDetails(
      {this.iD,
      this.pROVIDERSID,
      this.sTARTDATE,
      this.eNDDATE,
      this.aMMOUNTPERTON,
      this.cHANGERID,
      this.tIMESTAMP});

  ProviderDetails.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    pROVIDERSID = json['PROVIDERS_ID'];
    sTARTDATE = json['START_DATE'];
    eNDDATE = json['END_DATE'];
    aMMOUNTPERTON = json['AMMOUNT_PER_TON'];
    cHANGERID = json['CHANGER_ID'];
    tIMESTAMP = json['TIME_STAMP'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['PROVIDERS_ID'] = this.pROVIDERSID;
    data['START_DATE'] = this.sTARTDATE;
    data['END_DATE'] = this.eNDDATE;
    data['AMMOUNT_PER_TON'] = this.aMMOUNTPERTON;
    data['CHANGER_ID'] = this.cHANGERID;
    data['TIME_STAMP'] = this.tIMESTAMP;
    return data;
  }
}
