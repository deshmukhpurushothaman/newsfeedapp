import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GridDashboard extends StatefulWidget {
  @override
  _GridDashboard createState() => _GridDashboard();
}

class _GridDashboard extends State<GridDashboard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/admin.png"),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Text("YOUR TEXT"),
      ),
    );
  }
}
