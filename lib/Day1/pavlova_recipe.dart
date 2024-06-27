import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PavlovaRecipe extends StatelessWidget {
  const PavlovaRecipe({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: buildHomePage(),
    );
  }
}

Widget buildHomePage() {
  //Title
  const titleText = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Text(
        'Strawberry Pavlova',
        style: TextStyle(
            fontWeight: FontWeight.w500, letterSpacing: 0.5, fontSize: 25),
      ));

  //SubTitle
  const subTitle = Padding(
    padding: EdgeInsets.all(5),
    child: Text(
      'Pavlova is a meringue-based dessert named after the Russian ballerina '
      'Anna Pavlova. Pavlova features a crisp crust and soft, light inside, '
      'topped with fruit and whipped cream.',
    ),
  );

  //Star
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      Icon(Icons.star, color: Colors.green[500]),
      const Icon(Icons.star, color: Colors.black),
      const Icon(Icons.star, color: Colors.black),
    ],
  );
  //Review
  var reView = Row(
    mainAxisSize: MainAxisSize.min,
    children: [
      Text(
        '170 Reviews',
        style: TextStyle(
          fontWeight: FontWeight.w500
        ),
      )
    ],
  );

  var starAndReview = Container(
    padding: EdgeInsets.all(20),
    child: Row(
      //Aligin element
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //eEement
      children: [
        stars,
        reView
      ],
    ),
  );

  Widget itemColumn(IconData iconData, String label1, String label2) {
    return Column(
      children: [
        Icon(iconData, color: Colors.green[500]),
        Text(label1,style: TextStyle(fontWeight: FontWeight.bold),),
        Text(label2),
      ],
    );
  }

  final iconList = Container(
    padding: EdgeInsets.all(30),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        itemColumn(Icons.kitchen, 'PREP', '25 min'),
        itemColumn(Icons.timer, 'COOK', '1 hour'),
        itemColumn(Icons.restaurant, 'FEEDS', '4-6')
      ],
    )
  );

  //Image
  final mainImage = Image.asset( 'assets/images/pavlova.jpeg',
  );

  final bodyColumn = Container(
    padding: EdgeInsets.all(10),
    child: Column(
      children: [
        titleText, 
        subTitle,
        starAndReview,
        iconList,
        Expanded(child: mainImage)
        ],
    ),
  );
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Strawberry Pavlova Recipe',
        style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 30
        ),
      ),
      backgroundColor: Colors.blue,
    ),
    body: bodyColumn,
  );
}
