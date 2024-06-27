class Licenseplate{
  final int? licpId;
  final int? licpNum;
  final int? provinceId;

  Licenseplate({this.licpId,this.licpNum,this.provinceId});

  Map<String,dynamic> toMap(){
    return{
      'licpId':licpId,
      'licpNum':licpNum,
      'provinceId':provinceId
    };
  }
}

