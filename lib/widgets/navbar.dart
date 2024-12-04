import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class Navbar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const Navbar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: PhosphorIcon(
            currentIndex == 0
                ? PhosphorIconsBold.house
                : PhosphorIconsRegular.house,
            size: 32,
            color: Colors.black,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: PhosphorIcon(
            currentIndex == 1
                ? PhosphorIconsBold.magnifyingGlass
                : PhosphorIconsRegular.magnifyingGlass,
            size: 32,
            color: Colors.black,
          ),
          label: 'Explore',
        ),
        BottomNavigationBarItem(
          icon: PhosphorIcon(
            currentIndex == 2
                ? PhosphorIconsBold.plusSquare
                : PhosphorIconsRegular.plusSquare,
            size: 32,
            color: Colors.black,
          ),
          label: 'New Post',
        ),
        BottomNavigationBarItem(
          icon: PhosphorIcon(
            currentIndex == 3
                ? PhosphorIconsBold.userCircle
                : PhosphorIconsRegular.userCircle,
            size: 32,
            color: Colors.black,
          ),
          label: 'Profile',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.black54,
    );
  }
}