import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DropdownButtonEx extends StatefulWidget {
  final User? user;
  const DropdownButtonEx({super.key, required this.user});

  @override
  State<DropdownButtonEx> createState() => _DropdownButtonExState();
}

class _DropdownButtonExState extends State<DropdownButtonEx> {
  late List<String> _options;

  @override
  void initState() {
    super.initState();
    _options = [
      widget.user?.email ?? 'Unknown User', // Use user's email or a placeholder
      'Sign Out',
    ];
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      onSelected: (String value) {
        setState(() {
        });
        if (value == _options[0]) {
          _profileDetail();
        } else if (value == _options[1]) {
          _signOut();
          }
      },
      itemBuilder: (BuildContext context) {
        return _options.map((String option) {
          return PopupMenuItem<String>(
            value: option,
            child: Text(option),
          );
        }).toList();
      },
      icon: const Icon(Icons.more_vert),
    );
  }

  void _profileDetail() {
    
  }

  void _signOut() {
    FirebaseAuth.instance.signOut();
  }
}
