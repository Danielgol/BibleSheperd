// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/choose_book/choose_book.dart';
import 'package:flutter_application/pages/follow/follow.dart';
import 'package:flutter_application/pages/share/share.dart';

class HomePage extends StatelessWidget {
  
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bible Shepherd'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Image.asset(
              //   'assets/images/logo.png',
              //   width: 150,
              //   height: 150,
              // ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  // Ação para o botão "Share"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SharePage()),
                  );
                },
                child: Text('Share'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ação para o botão "Follow"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FollowPage()),
                  );
                },
                child: Text('Follow'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Ação para o botão "Read"
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChooseBookPage(connection: '')),
                  );
                },
                child: Text('Read'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
