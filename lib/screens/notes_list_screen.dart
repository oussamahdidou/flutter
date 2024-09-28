import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/note_screen.dart';
import 'package:intl/intl.dart'; // For date formatting

class NotesListPage extends StatelessWidget {
  const NotesListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Static list of notes with colors, dates, and emojis
    final List<Map<String, dynamic>> notes = [
      {
        "text": "Note 1: Flutter is amazing!",
        "color": Colors.blueAccent,
        "date": DateTime.now(),
        "emoji": "😢"
      },
      {
        "text": "Note 2: Don't forget to submit the assignment.",
        "color": Colors.blueAccent,
        "date": DateTime.now().add(Duration(days: 1)),
        "emoji": "😢"
      },
      {
        "text": "Note 3: Meeting at 3 PM tomorrow.",
        "color": Colors.blueAccent,
        "date": DateTime.now().add(Duration(days: 2)),
        "emoji": "😢"
      },
      {
        "text": "Note 4: Buy groceries after work.",
        "color": Colors.blueAccent,
        "date": DateTime.now().add(Duration(days: 3)),
        "emoji": "😢"
      },
      {
        "text": "Note 5: Call Mom.",
        "color": Colors.blueAccent,
        "date": DateTime.now().add(Duration(days: 4)),
        "emoji": "😢"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes List'),
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          // Notes list
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: notes.length,
                  itemBuilder: (context, index) {
                    return _buildNoteButton(notes[index], context);
                  },
                ),
              ),
            ],
          ),
          // Positioned Add Note Button
        ],
      ),
    );
  }

  Widget _buildNoteButton(Map<String, dynamic> note, BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Handle note tap here
        // For example, navigate to a detail page or show a message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("You tapped on: ${note['text']}")),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: note['color'],
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note['emoji'],
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(height: 8),
            Text(
              note['text'],
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              DateFormat('yyyy-MM-dd').format(note['date']),
              style: const TextStyle(fontSize: 12, color: Colors.white70),
            ),
          ],
        ),
      ),
    );
  }
}
