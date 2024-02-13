class ProviderDetails {
  int? iD;
  int? pROVIDERSID;
  String? sTARTDATE;
  String? eNDDATE;
  double? aMMOUNTPERTON;
  int? cHANGERID;
  String? tIMESTAMP;
  String? fROMCITY;
  String? tOCITY;
  String? tYPE;

  ProviderDetails({
    this.iD,
    this.pROVIDERSID,
    this.sTARTDATE,
    this.eNDDATE,
    this.aMMOUNTPERTON,
    this.cHANGERID,
    this.tIMESTAMP,
    this.fROMCITY,
    this.tOCITY,
    this.tYPE,
  });

  ProviderDetails.fromJson(Map<String, dynamic> json) {
    iD = int.tryParse(json['ID'].toString());
    pROVIDERSID = int.tryParse(json['PROVIDERS_ID'].toString());
    sTARTDATE = json['START_DATE'];
    eNDDATE = json['END_DATE'];

    // Parse AMMOUNT_PER_TON as a double or set it to null if not present
    aMMOUNTPERTON = json['AMMOUNT_PER_TON'] != null
        ? (json['AMMOUNT_PER_TON'] is int
            ? (json['AMMOUNT_PER_TON'] as int).toDouble()
            : json['AMMOUNT_PER_TON'])
        : null;

    cHANGERID = int.tryParse(json['CHANGER_ID'].toString());
    tIMESTAMP = json['TIME_STAMP'];
    fROMCITY = json['FROM_CITY'];
    tOCITY = json['TO_CITY'];
    tYPE = json['TYPE'];
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
    data['FROM_CITY'] = this.fROMCITY;
    data['TO_CITY'] = this.tOCITY;
    data['TYPE'] = this.tYPE;
    return data;
  }
}
