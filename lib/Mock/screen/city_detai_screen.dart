import 'package:flutter/material.dart';

class CityDetaiScreen extends StatelessWidget {
  final int? cityId;
  final String? cityName;
  const CityDetaiScreen({super.key, required this.cityId, this.cityName});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: _CityDetailPage(
        cityId: cityId,
        cityName: cityName,
      ),
    );
  }
}

class _CityDetailPage extends StatefulWidget {
  final int? cityId;
  final String? cityName;
  const _CityDetailPage(
      {super.key, required this.cityId, required this.cityName});

  @override
  State<StatefulWidget> createState() => _CityDetailPageState();
}

class _CityDetailPageState extends State<_CityDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cityName}'),
      ),
      body:const Column(
        children: [
          Padding(
                padding:  EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      'Universities',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    
                  ],
                )),
                //Expanded(),
                Padding(
                padding:  EdgeInsets.only(left: 15),
                child: Row(
                  children: [
                    Text(
                      'Scinecspots',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    
                  ],
                )),
                //Expanded(),
        ],
      ),
    );
  }
}
