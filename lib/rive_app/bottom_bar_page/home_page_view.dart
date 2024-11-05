import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:intl/intl.dart';
import 'package:rive_learning/rive_app/add_new_view/new_project_view.dart';
import 'package:rive_learning/rive_app/bottom_bar_page/home_page_content/task_view.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';
import 'package:rive_learning/rive_app/models/task.dart';
import 'package:rive_learning/rive_app/add_new_view/new_task_view.dart';
import 'package:rive_learning/rive_app/services/project/project_service.dart';
import 'package:rive_learning/rive_app/services/task/task_service.dart';
import 'package:rive_learning/rive_app/theme.dart';
import 'package:uuid/uuid.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key, this.settingViews});

  final void Function()? settingViews;
  static const route = '/home-view';

  @override
  State<HomePageView> createState() {
    return _HomePageViewState();
  }
}

class _HomePageViewState extends State<HomePageView> {
  final ProjectService _projectService = ProjectService();
  final TaskService _taskService = TaskService();

  List<ImageProvider> _images = [
    const ExactAssetImage('assets/avaters/avatar_1.jpg', scale: 3),
    const ExactAssetImage('assets/avaters/avatar_2.jpg', scale: 3),
    const ExactAssetImage('assets/avaters/avatar_3.jpg', scale: 3),
  ];

  // List<String> taskNames = [
  //   'Research for a hospital app',
  //   'Landing page design',
  //   'Web app design system',
  //   'Dasboard design fast',
  //   'lmao'
  // ];

  List<Project> _projects = [];
  List<String> _projectsSnapId = [];
  List<String> _tasksSnapId = [];
  List<List<ProjectTask>> _tasks = [];
  List<Map<String, List<ProjectTask>>> _tasksDict = [];

