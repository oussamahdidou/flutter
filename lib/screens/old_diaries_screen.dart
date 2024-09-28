import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class OldDiariesScreen extends StatelessWidget {
  const OldDiariesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('old diaries screen')),
      body: Container(),
      floatingActionButton: SpeedDial(
        icon: Icons.menu, // Main button icon when not expanded
        activeIcon: Icons.close, // Icon when the FAB is expanded
        backgroundColor: Colors.blue, // Background color of the FAB
        children: [
          SpeedDialChild(
            child: const Icon(Icons.book), // Icon for "See Old Diaries"
            label: 'See Old Diaries', // Text label for the button
            backgroundColor: const Color.fromARGB(255, 153, 172, 235),
            shape:
                const CircleBorder(), // Background color for this button // Background color for this button
            onTap: () {
              Navigator.pushNamed(context, '/old_diaries');
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.add), // Icon for "Add New Diary"
            label: 'Add New Diary', // Text label for the button
            backgroundColor: const Color.fromARGB(255, 153, 172, 235),
            shape: const CircleBorder(),
            onTap: () {
              Navigator.pushNamed(context, '/add_diary');
            }, // Background color for this button
          ),
        ],
      ),
    );
  }
}
