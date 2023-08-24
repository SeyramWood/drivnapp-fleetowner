import 'package:drivn_app/features/driver/presentation/views/my.trips.dart';
import 'package:drivn_app/features/driver/presentation/views/request.view.dart';
import 'package:drivn_app/features/driver/presentation/views/summary.view.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../user/presentation/view/driver.profile.view.dart';
import '../provider/index.notifier.dart';

class DMainPage extends StatelessWidget {
  const DMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: IndexNotifier(),
      builder: (context, value, child) => Scaffold(
        body: IndexedStack(
          index: value,
          children: [
            RequestView(),
            MyTrips(),
            SummaryView(),
            DProfileView(),
          ],
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
