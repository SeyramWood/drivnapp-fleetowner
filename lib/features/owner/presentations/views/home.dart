
import 'package:drivn/features/owner/presentations/views/add.car.form.dart';
import 'package:drivn/features/owner/presentations/views/my.cars.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../user/data/api/api.service.dart';
import '../../../user/presentation/view/profile.view.dart';
import '../../../../shared/utils/constants/colors.dart';
import '../../../vehicle/data/api/vehicle.api.service.dart';

class OMainPage extends StatefulWidget {
  const OMainPage({super.key});

  @override
  State<OMainPage> createState() => _OMainPageState();
}

class _OMainPageState extends State<OMainPage> {
  VehicleApiService apiService = VehicleApiService();
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
    initializeData();
  }

  Future<void> initializeData() async {
    apiService
      ..fetchBrands()
      ..fetchFeatures()
      ..fetchTypes();

    // Call getID and await its completion
    // await APIService().getID();
    if (!mounted) return;
    // Once getID completes, you can access the updated user ID
  }

  @override
  Widget build(BuildContext context) {
    print('123: ${Provider.of<APIService>(context, listen: true).userId}');

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: const [MyCars(), AddFleetForm(), ProfileView()],
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
