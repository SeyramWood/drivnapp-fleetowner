import 'dart:async';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/driver/domain/entities/request.model.dart';
import 'package:drivn/features/driver/presentation/provider/driver.impl.provider.dart';
import 'package:drivn/features/driver/presentation/provider/toggle.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/errors/network.error.dart';
import '../../../../shared/utils/shared.prefs.manager.dart';
import '../widget/request.tile.dart';

class RequestView extends StatefulWidget {
  const RequestView({super.key});

  @override
  State<RequestView> createState() => _RequestViewState();
}

class _RequestViewState extends State<RequestView> {
  bool isOnline = true;
  late Future<List<DRequest>> request;
  final StreamController<List<DRequest>> _streamController = StreamController();
  // ignore: unused_field
  late Timer _timer;
  getAllRequest() async {
    //try fetch only when user is ready to work
    if (GoOnline().value == true) {
      dynamic data;

      if (mounted && !_streamController.isClosed) {
        try {
          data = await context
              .read<DriverImplProvider>()
              .fetchRequest(context.read<UserAuthProvider>().userID);
        } catch (e) {
          return NetworkErrorHandler.handleNetworkError(context, e);
        }
        if (data is List<DRequest>) {
          var streamData = data;

          _streamController.sink.add(streamData);
        }
      }
    }
  }

  void checkIfReviewed() {
    //notify the driver when document hasn't be or fully reviewed
    String cardStatus = prefs.getString('cardStatus', '');
    String licenseStatus = prefs.getString('licenseStatus', '');

    if (cardStatus == 'unreviewed' && licenseStatus == 'unreviewed') {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        showCloseIcon: true,
        duration: Duration(seconds: 60),
        content: Text('Your documents has not been fully reviewed'),
      ));
    }
  }

  @override
  void initState() {
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => checkIfReviewed());
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      getAllRequest();
    });

    super.initState();
  }

  final prefs = SharedPreferencesManager.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: const Text('Requests')),
      body: ValueListenableBuilder(
        valueListenable: GoOnline(),
        builder: (context, value, _) {
          return SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0)
                  .copyWith(top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      SizedBox(
                          // height: 50,
                          // width: MediaQuery.of(context).size.width / 2,
                          // child: DropdownButton<int>(
                          //   iconSize: 30,
                          //   underline: Container(),
                          //   value: _selectedDropdownValue,
                          //   onChanged: (value) {
                          //     setState(() {
                          //       _selectedDropdownValue = value!;
                          //     });
                          //   },
                          //   items: const [
                          //     DropdownMenuItem<int>(
                          //       value: 1,
                          //       child: Text(
                          //         'Accra, Ghana',
                          //         style: TextStyle(fontSize: 13),
                          //       ),
                          //     ),
                          //     DropdownMenuItem<int>(
                          //       value: 2,
                          //       child: Text(
                          //         'Kumasi, Ghana',
                          //         style: TextStyle(fontSize: 13),
                          //       ),
                          //     ),
                          //     DropdownMenuItem<int>(
                          //       value: 3,
                          //       child: Text(
                          //         'Takoradi, Ghana',
                          //         style: TextStyle(fontSize: 15),
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          child: Center(
                        child: Text(
                          'All Requests',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      )),
                      const Spacer(),
                      //alter driver status here
                      Text(value ? 'Online' : 'Offline'),
                      Transform.scale(
                        scale: 0.6,
                        child: Switch(
                          activeColor: red,
                          onChanged: (newValue) async {
                            GoOnline().goOnline(newValue);
                            await context.read<DriverImplProvider>().goOnline(
                                context.read<UserAuthProvider>().userID,
                                value ? 'offline' : 'online');
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
                      //notify the driver when offline
                      if (value == false) {
                        return const Align(
                          alignment: Alignment.topCenter,
                          child: ListTile(
                            tileColor: red,
                            textColor: white,
                            leading: ImageIcon(
                              AssetImage('assets/icons/network.png'),
                            ),
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
