import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/models/task.dart';
import 'package:uuid/uuid.dart';

class NewTaskView extends StatefulWidget {
  const NewTaskView({Key? key, required this.projectsId, required this.tasksId}) : super(key: key);

  final List<String> projectsId;
  final List<String> tasksId;

  @override
  _NewTaskViewState createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _textController = TextEditingController();

  final ProjectTask _tempTask = ProjectTask(
      taskId: Uuid().v4(),
      taskName: "taskName",
      taskFinished: false,
      timeStamp: Timestamp.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFieldForm('Task name'),
          const SizedBox(height: 10),
          _buildTextFieldForm('Task deadline'),
          const SizedBox(height: 24),
          //Submit button
          Center(
            child: SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(_tempTask);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> _selectDate() async {
    DateTime? _picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (_picked != null) {
      setState(() {
        _dateController.text = _picked.toString().split(" ")[0];
        _tempTask.timeStamp = _picked as Timestamp;
      });
    }
  }

  Widget _buildTextFieldForm(String projectProps) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          projectProps,
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 50,
          child: TextField(
            controller: projectProps == 'Task deadline' ? _dateController : _textController,
            onChanged: (value) {
              // taskName = value;
              switch (projectProps) {
                case 'Task name':
                  _tempTask.taskName = value;
                  break;
                case 'Task deadline':
                  _tempTask.timeStamp = Timestamp.now();
                  break;
                default:
                  break;
              }
            },
            decoration: InputDecoration(
              label: projectProps == 'Task deadline'
                  ? const Text(
                      'Date',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        color: CupertinoColors.systemGrey,
                      ),
                    )
                  : null,
              prefixIcon: projectProps == 'Task deadline'
                  ? const Icon(
                      Icons.calendar_today,
                      color: CupertinoColors.systemGrey,
                    )
                  : const Icon(
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
            readOnly: projectProps == 'Task deadline' ? true : false,
            onTap: projectProps == 'Task deadline' ? _selectDate : null,
          ),
        ),
      ],
    );
  }
}
