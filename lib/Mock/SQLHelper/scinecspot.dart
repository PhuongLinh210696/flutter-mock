class ScinecSpot{
  final int? ssId;
  final String? ssName;
  final int? provinceId;

  ScinecSpot({this.ssId,this.ssName,this.provinceId});

  Map<String,dynamic> toMap(){
    return{
      'ssId':ssId,
      'ssName':ssName,
      'provinceId':provinceId
    };
  }
}