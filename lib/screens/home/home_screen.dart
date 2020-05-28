import 'package:bongo_quiz/screens/home/home_page/favorite.dart';
import 'package:bongo_quiz/screens/home/home_page/new_topics.dart';
import 'package:bongo_quiz/screens/home/topics_page/topics.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const route = "home-screen";

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  PageController _controller;
  var currentPage = 0;

  @override
  void initState() {
    _controller = PageController(initialPage: currentPage);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.person),
          onPressed: () {},
        ),
        title: Text('BongoQuiz'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: PageView(
        onPageChanged: (page) {},
        controller: _controller,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          //Home Screen
          SingleChildScrollView(
            child: Column(
              children: <Widget>[
                FavoriteTopics(),
                NewTopics(),
              ],
            ),
          ),
          TopicsPage(),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor:
            currentPage == 0 ? Theme.of(context).accentColor : Colors.blue,
        child: Icon(Icons.home, color: Colors.white, size: 30),
        onPressed: () {
          setState(() {
                    currentPage = 0;
                    _controller.jumpToPage(0);
                  });
        },
      ),
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 5,
        child: SizedBox(
          height: 55,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                _buildBottomItem(1, Icons.settings, () {
                  setState(() {
                    currentPage = 1;
                    _controller.jumpToPage(1);
                  });
                }),
                _buildBottomItem(2, Icons.list, () {
                  setState(() {
                    currentPage = 2;
                    _controller.jumpToPage(2);
                  });
                }),
                _buildBottomItem(3, Icons.grid_on, () {
                  setState(() {
                    currentPage = 3;
                    _controller.jumpToPage(3);
                  });
                }),
                _buildBottomItem(4, Icons.mail, () {
                  setState(() {
                    currentPage = 4;
                    _controller.jumpToPage(4);
                  });
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomItem(int index, IconData iconData, Function handler) {
    return IconButton(
      icon: Icon(iconData,
          color: currentPage == index
              ? Theme.of(context).accentColor
              : Colors.white,
          size: 30),
      onPressed: handler,
    );
  }
}
