import 'package:evans_translator/screens/gallery_page.dart';
import 'package:evans_translator/screens/home-page.dart';
import 'package:flutter/material.dart';

class BottomNav_D extends StatefulWidget {
  @override
  _BottomNav_DState createState() => _BottomNav_DState();
}

class _BottomNav_DState extends State<BottomNav_D> {
  int _currentIndex = 0;
  final List<Widget> _children = [HomePage(title: 'Evans Translator'),GalleryPage()];

  void onTappedBar(int index){
    setState(() {
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTappedBar,
        currentIndex: _currentIndex,
        items: [
              BottomNavigationBarItem
              (
                 icon: Icon(Icons.home) ,
                title: Text("Home")
               ),

               BottomNavigationBarItem
              (
                 icon: Icon(Icons.settings) ,
                title: Text("Settings")
               ),
        ]
        
      ),
    );
  }
}