  int projectIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _projectsSnapId = [];
    // _tasks = [];
    init();
  }

  void init() async {
    initProjects();

    Future.delayed(const Duration(seconds: 1)).then((val) async => {
          for (var id in _projectsSnapId)
            {
              await _taskService.getTasks2(id).then((QuerySnapshot) {
                List<ProjectTask> tempList = [];
                print('Successflly');
                for (var docSnapShot in QuerySnapshot.docs) {
                  var tempVar = ProjectTask(
                      taskId: docSnapShot.data()['taskId'],
                      taskName: docSnapShot.data()['taskName'],
                      taskFinished: docSnapShot.data()['taskFinished'],
                      timeStamp: docSnapShot.data()['timeStamp']);
                  print(tempVar.taskName);
                  _tasksSnapId.add(docSnapShot.id);
                  tempList.add(tempVar);
                }
                setState(() {
                  _tasks.add(tempList);
                });
              })
            }
        });
  }

  void initProjects() async {
    await _projectService.getAllProjects2().then((querySnapshot) {
      print("Successfully completed");
      for (var docSnapshot in querySnapshot.docs) {
        var data = docSnapshot.data();
        _projects.add(
          Project(
            projectId: data['projectId'],
            projectPosition: data['projectPosition'],
            projectName: data['projectName'],
            projectDesc: data['projectDesc'],
            projectUrgent: data['projectUrgent'],
            projectFinished: data['projectFinished'],
            timeStamp: data['timeStamp'],
          ),
        );
        _projectsSnapId.add(docSnapshot.id);
        //Add tasks of a project to a list
        // initProjectTasks(docSnapshot.id);
      }
    });
  }

  void _addNewTask(String projectId, ProjectTask newTask) async {
    print('okay');
    await _taskService.addTaskToProject(projectId, newTask).then((_) {
      setState(() {
        _tasks[projectIndex].add(newTask);
      });
    });
  }

  void _toNewTask() async {
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
              child: NewTaskView(
                projectsId: _projectsSnapId,
                tasksId: _tasksSnapId,
              ),
            ),
          ),
        );
      },
      backgroundColor: Colors.white,
    );

    if (!context.mounted) return;
    final newTask = res as ProjectTask;
    _addNewTask(_projectsSnapId[projectIndex], newTask);
    // print(newTask.timeStamp);

    // final newProject = res as Project;
    // print(newProject.projectName);
    // addProject(newProject);
  }

  void _deleteProject() async {
    await _projectService
        .deleteProject(_projectsSnapId[projectIndex])
        .then((_) => {
              ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("delete successfully"))),
            });
    setState(() {
      print('nani');
      _projects.removeAt(projectIndex);
      _tasks.removeAt(projectIndex);
      _projectsSnapId.removeAt(projectIndex);
      _tasksSnapId.removeAt(projectIndex);
    });
  }

  void _updateProject() async {
    final dynamic res = await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: Container(
            child: FractionallySizedBox(
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
    await _projectService.updateProject(
        _projectsSnapId[projectIndex], newProject).then((_) => {
         ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("update successfully"))), 
        });
    setState(() { init(); });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 24, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hey, Ayzek',
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Poppins'),
                          ),
                          SizedBox(height: 6),
                          Text(
                            '5 tasks for you today',
                            style: TextStyle(
                              color: CupertinoColors.systemGrey,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Inter',
                            ),
                          )
                        ],
                      ),
                      const Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(32),
                        child: Image.asset(
                          'assets/avaters/avatar_5.jpg',
                          scale: 2.5,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 0),
                  title: const Text(
                    'Your projects',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'Inter',
                    ),
                  ),
                  trailing: InkWell(
                    onTap: widget.settingViews,
                    child: const Text(
                      'See all',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w900,
                        fontFamily: 'Inter',
                        color: Colors.blueAccent,
                      ),
                    ),
                  ),
                ),
                //Your projects list view
                Container(
                  padding: const EdgeInsets.only(left: 24),
                  height: 233,
                  child: _buildProjectList(),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Row(
                      children: [
                        const Text(
                          'Your tasks',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Inter',
                          ),
                        ),
                        const Spacer(),
                        InkWell(
                          onTap: () {
                            // setState(() {
                            //   _addNewTask(_projectsSnapId[projectIndex]);
                            // });
                            // _addNewTask(_projectsSnapId[projectIndex]);
                            // setState(() {});
                            _toNewTask();
                          },
                          child: const Text(
                            'Add tasks',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w900,
                              fontFamily: 'Inter',
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                _tasks.length == 0
                    ? Center(
                        child: Text('Empty'),
                      )
                    : ListView.separated(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(left: 24, right: 24),
                        itemBuilder: _buildTaskItem,
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 15,
                        ),
                        itemCount: _tasks[projectIndex].length,
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildProjectList() {
    return ListView.separated(
      // padding: const ,
      padding: const EdgeInsets.all(0),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            setState(() {
              projectIndex = index;
              print(
                  "project id after pressed: ${_projectsSnapId[projectIndex]}");
            });
          },
          onLongPress: () {},
          child: Container(
            height: 230,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: CupertinoColors.systemGrey3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      //Back ground container
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(16),
                              topRight: Radius.circular(16)),
                          color: Color.fromARGB(255, 53, 109, 238),
                        ),
                        height: 180,
                        width: 200,
                      ),
                      //Clipper container
                      ClipPath(
                        clipper: CustomClipPath(),
                        child: Container(
                          width: 200,
                          height: 180,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(16),
                                topRight: Radius.circular(16)),
                            color: Color.fromARGB(255, 20, 76, 199),
                          ),
                        ),
                      ),
                      //Content Container
                      Container(
                        // height: 200,
                        padding: const EdgeInsets.all(8),
                        width: 200,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    Icons.search,
                                    color: Colors.white,
                                  ),
                                  style: IconButton.styleFrom(
                                    backgroundColor:
                                        Colors.white.withOpacity(0.2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                                const Spacer(),
                                MenuAnchor(
                                  builder: (BuildContext context,
                                      MenuController controller,
                                      Widget? child) {
                                    return IconButton(
                                      padding: const EdgeInsets.all(0),
                                      onPressed: () {
                                        if (controller.isOpen) {
                                          controller.close();
                                        } else {
                                          controller.open();
                                        }
                                        setState(() {
                                          projectIndex = index;
                                        });
                                      },
                                      icon: const Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      ),
                                      alignment: Alignment.topCenter,
                                    );
                                  },
                                  menuChildren: List<MenuItemButton>.generate(
                                    2,
                                    (menuIndex) => MenuItemButton(
                                      onPressed: () {
                                        menuIndex == 0
                                            ? _deleteProject()
                                            : _updateProject();
                                        setState(() {
                                          // projectIndex = 0;
                                          // projectIndex = index;
                                        });
                                      },
                                      child: Text(
                                        menuIndex == 0 ? 'Delete' : 'Update',
                                        style: const TextStyle(
                                            fontFamily: 'Poppins'),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(height: 25),
                            //Project name
                            Text(
                              _projects[index].projectName,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 12),
                            //Project total tasks
                            const Text(
                              '42 tasks',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 5),
                Container(
                  // height: 25,
                  padding: const EdgeInsets.all(8),
                  width: 200,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Image.asset(
                          'assets/avaters/avatar_5.jpg',
                          width: 24,
                          height: 24,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        '%85',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'Inter'),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  width: 200,
                  // height: 5,
                  child: const LinearProgressIndicator(
                    value: 0.85,
                    color: Colors.green,
                    // valueColor: ,
                  ),
                )
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        width: 24,
      ),
      itemCount: _projects.length,
    );
  }

  Widget _buildTaskItem(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        // return ;
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const TaskView(),
          ),
        );
      },
      onLongPress: () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: RiveAppTheme.shadow.withOpacity(0.3),
              blurRadius: 6,
              spreadRadius: 1,
            )
          ],
        ),
        child: Card(
          shape: RoundedRectangleBorder(
            side: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(16),
          ),
          color: Colors.white,
          shadowColor: Colors.transparent,
          elevation: 0,
          child: ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
            shape: RoundedRectangleBorder(
              side: const BorderSide(
                color: CupertinoColors.systemGrey5,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            // minLeadingWidth: 0,
            leading: IconButton(
              onPressed: () {
                setState(() {
                  //change finished state for a task
                  _tasks[projectIndex][index].taskFinished =
                      !_tasks[projectIndex][index].taskFinished;
                });
              },
              icon: Icon(
                _tasks[projectIndex][index].taskFinished
                    ? Icons.check_circle
                    : Icons.circle_outlined,
                color: Colors.green,
                size: 32,
              ),
            ),
            title: Text(
              _tasks[projectIndex][index].taskName,
              style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w900,
                  fontFamily: 'Inter'),
            ),
            subtitle: Text(
              DateFormat('EEE, MMM d, y - h:mm a')
                  .format(_tasks[projectIndex][index].timeStamp.toDate()),
              style: const TextStyle(
                color: CupertinoColors.systemGrey,
                fontWeight: FontWeight.w700,
                fontFamily: 'Inter',
                fontSize: 13,
              ),
            ),
            trailing: SizedBox(
              width: 60,
              child: FlutterImageStack.providers(
                providers: _images,
                totalCount: 3,
                itemRadius: 60,
                itemBorderWidth: 3,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // final path = Path();
    Path path_0 = Path();
    path_0.moveTo(size.width * -0.0037500, size.height * -0.0040000);
    path_0.lineTo(size.width * -0.0058375, size.height * 0.6088400);
    path_0.quadraticBezierTo(size.width * 0.0855250, size.height * 0.5106600,
        size.width * 0.1897750, size.height * 0.4960000);
    path_0.cubicTo(
        size.width * 0.2852000,
        size.height * 0.5166200,
        size.width * 0.2806625,
        size.height * 0.8062600,
        size.width * 0.3737500,
        size.height * 0.8443800);
    path_0.cubicTo(
        size.width * 0.4374125,
        size.height * 0.8489400,
        size.width * 0.4620500,
        size.height * 0.8189800,
        size.width * 0.5262500,
        size.height * 0.7980000);
    path_0.cubicTo(
        size.width * 0.6669625,
        size.height * 0.7944600,
        size.width * 0.7280750,
        size.height * 0.7519400,
        size.width * 0.7447625,
        size.height * 0.7160000);
    path_0.cubicTo(
        size.width * 0.7575375,
        size.height * 0.5956400,
        size.width * 0.6492375,
        size.height * 0.5334800,
        size.width * 0.6625000,
        size.height * 0.4780000);
    path_0.cubicTo(
        size.width * 0.6693125,
        size.height * 0.3639600,
        size.width * 0.7727625,
        size.height * 0.3200000,
        size.width * 0.8029500,
        size.height * 0.1916800);
    path_0.cubicTo(
        size.width * 0.8134500,
        size.height * 0.1232600,
        size.width * 0.7970000,
        size.height * 0.0394400,
        size.width * 0.7692375,
        size.height * -0.0017200);
    path_0.quadraticBezierTo(size.width * 0.5759906, size.height * -0.0022900,
        size.width * -0.0037500, size.height * -0.0040000);
    path_0.close();
    return path_0;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
