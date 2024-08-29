import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/message/message_search.dart';

class MessageMore extends StatefulWidget {
  const MessageMore(
      {Key? key, required this.receiverUserId, required this.currentUserId})
      : super(key: key);

  final String receiverUserId;
  final String currentUserId;

  @override
  _MessageMoreState createState() => _MessageMoreState();
}

class _MessageMoreState extends State<MessageMore> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: CupertinoColors.systemBlue,
          ),
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(44),
                    child: Image.asset(
                      'assets/avaters/avatar_3.jpg',
                      width: 90,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Username',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                  ),
                  Text(
                    'Active some times ago',
                    style: TextStyle(
                        fontSize: 16,
                        color: CupertinoColors.systemGrey,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMessageUtils(Icon(Icons.facebook), 'Home page', () {}),
                  _buildMessageUtils(Icon(Icons.notifications),
                      'Turn off notification', () {}),
                  _buildMessageUtils(Icon(Icons.search), 'Search', () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MessageSearch(
                          receiverUserId: widget.receiverUserId,
                          currentUserId: widget.currentUserId,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildMessageUtils(Icon icon, String subtitle, void Function() func) {
    return Column(
      children: [
        IconButton(
          onPressed: func,
          icon: icon,
          style: IconButton.styleFrom(
            padding: const EdgeInsets.all(8),
            backgroundColor: CupertinoColors.systemGrey6,
            iconSize: 32,
          ),
        ),
        Text(
          subtitle,
          style: TextStyle(),
        )
      ],
    );
  }
}
