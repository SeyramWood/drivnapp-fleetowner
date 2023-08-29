import 'package:drivn/features/owner/presentations/views/add.car.form.dart';
import 'package:drivn/features/owner/presentations/views/my.cars.dart';
import 'package:flutter/material.dart';

import '../../../user/presentation/view/profile.view.dart';
import '../../../../shared/utils/constants/colors.dart';

class OMainPage extends StatefulWidget {
  const OMainPage({super.key});

  @override
  State<OMainPage> createState() => _OMainPageState();
}

class _OMainPageState extends State<OMainPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [MyCars(), Add_A_Car_Form(), ProfileView()],
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: false,
        showSelectedLabels: false,
        selectedItemColor: red,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/car.png')), label: ''),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/icons/add-square.png')),
              label: ''),
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage('assets/icons/profile.png'),
            ),
            label: '',
          ),
        ],
      ),
    );
  }
}
