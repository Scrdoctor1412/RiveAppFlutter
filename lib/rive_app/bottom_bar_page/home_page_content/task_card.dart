import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_stack/flutter_image_stack.dart';
import 'package:rive_learning/rive_app/models/project_info.dart';
import 'package:rive_learning/rive_app/theme.dart';

class TaskCard extends StatelessWidget {
  const TaskCard({Key? key, required this.project}) : super(key: key);

  final Project project;

  @override
  Widget build(BuildContext context) {
    List<ImageProvider> _images = [
      ExactAssetImage('assets/avaters/avatar_1.jpg', scale: 3),
      ExactAssetImage('assets/avaters/avatar_2.jpg', scale: 3),
    ];
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: RiveAppTheme.shadow.withOpacity(0.2),
            blurRadius: 7,
            offset: Offset(0, 3),
          )
        ]
      ),
      child: Card(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.orange),
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.orange
                ),
                child: Text(project.projectPosition, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),),
              ),
              const SizedBox(height: 24),
              
              //project name
              Text(project.projectName, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, fontFamily: 'Inter'),),
              const SizedBox(height: 20),
              //project subtitle 
              Text(project.projectDesc, style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: CupertinoColors.systemGrey),),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Text('Progress', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 16, fontFamily: 'Inter'),),
                  const Spacer(),
                  Text('4/10', style: TextStyle(fontSize: 16),)
                ],
              ),
              const SizedBox(height: 10),
              //project progress
              LinearProgressIndicator(
                value: 3,
                color: Colors.green,
              ),
              const SizedBox(height: 15),
              const Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.circle_notifications_outlined, color: CupertinoColors.systemGrey,),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('4', style: TextStyle(color: CupertinoColors.systemGrey),)
                    ],
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      Icon(Icons.circle_notifications_outlined, color: CupertinoColors.systemGrey,),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('4', style: TextStyle(color: CupertinoColors.systemGrey),)
                    ],
                  ),
                  const SizedBox(width: 24),
                  Row(
                    children: [
                      Icon(Icons.circle_notifications_outlined, color: CupertinoColors.systemGrey,),
                      const SizedBox(
                        width: 4,
                      ),
                      Text('4', style: TextStyle(color: CupertinoColors.systemGrey),)
                    ],
                  ),
                ]
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  SizedBox(
                    width: 60,
                    child: FlutterImageStack.providers(
                      providers: _images,
                      totalCount: 2,
                      itemRadius: 60,
                      itemBorderWidth: 3,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      color: CupertinoColors.systemGrey5
                    ),
                    child: Text(project.projectUrgent, style: TextStyle(color: CupertinoColors.systemGrey, fontWeight: FontWeight.w900),),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
