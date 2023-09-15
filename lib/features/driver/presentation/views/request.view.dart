import 'dart:async';

import 'package:drivn/features/driver/data/api/driver.api.service.dart';
import 'package:drivn/features/driver/domain/entities/request.model.dart';
import 'package:drivn/features/driver/presentation/provider/toggle.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/request.tile.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  int _selectedDropdownValue = 1;
  late Future<List<DRequest>> request;
  final StreamController<List<DRequest>> _streamController = StreamController();
  // ignore: unused_field
  late Timer _timer;
  getAllRequest() async {
    request =
        DriverApiService().fetchRequest(context.read<APIService>().userId);

    if (mounted) {
      var streamData = await request;

      if (!_streamController.isClosed) {
        _streamController.sink.add(streamData);
      }
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getAllRequest();
    });
    super.initState();
  }

  String driverStatus = 'Online';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Requests')),
      body: ValueListenableBuilder(
        valueListenable: GoOnline(),
        builder: (context, value, _) {
          return SafeArea(
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
                      //alter driver status here
                      Text(value ? 'Online' : 'Offline'),
                      Transform.scale(
                        scale: 0.6,
                        child: Switch(
                          activeColor: red,
                          onChanged: (newValue) {
                            GoOnline().goOnline(newValue);
                            DriverApiService().goOnline(
                                context.read<APIService>().userId,
                                value ? 'true' : 'false');
                          },
                          value: value,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                      child: StreamBuilder<List<DRequest>>(
                    stream: _streamController.stream,
                    builder: (context, snapshot) {
                      if (value == false) {
                        return const Align(
                          alignment: Alignment.topCenter,
                          child: ListTile(
                            tileColor: red,
                            textColor: white,
                            title: Text('Your are offline'),
                            subtitle: Text('Go online to see request'),
                          ),
                        );
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasData &&
                          snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (context, index) {
                            var request = snapshot.data?[index];
                            return RequestTile(request: request);
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Center(
                          child: Text('Error: ${snapshot.error}'),
                        );
                      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                        return const Center(
                            child: Text('No available request.'));
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
