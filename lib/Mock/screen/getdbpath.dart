import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GetPathDb(),
    );
  }
}

class GetPathDb extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _pathState();
}

class _pathState extends State<GetPathDb> {
  String dbPath = '';

  @override
  void initState() {
    super.initState();
    _getDatabasePath();
  }

  Future<void> _getDatabasePath() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'ProvincesDatabase.db');
    
    setState(() {
      dbPath = path;
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
    );
  }
}