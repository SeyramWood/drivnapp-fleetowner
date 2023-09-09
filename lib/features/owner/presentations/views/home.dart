import 'package:drivn/features/owner/presentations/views/add.car.form.dart';
import 'package:drivn/features/owner/presentations/views/my.cars.dart';
import 'package:drivn/features/owner/presentations/views/request.view.dart';
import 'package:flutter/material.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: IndexNotifier(),
      builder: (context, value, child) {
        return Scaffold(
          body: IndexedStack(
            index: value,
            children: const [
              RequestsView(),
              MyCars(),
              AddFleetForm(),
              ProfileView(),
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
            items: const [
              BottomNavigationBarItem(
                  icon: ImageIcon(
                    AssetImage('assets/icons/group.png'),
                  ),
                  label: ''),
              BottomNavigationBarItem(
                  icon: ImageIcon(AssetImage('assets/icons/car.png')),
                  label: ''),
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
      },
    );
  }
}

//this class toggles the index changes in the main page
class IndexNotifier extends ValueNotifier<int> {
  IndexNotifier.empty() : super(0);
  static final IndexNotifier _empty = IndexNotifier.empty();
  factory IndexNotifier() => _empty;

  setValue(newValue) {
    value = newValue;
    notifyListeners();
  }
}
