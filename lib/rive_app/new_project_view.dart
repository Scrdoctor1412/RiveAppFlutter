import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';

class NewProjectView extends StatefulWidget {
  const NewProjectView({Key? key}) : super(key: key);

  @override
  _NewProjectViewState createState() => _NewProjectViewState();
}

class _NewProjectViewState extends State<NewProjectView> {

  Project tempProject = Project(projectPosition: 'Dev', projectName: 'temp', projectDesc: 'temp', projectUrgent: 'low', projectFinished: false, timeStamp: Timestamp.now());

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildTextFieldForm('Project position'),
          const SizedBox(height: 10),
          _buildTextFieldForm('Project name'),
          const SizedBox(height: 10),
          _buildTextFieldForm('Project description'),
          const SizedBox(height: 10),
          _buildTextFieldForm('Project urgent'),          
          const SizedBox(height: 17),
          
          //Submit button
          Center(
            child: SizedBox(
              width: double.infinity,
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(tempProject);
                  },
                  child: Text(
                    'Submit',
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'Poppins'),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
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
            onChanged: (value) {
              // taskName = value;
              switch (projectProps){
                case 'Project position': tempProject.projectPosition = value; break;
                case 'Project name': tempProject.projectName = value; break;
                case 'Project description': tempProject.projectDesc = value; break;
                case 'Project urgent': tempProject.projectUrgent = value; break;
                default: break;
              }
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
      ],
    );
  }
}
