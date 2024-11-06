import 'package:dotted_border/dotted_border.dart';
import 'package:drag_and_drop_lists/drag_and_drop_lists.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/task_card.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';
import 'package:rive_learning/rive_app/add_new_view/new_project_view.dart';
import 'package:rive_learning/rive_app/services/project/project_service.dart';

class DragAndDrop extends StatefulWidget {
  const DragAndDrop({Key? key}) : super(key: key);

  @override
  State createState() => _DragAnDropState();
}

class InnerList {
  final String name;
  List<String> children;
  InnerList({required this.name, required this.children});
}

class _DragAnDropState extends State<DragAndDrop> {
  late List<InnerList> _lists;
  bool flag = false;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final ProjectService _projectService = ProjectService();
  List<Map<String, dynamic>> _projectList = [];
  List<Map<String, dynamic>> _inWorkList = [];
  List<Map<String, dynamic>> _completedList = [];

  @override
  void initState() {
    super.initState();

    _lists = [];

    initProjects();
  }

  void initProjects() async {
    await _projectService.getAllProjects2().then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        _projectList.add(docSnapshot.data());
        print('success');
      }

      for (var project in _projectList) {
        if (project['projectFinished']) {
          _completedList.add(project);
        } else {
          _inWorkList.add(project);
        }
      }

      //update drag and drop list
      setState(() {
        _lists = List.generate(2 /*2 columns */, (outerIndex) {
          return InnerList(
            name: outerIndex.toString(),
            children: List.generate(
                outerIndex == 0 ? _inWorkList.length : _completedList.length,
                (innerIndex) => '$outerIndex.$innerIndex'),
          );
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 12),
        child: DragAndDropLists(
          children: List.generate(_lists.length, (index) => _buildList(index)),
          itemTargetOnAccept: (incoming, parentList, target) {
            print('lmao');
          },
          onItemReorder: _onItemReorder,
          onListReorder: _onListReorder,
          axis: Axis.horizontal,
          listWidth: 320,
          listDraggingWidth: 320,
          listPadding: const EdgeInsets.all(10.0),
          listDecoration: BoxDecoration(
              color: Color.fromARGB(20, 50, 173, 230),
              border: Border.all(color: Colors.transparent),
              borderRadius: BorderRadius.circular(24)),
        ),
      ),
    );
  }

  _buildList(int outerIndex) {
    var innerList = _lists[outerIndex];
    return DragAndDropList(
      header: Container(
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  flag
                      ? outerIndex == 0
                          ? 'COMPLETED'
                          : 'IN WORK'
                      : outerIndex == 0
                          ? 'IN WORK'
                          : 'COMPLETED',
                  style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                  decoration: BoxDecoration(
                      border: Border.all(
                          width: 2, color: CupertinoColors.systemGrey),
                      borderRadius: BorderRadius.circular(24)),
                  child: Text(
                    '${innerList.children.length}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        color: CupertinoColors.systemGrey),
                  ),
                ),
                const Spacer(),
                IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz))
              ],
            ),
            const Divider(
              color: Colors.blueAccent,
              thickness: 3,
            ),
          ],
        ),
      ),
      footer: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: flag
              ? outerIndex == 0
                  ? null
                  : _buildAddProject()
              : outerIndex == 0
                  ? _buildAddProject()
                  : null),
      children: List.generate(
          innerList.children.length,
          (index) =>
              _buildItem('Research for mobile project', index, outerIndex)),
    );
  }

  _buildItem(String item, int index, int columnIndex) {
    print('column index: $columnIndex');
    var project;
    if (_projectList.isNotEmpty) {
      var _projectGet;
      // _projectGet = columnIndex == 0 ? _inWorkList[index] : _completedList[index];
      if (columnIndex == 0) {
        _projectGet = _inWorkList[index];
      } else {
        if (_completedList.isNotEmpty) {
          _projectGet = _completedList[index];
        }
      }
      project = Project(
        projectPosition: _projectGet['projectPosition'],
        projectName: _projectGet['projectName'],
        projectDesc: _projectGet['projectDesc'],
        projectUrgent: _projectGet['projectUrgent'],
        projectFinished: _projectGet['projectFinished'],
        timeStamp: _projectGet['timeStamp'],
      );
    }
    return DragAndDropItem(child: TaskCard(project: project));
  }

  _onItemReorder(
      int oldItemIndex, int oldListIndex, int newItemIndex, int newListIndex) {
    setState(() {
      var movedItem = _lists[oldListIndex].children.removeAt(oldItemIndex);
      _lists[newListIndex]
          .children
          .insert(newItemIndex, movedItem); //drag n drop list

      //Handle reordering for data from column 1 to 2 and back
      if(oldListIndex == newListIndex){
        return;
      }
      else if (oldListIndex == 0) {
        _inWorkList[oldItemIndex]['projectFinished'] = true;
        _completedList.insert(
            newItemIndex, _inWorkList[oldItemIndex]); //add new item to complete list
        _inWorkList.removeAt(oldItemIndex);  //remove the item just add to complete list in inwork list
      }else if(oldListIndex == 1){
        _inWorkList[oldItemIndex]['projectFinished'] = false;
        _inWorkList.insert(
            newItemIndex, _inWorkList[oldItemIndex]); //add new item to inwork list
        _completedList.removeAt(oldItemIndex);  //remove the item just add to inwork list in complete list
      }
    });
  }

  _onListReorder(int oldListIndex, int newListIndex) {
    setState(() {
      var movedList = _lists.removeAt(oldListIndex);
      flag = !flag;
      _lists.insert(newListIndex, movedList);
    });
  }

  Widget _buildAddProject() {
    return InkWell(
      onTap: () {
        _toNewProject();
      },
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: Radius.circular(8),
        padding: const EdgeInsets.all(12),
        dashPattern: [5, 5],
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.add),
            Text(
              'Add card',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w900,
                fontFamily: 'Inter',
              ),
            ),
          ],
        ),
      ),
    );
  }

  void addProject(Project newProject) async {
    await _projectService.addProject(newProject);

    await _projectService.getAllProjects2().then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        _projectList.add(docSnapshot.data());
        print('success');
      }
      setState(() {
        _lists.clear();
        _projectList.clear();
        _inWorkList.clear();
        _completedList.clear();
        initProjects();
      });
    });
  }

  void _toNewProject() async {
    final dynamic res = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: const FractionallySizedBox(
              heightFactor: 0.6,
              child: NewProjectView(),
            ),
          ),
        );
      },
      backgroundColor: Colors.white,
    );

    if (!context.mounted) return;

    final newProject = res as Project;
    // print(newProject.projectName);
    addProject(newProject);
  }
}
