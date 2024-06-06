// ignore_for_file: prefer_const_constructors, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/choose_book/choose_book.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/follow/follow.dart';
import 'package:flutter_application/pages/models/models.dart';
import 'package:flutter_application/pages/share/share.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin  {

  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<Offset> _whiteButtonAnimation;
  late Animation<Offset> _blackButtonAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 250),
    );

    _whiteButtonAnimation = Tween<Offset>(
      begin: Offset(0, 2),
      end: Offset(0, 0),
    ).animate(_animationController);

    _blackButtonAnimation = Tween<Offset>(
      begin: Offset(0, 1),
      end: Offset(0, 0),
    ).animate(_animationController);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggle() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void _updateWhite() {
    setState(() {
      ActualTheme.actualTheme.white = true;
    });
  }

  void _updateDark() {
    setState(() {
      ActualTheme.actualTheme.white = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: actual_theme,
      //   title: Text('Some'),
      // ),
      backgroundColor: ActualTheme.actualTheme.getPrimary(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              if(ActualTheme.actualTheme.white)...{
                Image.asset(
                  'assets/images/icon.png',
                  width: 80,
                  height: 80,
                ),
              }else...{
                Image.asset(
                  'assets/images/icon_dark.png',
                  width: 80,
                  height: 80,
                ),
              },
              SizedBox(height: 20),
              Text(
                "Bible Shepherd",
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
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
                      ActualTheme.actualTheme.getSecondary(),
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
                      ActualTheme.actualTheme.getSecondary(),
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
                      ActualTheme.actualTheme.getSecondary(),
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

      floatingActionButton: Stack(
        children: [
          Positioned(
            right: 16,
            bottom: 16,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SlideTransition(
                  position: _whiteButtonAnimation,
                  child: FloatingActionButton(
                    onPressed: _updateWhite,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.circle, color: Colors.black),
                  ),
                ),
                SlideTransition(
                  position: _blackButtonAnimation,
                  child: FloatingActionButton(
                    onPressed: _updateDark,
                    backgroundColor: Colors.black,
                    child: Icon(Icons.circle, color: Colors.white),
                  ),
                ),
                FloatingActionButton(
                  onPressed: _toggle,
                  child: Icon(Icons.settings),
                ),
              ],
            ),
          ),
        ],
      ),
      
    );
  }
}
