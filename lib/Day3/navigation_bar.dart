import 'package:flutter/material.dart';
import 'package:myapp/Day1/pavlova_recipe.dart';
import 'package:myapp/Day2/profile.dart';
import 'package:myapp/Day3/favorite_app.dart';

class NavigationBarApp extends StatelessWidget {
  const NavigationBarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const NavigationEx(),
    );
  }
}

class NavigationEx extends StatefulWidget {
  const NavigationEx();
  
  @override
  State<StatefulWidget> createState() => _NavigationEx();
}

class _NavigationEx extends State<NavigationEx>{
  //Set current page 0
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      //Create Bottom NavigationBar
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index){
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.blue,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.favorite), 
            label: 'Favorites'),
          NavigationDestination(
            icon: Icon(Icons.receipt), 
            label: 'Pavalo Receip'),
          NavigationDestination(
            icon: Icon(Icons.face), 
            label: 'Profile')
        ],
      ),

      //Body
      body: <Widget>[
        /// Home page
        const FavoriteApp(),
        const PavlovaRecipe(),
        const Profile()
      ][currentPageIndex],
    );
  }
}