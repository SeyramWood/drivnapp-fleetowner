import 'package:drivn/features/car/presentations/views/add.car.form.dart';
import 'package:drivn/features/car/presentations/views/my.cars.dart';
import 'package:flutter/material.dart';

import '../features/user/presentation/view/profile.view.dart';
import '../shared/utils/constants/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
