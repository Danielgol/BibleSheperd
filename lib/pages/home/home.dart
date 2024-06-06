// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/choose_book/choose_book.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/follow/follow.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/share/share.dart';

class HomePage extends StatelessWidget {

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: actual_theme,
      //   title: Text('Some'),
      // ),
      backgroundColor: actual_theme,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/icon.png',
                width: 80,
                height: 80,
              ),
              SizedBox(height: 20),
              Text(
                "Bible Shepherd",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 5),
              Text(
                "King James Version",
                style: TextStyle(
                  color: Color.fromARGB(255, 157, 157, 157),
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 50),
              SizedBox(
                width: 220.0,
                height: 60.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 52, 69, 84)
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SharePage()),
                    );
                  },
                  child: Text(
                    "Share",
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 247, 251),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 220.0,
                height: 60.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 52, 69, 84)
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FollowPage()),
                    );
                  },
                  child: Text(
                    "Follow",
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 247, 251),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              SizedBox(
                width: 220.0,
                height: 60.0,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      const Color.fromARGB(255, 52, 69, 84)
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChooseBookPage(roomCode: '', userType: UserType.offline)),
                    );
                  },
                  child: Text(
                    "Read",
                    style: TextStyle(
                      color: Color.fromARGB(255, 241, 247, 251),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
