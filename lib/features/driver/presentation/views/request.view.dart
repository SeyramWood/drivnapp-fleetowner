import 'package:flutter/material.dart';
import '../widget/request.tile.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            children: [
              Row(
                children: [
                  SizedBox(
                    height: 50,
                    width: MediaQuery.sizeOf(context).width / 2,
                    child: DropdownButton<int>(
                      iconSize: 30,
                      underline: Container(),
                      value: 1,
                      onChanged: (value) {},
                      items: [
                        DropdownMenuItem<int>(
                          value: 1,
                          child: Text(
                            'Accra,Ghana',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 2,
                          child: Text(
                            'Ride sharing',
                            style: TextStyle(fontSize: 13),
                          ),
                        ),
                        DropdownMenuItem<int>(
                          value: 3,
                          child: Text(
                            'Rental',
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(),
                  Text('offline'),
                  Transform.scale(
                    scale: 0.8,
                    child: Switch(
                      onChanged: (value) {},
                      value: false,
                    ),
                  )
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return RequestTile();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
