import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Ensure you have this dependency in your pubspec.yaml
import 'package:table_calendar/table_calendar.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final PageController _pageController = PageController(initialPage: 0);

  // Emoji events for calendar
  Map<DateTime, String> emojiEvents = {
    DateTime.utc(2024, 9, 11): '😢',
    DateTime.utc(2024, 9, 12): '😢',
    DateTime.utc(2024, 9, 13): '😢',
    DateTime.utc(2024, 9, 15): '😢',
    DateTime.utc(2024, 9, 16): '😢',
    DateTime.utc(2024, 9, 17): '😢',
    DateTime.utc(2024, 9, 18): '😢',
    DateTime.utc(2024, 9, 19): '😢',
    DateTime.utc(2024, 9, 20): '😢',
    DateTime.utc(2024, 9, 21): '😢',
    DateTime.utc(2024, 9, 22): '😢',
    DateTime.utc(2024, 9, 23): '😢',
    DateTime.utc(2024, 9, 24): '😊',
    DateTime.utc(2024, 9, 25): '😊',
    DateTime.utc(2024, 9, 26): '😊',
    DateTime.utc(2024, 9, 27): '😢',
    DateTime.utc(2024, 9, 28): '😊',
  };

  // List of activities with title, image, and description
  final List<Map<String, String>> activities = [
    {
      'title': 'Gym Workout',
      'illustration': 'assets/images/gym.png',
      'description': 'Worked out at the gym for 2 hours'
    },
    {
      'title': 'Reading',
      'illustration': 'assets/images/reading.png',
      'description': 'Read a book for an hour'
    },
    {
      'title': 'Coding',
      'illustration': 'assets/images/coding.png',
      'description': 'Coded a Flutter app for 4 hours'
    },
    {
      'title': 'Meditation',
      'illustration': 'assets/images/meditation.png',
      'description': 'Meditated for 30 minutes'
    },
    {
      'title': 'Running',
      'illustration': 'assets/images/running.png',
      'description': 'Ran 5 kilometers in the park'
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 28, 118, 235),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 28, 118, 235),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 8,
                      offset: const Offset(4, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: TableCalendar(
                    focusedDay: DateTime.now(),
                    firstDay: DateTime.utc(2023, 1, 1),
                    lastDay: DateTime.utc(2025, 1, 1),
                    calendarStyle: const CalendarStyle(
                      todayDecoration: BoxDecoration(
                        color: Colors.blueAccent,
                        shape: BoxShape.circle,
                      ),
                    ),
                    calendarBuilders: CalendarBuilders(
                      defaultBuilder: (context, day, focusedDay) {
                        if (emojiEvents.containsKey(day)) {
                          return Center(
                            child: Text(
                              emojiEvents[day]!,
                              style: const TextStyle(fontSize: 20),
                            ),
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Horizontal List of Activities
            SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return GestureDetector(
                    onTap: () {
                      // Show modal with activity details
                      showModalBottomSheet(
                        context: context,
                        builder: (context) {
                          return Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  activity['illustration']!,
                                  height: 150,
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  activity['title']!,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Text(
                                  activity['description']!,
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Card(
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      child: SizedBox(
                        width: 120,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              activity['illustration']!,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              activity['title']!,
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
