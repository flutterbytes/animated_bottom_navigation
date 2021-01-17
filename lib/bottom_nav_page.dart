import 'package:flutter/material.dart';

class BottomNavPage extends StatefulWidget {
  @override
  _BottomNavPageState createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage>
    with TickerProviderStateMixin {
  AnimationController idleAnimation;
  AnimationController onSelectedAnimation;
  AnimationController onChangedAnimation;

  var selectedIndex = 0;
  var previousIndex;

  Duration animationDuration = Duration(milliseconds: 700);
  @override
  void initState() {
    super.initState();
    idleAnimation = AnimationController(vsync: this);
    onSelectedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
    onChangedAnimation =
        AnimationController(vsync: this, duration: animationDuration);
  }

  @override
  void dispose() {
    super.dispose();
    idleAnimation.dispose();
    onSelectedAnimation.dispose();
    onChangedAnimation.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        currentIndex: selectedIndex,
        iconSize: 32,
        onTap: (index) {
          onSelectedAnimation.reset();
          onSelectedAnimation.forward();

          onChangedAnimation.value = 1;
          onChangedAnimation.reverse();

          setState(() {
            previousIndex = selectedIndex;
            selectedIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: AnimatedIcon(
                icon: AnimatedIcons.home_menu,
                progress: selectedIndex == 0
                    ? onSelectedAnimation
                    : previousIndex == 0
                        ? onChangedAnimation
                        : idleAnimation),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: AnimatedIcon(
                icon: AnimatedIcons.event_add,
                progress: selectedIndex == 1
                    ? onSelectedAnimation
                    : previousIndex == 1
                        ? onChangedAnimation
                        : idleAnimation),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: AnimatedIcon(
                icon: AnimatedIcons.play_pause,
                progress: selectedIndex == 2
                    ? onSelectedAnimation
                    : previousIndex == 2
                        ? onChangedAnimation
                        : idleAnimation),
            label: "Movies",
          ),
        ],
      ),
    );
  }
}
