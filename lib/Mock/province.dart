class Province{
  final int? provinceId;
  final String? provinceName;

  Province({this.provinceId,this.provinceName});

  Map<String,dynamic> toMap(){
    return{
      'provinceId':provinceId,
      'provinceName':provinceName
    };
  }
}