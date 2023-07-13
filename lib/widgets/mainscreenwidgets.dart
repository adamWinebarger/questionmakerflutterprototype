import 'package:flutter/material.dart';

class MainScreenTextEntryInputDeco extends InputDecoration {
  const MainScreenTextEntryInputDeco({
    required this.labelText,
    this.topPadding = 0, this.bottomPadding = 0, this.leftPadding = 0, this.rightPadding = 0,
    this.fontSize = 32
  });

  final String labelText;
  final double topPadding, bottomPadding, leftPadding, rightPadding, fontSize;


  InputDecoration build(context) {
    return InputDecoration(
      label: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(leftPadding, topPadding, rightPadding, bottomPadding),
        child: Text(labelText,
          style: TextStyle(
            fontSize: fontSize,
            color: Colors.white
          ),
        ),
      )
    );
  }

}