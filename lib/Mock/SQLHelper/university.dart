class University{
  final int? unId;
  final String? unName;
  final int? provinceId;

  University({this.unId,this.unName,this.provinceId});

  Map<String,dynamic> toMap(){
    return{
      'unId':unId,
      'unName':unName,
      'provinceId':provinceId
    };
  }
}