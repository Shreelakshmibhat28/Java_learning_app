import 'package:flutter/material.dart';
import 'Contents Directory/Course.dart';
import 'Contents Directory/Home.dart';

void main() => runApp(const MaterialApp(
  home: ContentsPage(),
  debugShowCheckedModeBanner: false,
));

class ContentsPage extends StatefulWidget {
  const ContentsPage({super.key});

  @override
  State<ContentsPage> createState() => _ContentsPageState();
}

class _ContentsPageState extends State<ContentsPage> {
  int myIndex = 0; // Setting the index of the bottom bar
  List<Widget> widgetList = [const Home(), const Course()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set the background color
      body: Center(child: widgetList[myIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.indigo.shade900, // Set the background color of the bottom navigation bar
        selectedItemColor: Colors.white, // Set the color of the selected item
        unselectedItemColor: Colors.grey.shade400, // Set the color of unselected items
        // Bottom Navigation bar
        onTap: (index) {
          setState(() {
            myIndex = index; // onTap state changes based on index
          });
        },
        currentIndex:
        myIndex, // currentIndex will set to the initial index of the state
        items: [
          BottomNavigationBarItem(
            icon: GestureDetector(child: const Icon(Icons.home_filled)),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_rounded),
            label: 'Course',
          ),
        ],
      ),
    );
  }
}
