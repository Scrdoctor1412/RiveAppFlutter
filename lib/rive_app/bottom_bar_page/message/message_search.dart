import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rive_learning/rive_app/services/chat/chat_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MessageSearch extends StatefulWidget {
  const MessageSearch(
      {Key? key, required this.receiverUserId, required this.currentUserId})
      : super(key: key);

  final String receiverUserId;
  final String currentUserId;

  @override
  _MessageSearchState createState() => _MessageSearchState();
}

class _MessageSearchState extends State<MessageSearch> {
  TextEditingController _searchController = TextEditingController();

  String removeDiacritics(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';

    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }

    return str;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(
          'Searching',
          style: TextStyle(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          TextField(
            controller: _searchController,
            // onChanged: (value) {
            //   // setState(() {});
            //   Future.delayed(const Duration(milliseconds: 800), () {
            //     setState(() {
            //     });
            //   });
            // },
            onSubmitted: (value) {
             Future.delayed(const Duration(milliseconds: 500), () {
                setState(() {
                });
              }); 
            },
            decoration: InputDecoration(
              prefixIcon: Icon(Icons.search),
              filled: true,
              fillColor: CupertinoColors.systemGrey5,
              hintText: 'Find in conversation',
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                gapPadding: 0,
                borderSide: BorderSide(
                  color: CupertinoColors.systemGrey5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(32),
                gapPadding: 0,
                borderSide: BorderSide(
                  color: CupertinoColors.systemGrey5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: StreamBuilder(
                stream: ChatService()
                    .getMessages(widget.receiverUserId, widget.currentUserId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error for real: ${snapshot.error}');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }

                  List<DocumentSnapshot> tempList = [];
                  List<int> tempListIndex = [];

                  for (int i = 0; i < snapshot.data!.docs.length; i++) {
                    if (_searchController.text.isNotEmpty) {
                      Map<String, dynamic> messData =
                          snapshot.data!.docs[i].data() as Map<String, dynamic>;
                      String messString = messData['message'];
                      if (removeDiacritics(messString)
                          .contains(removeDiacritics(_searchController.text))) {
                        tempList.add(snapshot.data!.docs[i]);
                        tempListIndex.add(i);
                      }
                    }
                  }

                  return ListView.separated(
                    itemBuilder: (context, index) {
                      // List<DocumentSnapshot> tempList = snapshot.data!.docs.map((document) => document.data()).toList();
                      return InkWell(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setInt(
                              'messageIndex', tempListIndex[index]);
                          int count = 0;
                          Navigator.of(context).popUntil((_) => count++ >= 2);
                        },
                        child: Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(32),
                              child: Image.asset(
                                'assets/avaters/avatar_3.jpg',
                                width: 50,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Username',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      (tempList[index].data()
                                          as Map<String, dynamic>)['message'],
                                      style: TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      DateFormat('h:mm a').format(
                                          ((tempList[index].data() as Map<
                                                      String,
                                                      dynamic>)['timeStamp']
                                                  as Timestamp)
                                              .toDate()),
                                      style: TextStyle(fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 20),
                    itemCount: tempList.length,
                  );
                }),
          )
        ],
      ),
    );
  }
}
