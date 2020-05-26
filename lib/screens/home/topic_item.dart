import 'package:flutter/material.dart';

class TopicItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      width: 60,
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
            child: Image.asset(
              'assets/image/logo.png',
              height: 55,
              width: 55,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 3),
          Text(
            'Vodacom Tanzania yatosha',
            style: TextStyle(color: Colors.orange, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
            maxLines: 2,
          ),
        ],
      ),
    );
  }
}
