import 'package:evans_translator/screens/gallery_page.dart';
import 'package:evans_translator/screens/home-page.dart';
import 'package:evans_translator/widgets/bottom_bar_navigation_pattern/animated_bottom_bar.dart';
import 'package:flutter/material.dart';


class BottomNav_C extends StatefulWidget {
  final List<Widget> _children = [HomePage(title: 'Evans Translator'),GalleryPage()];
  final List<BarItem> barItems = [
    BarItem(
      text: "Home",
      iconData: Icons.home,
      color: Colors.indigo,
    ),
    BarItem(
      text: "Gallary",
      iconData: Icons.photo_album,
      color: Colors.pinkAccent,
    ),
  ];

  @override
  _BottomNav_CState createState() =>
      _BottomNav_CState();
}

class _BottomNav_CState extends State<BottomNav_C> {
  int selectedBarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:widget._children[selectedBarIndex], 
      
      bottomNavigationBar: AnimatedBottomBar(
          barItems: widget.barItems,
          animationDuration: const Duration(milliseconds: 150),
          barStyle: BarStyle(
            fontSize: 20.0,
            iconSize: 30.0
          ),
          onBarTap: (index) {
            setState(() {
              selectedBarIndex = index;
            });
          }),
    );
  }
}
