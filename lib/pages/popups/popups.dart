// ignore_for_file: unused_element, camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_application/pages/colors/colors.dart';
import 'package:flutter_application/pages/socket_service/socket_service.dart';

class ShowDialogs {

  static void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ActualTheme.actualTheme.getPrimSmooth(),
          title: Text(
            'You are leaving!',
            style: TextStyle(
              color: ActualTheme.actualTheme.getTextColor(),
              fontWeight: FontWeight.normal,
            ),
          ),
          content: Text(
            'Would you like to leave the room?',
            style: TextStyle(
              color: ActualTheme.actualTheme.getTextColor(),
              fontWeight: FontWeight.normal,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'No',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text(
                'Yes',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                SocketService.instance.disconnectFromSocket();
                Navigator.of(context).pop();
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        );
      },
    );
  }

  static void showRoomClosedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: ActualTheme.actualTheme.getPrimSmooth(),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                'The room was closed!',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                ),
              ),
            ]
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Ok',
                style: TextStyle(
                  color: ActualTheme.actualTheme.getTextColor(),
                  fontWeight: FontWeight.normal,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

}