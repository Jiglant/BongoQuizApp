import 'package:flutter/material.dart';

class CustomBottomNav extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: SizedBox(
        height: 55,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _buildBottomItem(Icons.settings, () {}),
              _buildBottomItem(Icons.list, () {}),
              _buildBottomItem(Icons.grid_on, () {}),
              _buildBottomItem(Icons.mail, () {}),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomItem(IconData iconData, Function handler) {
    return IconButton(
      icon: Icon(iconData, color: Colors.white, size: 30),
      onPressed: handler,
    );
  }
}
