//import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BuildHomePageProfile(),
    );
  }
}

class BuildHomePageProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Profile',
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          //Image
          Container(
            padding: EdgeInsets.all(10),
            child: SizedBox(
              width: 400,
              height: 400,
              child: Image.asset('assets/images/profile-picture.jpeg'),
            ),
          ),

          const ListTile(
            title: Text(
              'Le Hong Ky',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            leading: Icon(
              Icons.arrow_back,
            ),
            trailing: Text(
              'Trainer',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),

          const ListTile(
              title: Text(
                'kyle@r2s.com.vn',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.email,
              )),

          const ListTile(
              title: Text(
                '0855 XXX XXX',
                style: TextStyle(
                    color: Colors.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.bold),
              ),
              leading: Icon(
                Icons.phone,
              )),

          const Expanded(
            child: ListTile(
                title: Text(
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit. '
                  'Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. '
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.',
                ),
                subtitle: Text(
                  'Cau noi ua thich',
                  style: TextStyle(color: Colors.blue),
                ),
                leading: Icon(
                  Icons.email,
                )),
          )
        ],
      ),
    );
  }
}
