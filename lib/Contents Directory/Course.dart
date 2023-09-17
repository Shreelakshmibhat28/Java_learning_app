import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DataList {
  final String title;
  final String content;
  final String notesFile; // JSON notes file
  bool isLiked;

  DataList(this.title, this.content, this.notesFile, {this.isLiked = false});
}

class Course extends StatefulWidget {
  const Course({super.key});

  @override
  _CourseState createState() => _CourseState();
}

class _CourseState extends State<Course> {
  final List<DataList> data = <DataList>[
    DataList('Introduction to JAVA', 'History & JVM','Introduction to java.json'),
    DataList('Basic Syntax and Data Types', 'variables and datatypes, operators, input and output','Datatypes.json'),
    DataList('Control Flow', 'Conditional statements, Looping structures, break & continue statements','Control flow.json'),
    DataList('Functions and methods', 'Declaring and calling methods, Method parameters & Method overloading','functions.json'),
    DataList('Object-Oriented Programming', 'Classes and objects, Constructors, Inheritance, Polymorphism, Encapsulation & Access Modifiers','oop.json'),
    DataList('Exception Handling', 'Try-catch blocks, Throwing and Custom Exceptions','Exception.json'),
    DataList('Arrays and Collections', 'ArrayLists, LinkedLists, and other Java collections','Arrays.json'),
    DataList('File Handling', 'Reading and writing files, Buffered reader & writer, serialization and deserialization','File handling.json'),
    DataList('Multithreading', 'Creating and managing threads, Synchronization, Thread safety and concurrent programming','Multithreading.json'),
    DataList('Java API', 'Built-in classes and libraries','java API.json'),
    DataList('JDBC (Java Database Connectivity)', 'Connecting to databases, CRUD operations','JDBC.json'),
    DataList('Advanced topics', 'Lambdas, Streams, Reflection and Networking','Advanced.json'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        title: const Text('SYLLABUS (JAVA Programming)', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.blue.shade600,
              Colors.blue.shade200,
              Colors.blue.shade200,
              Colors.blue.shade600,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _buildExpandableList(data),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExpandableList(List<DataList> dataList) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: dataList.length,
      itemBuilder: (BuildContext context, int index) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.white),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ExpansionTile(
                  title: Text(dataList[index].title),
                  children: [
                    Text(dataList[index].content),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.thumb_up,
                            color: dataList[index].isLiked ? Colors.blue : Colors.grey,
                          ),
                          onPressed: () {
                            setState(() {
                              dataList[index].isLiked = !dataList[index].isLiked;
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.note,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            _showNotesScreen(context, dataList[index].notesFile);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showNotesScreen(BuildContext context, String notesFile) async {
    final jsonString = await rootBundle.loadString('assets/notes/$notesFile');
    final notesData = json.decode(jsonString);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => NotesScreen(notesData: notesData),
      ),
    );
  }
}

class NotesScreen extends StatelessWidget {
  final Map<String, dynamic> notesData;

  const NotesScreen({super.key, required this.notesData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notes'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var entry in notesData.entries)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  '${entry.key}: ${entry.value}',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

void main() => runApp(const MaterialApp(home: Course()));
