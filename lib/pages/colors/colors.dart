
import 'package:flutter/material.dart';

class Theme {
  final Color primary;
  final Color textColor;
  final Color secondary;
  final Color ternary;
  final Color primSmooth;
  Theme({
    required this.primary,
    required this.textColor,
    required this.secondary, 
    required this.ternary,
    required this.primSmooth,
  });
}

Theme whiteTheme = Theme(
  primary: const Color.fromARGB(255, 250, 250, 247),
  textColor: Colors.black,
  secondary: const Color.fromARGB(255, 52, 69, 84),
  ternary: Color.fromARGB(255, 255, 254, 251),
  primSmooth: Color.fromARGB(255, 235, 235, 232),
);

Theme darkTheme = Theme(
  primary: const Color.fromARGB(255, 10, 24, 35),
  textColor: const Color.fromARGB(255, 250, 250, 247),
  secondary: const Color.fromARGB(255, 52, 69, 84),
  ternary: Color.fromARGB(255, 23, 37, 50),
  primSmooth: Color.fromARGB(255, 26, 52, 71),
);




final class ActualTheme {

  bool white = false;
  Theme whitemode = whiteTheme;
  Theme darkmode = darkTheme;

  static final ActualTheme actualTheme = ActualTheme();

  Color getPrimary(){
    if(white){
      return whitemode.primary;
    }
    return darkmode.primary; 
  }

  Color getTextColor(){
    if(white){
      return whitemode.textColor;
    }
    return darkmode.textColor;
  }

  Color getSecondary(){
    if(white){
      return whitemode.secondary;
    }
    return darkmode.secondary; 
  }

  Color getTernary(){
    if(white){
      return whitemode.ternary;
    }
    return darkmode.ternary; 
  }

  Color getPrimSmooth() {
    if(white){
      return whitemode.primSmooth;
    }
    return darkmode.primSmooth; 
  }
  
}

