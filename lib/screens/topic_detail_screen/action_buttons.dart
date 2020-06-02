import 'package:bongo_quiz/providers/language_provider.dart';
import 'package:bongo_quiz/providers/topic_details_provider.dart';
import 'package:bongo_quiz/providers/user_channel_provider.dart';
import 'package:bongo_quiz/shared/custom_dialog.dart';
import 'package:bongo_quiz/shared/friend_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ActionButtons extends StatelessWidget {
  final TopicDetailsProvider provider;
  ActionButtons(this.provider);

  void _showPlayDialog(BuildContext context) {
    Navigator.of(context).push(CustomDialog(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topRight,
            child: Container(
              margin: const EdgeInsets.only(right: 20, top: 20),
              child: IconButton(
                icon: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 40,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          Consumer<LanguageProvider>(
            builder: (_, language, __) => Center(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "${language.term('Random Opponent')}:",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w300),
                        ),
                        _buildCustomButton(
                          title: language.term("Random"),
                          color: Theme.of(context).accentColor,
                          iconData: Icons.forward,
                          width: 150,
                          handler: () {
                            Provider.of<UserChannelProvider>(context,
                                    listen: false)
                                .searchOpponent(provider.details.id);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      margin: const EdgeInsets.only(left: 20),
                      child: Text(
                        language.term('Play with a friend'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 3, horizontal: 20),
                      child: Form(
                        child: TextFormField(
                          decoration: InputDecoration(
                            hintText: "Search friend",
                            hintStyle: TextStyle(color: Colors.white),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: new BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide(
                                color: Colors.white,
                              ),
                            ),
                            contentPadding: EdgeInsets.only(left: 3),
                            suffixIcon:
                                const Icon(Icons.search, color: Colors.white),
                          ),
                          cursorColor: Colors.white,
                        ),
                      ),
                    ),
                    Container(
                      height: 300,
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[100],
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Wrap(
                        direction: Axis.horizontal,
                        alignment: WrapAlignment.center,
                        children: provider.details.friends
                            .map((friend) => FriendItem(friend))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          SizedBox(height: 20),
          _buildCustomButton(
              context: context,
              color: Colors.greenAccent[700],
              iconData: Icons.play_circle_outline,
              title: "Play",
              handler: () {
                _showPlayDialog(context);
              }),
          _buildCustomButton(
              context: context,
              color: provider.details.isFollowing
                  ? Theme.of(context).accentColor
                  : Colors.green[900],
              iconData: provider.details.isFollowing
                  ? Icons.thumb_down
                  : Icons.thumb_up,
              title: provider.details.isFollowing ? "Unfollow" : "Follow",
              handler: () {}),
          _buildCustomButton(
              context: context,
              color: Colors.orange[300],
              iconData: Icons.insert_chart,
              title: "Rankings",
              handler: () {}),
          _buildCustomButton(
              context: context,
              color: Colors.lime[500],
              iconData: Icons.show_chart,
              title: "Results",
              handler: () {}),
        ],
      ),
    );
  }

  Widget _buildCustomButton(
      {BuildContext context,
      String title,
      Color titleColor,
      IconData iconData,
      Color iconColor,
      Color color,
      double width,
      Function handler}) {
    return Container(
      width: width ?? double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: RaisedButton.icon(
        icon: Icon(
          iconData,
          color: iconColor ?? Colors.white,
          size: 20,
        ),
        label: Text(
          title,
          style: TextStyle(
            color: iconColor ?? Colors.white,
            fontSize: 15,
          ),
        ),
        color: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10),
        onPressed: handler,
      ),
    );
  }
}
