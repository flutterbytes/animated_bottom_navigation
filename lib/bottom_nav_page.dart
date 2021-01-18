import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

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
        backgroundColor: Colors.black,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey[600],
        currentIndex: selectedIndex,
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
            icon: Lottie.asset("assets/lottie/bookmark.json",
                height: 40,
                controller: selectedIndex == 0
                    ? onSelectedAnimation
                    : previousIndex == 0
                        ? onChangedAnimation
                        : idleAnimation),
            label: "Menu",
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset("assets/lottie/cash.json",
                height: 40,
                controller: selectedIndex == 1
                    ? onSelectedAnimation
                    : previousIndex == 1
                        ? onChangedAnimation
                        : idleAnimation),
            label: "Events",
          ),
          BottomNavigationBarItem(
            icon: Lottie.asset("assets/lottie/credit.json",
                height: 40,
                controller: selectedIndex == 2
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
