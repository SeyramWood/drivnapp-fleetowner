import 'package:drivn_app/features/driver/presentation/views/request.view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';

class DMainPage extends StatelessWidget {
  const DMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: IndexNotifier(),
      builder: (context, value, child) => Scaffold(
        body: IndexedStack(
          index: value,
          children: [RequestView()],
        ),
        bottomNavigationBar: BottomNavigationBar(
          showUnselectedLabels: false,
          showSelectedLabels: false,
          selectedItemColor: red,
          currentIndex: value,
          unselectedItemColor: black.withOpacity(.4),
          onTap: (index) {
            IndexNotifier().setValue(index);
          },
          items: [
            BottomNavigationBarItem(
                icon: ImageIcon(
                  AssetImage('assets/icons/group.png'),
                ),
                label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/car.png')), label: ''),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('assets/icons/note.png')),
                label: ''),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/icons/profile.png'),
              ),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}

class IndexNotifier extends ValueNotifier<int> {
  IndexNotifier.empty() : super(0);
  static final IndexNotifier _empty = IndexNotifier.empty();
  factory IndexNotifier() => _empty;

  setValue(newValue) {
    value = newValue;
    notifyListeners();
  }
}
