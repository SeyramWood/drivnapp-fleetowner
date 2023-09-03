import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../widget/request.tile.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  int _selectedDropdownValue = 1;
  bool _isOffline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Request')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: DropdownButton<int>(
                      iconSize: 30,
                      underline: Container(),
                      value: _selectedDropdownValue,
                      onChanged: (value) {
                        setState(() {
                          _selectedDropdownValue = value!;
                        });
                      },
                      items: const [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            'Accra, Ghana',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            'Kumasi, Ghana',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text(
                            'Takoradi, Ghana',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const Text('Offline'),
                  Transform.scale(
                    scale: 0.6, // Adjust the scale value as needed
                    child: Switch(
                      activeColor: red,
                      onChanged: (value) {
                        setState(() {
                          _isOffline = value;
                        });
                      },
                      value: _isOffline,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return const RequestTile();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
