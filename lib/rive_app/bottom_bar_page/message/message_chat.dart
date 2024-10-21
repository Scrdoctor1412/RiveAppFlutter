import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/message/message_more.dart';
import 'package:rive_learning/rive_app/services/chat/chat_service.dart';
import 'package:rive_learning/rive_app/theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageChat extends StatefulWidget {
  const MessageChat(
      {Key? key, required this.receiverUserEmail, required this.receiverUserID})
      : super(key: key);
  final String receiverUserEmail;
  final String receiverUserID;

  @override
  _MessageChatState createState() => _MessageChatState();
}

class _MessageChatState extends State<MessageChat> {
  final TextEditingController _messageController = TextEditingController();
  final ItemScrollController _scrollController = ItemScrollController();
  final ChatService _chatService = ChatService();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  File? _selectedImage;
  String? imgUrl;

  String tempDay = "";

  void sendMessage() async {
    if (_messageController.text.isNotEmpty) {
      await _chatService.sendMessage(
          widget.receiverUserID, _messageController.text, imgUrl);
      _messageController.clear();
    } else {
      if (imgUrl != null) {
        await _chatService.sendMessage(widget.receiverUserID, "", imgUrl);
      }
    }
    tempDay = "";
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.scrollTo(
        index: 99999,
        duration: const Duration(milliseconds: 500),
      );
    });
  }

  Future _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    setState(() {
      _selectedImage = File(returnedImage!.path);
    });

    final storageRef = FirebaseStorage.instance.ref();
    Reference ref = storageRef.child('testname/');

    await ref.putFile(File(returnedImage!.path));
    imgUrl = await ref.getDownloadURL();
    sendMessage();
    imgUrl = null;
  }

  void testingPrefs() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print('testing prefs : ${prefs.getInt('testingPref')}');
  }

  void scrollToIndex() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    int index = await prefs.getInt('messageIndex')!;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.scrollTo(
        index: index,
        duration: Duration(milliseconds: 500),
      );
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _scrollController.scrollTo(
        index: 99999,
        duration: Duration(milliseconds: 100),
      );
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _messageController.dispose();
    // _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildNavBar(),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              height: MediaQuery.of(context).viewInsets.bottom > 0
                  ? 707 - 179 - 132 - 25
                  : 707,
              child: _buildMessageList(),
            ),
            // TextField(),
            const Spacer(),
            // TextField()
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      _pickImageFromGallery();
                    },
                    icon: const Icon(
                      Icons.attach_file,
                      color: CupertinoColors.systemBlue,
                    )),
                Container(
                  height: 60,
                  width: MediaQuery.of(context).size.width - 49 - 47,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter message',
                    ),
                    obscureText: false,
                    autofocus: true,
                    focusNode: FocusNode(),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: CupertinoColors.systemBlue,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavBar() {
    return StreamBuilder(
      stream: _chatService.getMessages(
        widget.receiverUserID,
        _firebaseAuth.currentUser!.uid,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error for real: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }

        return Container(
          padding: const EdgeInsets.only(left: 16),
          height: 60,
          decoration: BoxDecoration(color: Colors.white, boxShadow: [
            BoxShadow(
                // spreadRadius: 12
                color: RiveAppTheme.shadow.withOpacity(0.3),
                spreadRadius: 0.1,
                blurRadius: 6,
                offset: const Offset(0, 8))
          ]),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: CupertinoColors.systemBlue,
                ),
              ),
              const SizedBox(width: 16),
              ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(32)),
                child: Image.asset(
                  'assets/avaters/avatar_1.jpg',
                  width: 42,
                ),
              ),
              const SizedBox(width: 6),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(
                      widget.receiverUserEmail,
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 19),
                      // softWrap: true,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Text('Active'),
                ],
              ),
              const Spacer(),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.phone,
                    color: CupertinoColors.systemBlue,
                  )),
              //const SizedBox(width: 12),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.video_camera_back,
                    color: CupertinoColors.systemBlue,
                  )),
              //const SizedBox(width: 12),
              IconButton(
                onPressed: () {
                  Navigator.of(context)
                      .push(
                    MaterialPageRoute(
                        builder: (context) => MessageMore(
                              currentUserId: _firebaseAuth.currentUser!.uid,
                              receiverUserId: widget.receiverUserID,
                            ),
                        settings: RouteSettings(name: '/', arguments: Map())),
                  )
                      .then((value) {
                    testingPrefs();
                    scrollToIndex();
                  });
                },
                icon: const Icon(
                  Icons.info,
                  color: CupertinoColors.systemBlue,
                ),
              ),
              //const SizedBox(width: 12),
            ],
          ),
        );
      },
    );
  }

  //build message list
  Widget _buildMessageList() {
    return StreamBuilder(
      stream: ChatService()
          .getMessages(widget.receiverUserID, _firebaseAuth.currentUser!.uid),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text('Error for real: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading...');
        }
        return Container(
          height: 200,
          child: ScrollablePositionedList.builder(
            itemScrollController: _scrollController,
            itemBuilder: (context, index) {
              return _buildMessageItem(snapshot.data!.docs[index]);
            },
            itemCount: snapshot.data!.docs.length,
          ),
        );
      },
    );
  }

  //build message item
  Widget _buildMessageItem(DocumentSnapshot document) {
    Map<String, dynamic> data = document.data() as Map<String, dynamic>;

    var alignment = (data['senderId'] == _firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    DateTime messDate = (data['timeStamp'] as Timestamp).toDate();
    String messTime = DateFormat('h:mm a').format(messDate);
    String messDay = DateFormat('MMM d').format(messDate);
    bool doAppearDay = false;
    if (tempDay != messDay) {
      tempDay = messDay;
      doAppearDay = !doAppearDay;
    }
    return data['imgUrl'] != null
        ? Container(
            alignment: alignment,
            child: Column(
              children: [
                Image.network(
                  data['imgUrl'],
                  scale: 10,
                ),
                const SizedBox(height: 12),
              ],
            ),
          )
        : Container(
            alignment: alignment,
            child: Column(
              crossAxisAlignment:
                  (data['senderId'] == _firebaseAuth.currentUser!.uid)
                      ? CrossAxisAlignment.end
                      : CrossAxisAlignment.start,
              children: [
                // Text(data['senderEmail']),
                doAppearDay
                    ? Center(
                        child: Text(
                          messDay,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      )
                    : Container(),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(32),
                    color: (data['senderId'] == _firebaseAuth.currentUser!.uid)
                        ? CupertinoColors.systemBlue
                        : CupertinoColors.systemGrey5,
                  ),
                  child: Text(
                    data['message'],
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color:
                            (data['senderId'] == _firebaseAuth.currentUser!.uid)
                                ? Colors.white
                                : Colors.black),
                  ),
                ),
                const SizedBox(height: 5),
                Text(messTime),
                const SizedBox(height: 12),
              ],
            ),
          );
  }
}
