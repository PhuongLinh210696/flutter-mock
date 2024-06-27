class City{
  final int? cityId;
  final String? cityName;
  final int? provinceId;

  City({this.cityId,this.cityName,this.provinceId});

  Map<String,dynamic> toMap(){
    return{
      'cityId':cityId,
      'cityName':cityName,
      'provinceId':provinceId
    };
  }
}