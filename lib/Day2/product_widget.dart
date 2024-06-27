import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProductWidget extends StatelessWidget {
  const ProductWidget(
      {super.key,
      required this.imagePath,
      required this.name,
      required this.description,
      required this.price});

  final String imagePath;
  final String name;
  final String description;
  final num price;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 20),
        child: Row(
          children: [
          SizedBox(
            height: 100,
            width: 100,
            child: Image.asset(imagePath),
          ),
          Column(
            children: [
              Text(name), 
              Text(description), 
              Text('$price'),
            ],
          )
        ]));
  }
}

class ProductList extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildHomePageDay2(),
    );
  }
  
  Widget buildHomePageDay2(){
    return Scaffold(
      appBar: AppBar(title: const Text('Product List')),
      body: const Column(
        children: [
          ProductWidget(imagePath: 'assets/images/iphone.png', name: 'iPhone', description: 'iPhone 2024', price: 2000),
          ProductWidget(imagePath: 'assets/images/samsung.png', name: 'Samsung', description: 'Samsung Glaxy', price: 5000),
          ProductWidget(imagePath: 'assets/images/tablet.png', name: 'iPad', description: 'iPad 2024', price: 1000)
        ],
      ),
    );
  }
}
