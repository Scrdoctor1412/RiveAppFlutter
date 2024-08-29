import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NewSubTask extends StatefulWidget {
  const NewSubTask({Key? key}) : super(key: key);

  @override
  _NewSubTaskState createState() => _NewSubTaskState();
}

class _NewSubTaskState extends State<NewSubTask> {
  final TextEditingController _textEditingController = TextEditingController();

  String taskName = "";

  @override
  void dispose() {
    // TODO: implement dispose
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
        padding: EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Task name',
              style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 50,
              child: TextField(
                onChanged: (value) {
                  taskName = value;
                },
                decoration: InputDecoration(
                  prefixIcon: const Icon(
                    Icons.text_fields_rounded,
                    color: CupertinoColors.systemGrey,
                  ),
                  filled: true,
                  fillColor: CupertinoColors.systemGrey5,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 0,
                    borderSide: const BorderSide(
                      color: CupertinoColors.systemGrey5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 0,
                    borderSide: const BorderSide(
                      color: CupertinoColors.systemGrey5,
                    ),
                  ), 
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    gapPadding: 0,
                    borderSide: const BorderSide(
                      color: CupertinoColors.systemGrey5,
                    ),
                  ),
                ),
                focusNode: FocusNode(),
                autofocus: true,
              ),
            ),
            const SizedBox(height: 12),
            Center(
              child: SizedBox(
                width: double.infinity,
                child: SizedBox(
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop(taskName);
                    },
                    child: Text('Submit', style: TextStyle(color: Colors.white, fontFamily: 'Poppins'),),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    
  }
}
