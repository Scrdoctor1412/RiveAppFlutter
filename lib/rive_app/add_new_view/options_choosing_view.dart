import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/add_new_view/new_project_view.dart';
import 'package:rive_learning/rive_app/add_new_view/new_task_view.dart';
import 'package:rive_learning/rive_app/models/task.dart';
import 'package:rive_learning/rive_app/services/task/task_service.dart';

class OptionsChoosingView extends StatefulWidget {
  const OptionsChoosingView({Key? key, required this.tasksSnapId, required this.projectsSnapId}) : super(key: key);

  final String tasksSnapId;
  final String projectsSnapId;

  @override
  _OptionsChoosingViewState createState() => _OptionsChoosingViewState();
}



class _OptionsChoosingViewState extends State<OptionsChoosingView> {
  final TaskService _taskService = TaskService();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Options',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 19),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        titleSpacing: 0,
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: (){
              index == 0 ? _deleteTask() : _updateTasks();
            },
            child: Text(
              index == 0 ? "Delete" : "Update",
              style: TextStyle(
                height: 2,
                fontFamily: 'Poppins',
                fontSize: 16,
                color: index == 0 ? Colors.red : Colors.green,
              ),
            ),
          );
        },
        separatorBuilder: (context, index) => const Divider(
          height: 24,
        ),
        itemCount: 2,
      ),
    );
  }

  void _deleteTask() async {
    // print(widget.tasksSnapId);
    var res = await _taskService.deleteTask(widget.projectsSnapId, widget.tasksSnapId).then((res) => {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('delete successfully'))),
      Navigator.of(context).pop(res)
    });
    
  }

  void _updateTasks() async {
    Navigator.of(context).pop(2);
    final dynamic res = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: FractionallySizedBox(
              heightFactor: 0.4,
              child: NewTaskView(),
            ),
          ),
        );
      },
      backgroundColor: Colors.white,
    );
    if (!context.mounted) return;
    var newTask = res as ProjectTask;
    await _taskService.updateTask(widget.projectsSnapId, widget.tasksSnapId, newTask).then((_) => {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('update successfully'),))
    });
    Navigator.of(context).pop(2);
    // Navigator.of(context).pop(2);
  }
  
}
