import 'dart:async';

import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/user/data/api/api.service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/constants/dimensions.dart';
import '../../../auth/presentation/widget/elevated.button.dart';
import '../../domain/entities/v.request.model.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  late Future<List<VRequest>> request;

  final StreamController<List<VRequest>> _streamController = StreamController();
  // ignore: unused_field
  late Timer _timer;
  fetchRequest() async {
    if (mounted) {
      request =
          OwnerApiService().allRequests(context.read<APIService>().userId);
      var streamData = await request;

      if (!_streamController.isClosed) {
        _streamController.sink.add(streamData);
      }
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      fetchRequest();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Request')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: StreamBuilder(
          stream: _streamController.stream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    var request = snapshot.data?[index];
                    return RequestTile(
                      request: request,
                    );
                  });
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text('No available request.'));
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}

class RequestTile extends StatelessWidget {
  const RequestTile({super.key, this.request});
  final VRequest? request;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return BottomSheet(
                builder: (context) => RequestInfo(request: request),
                onClosing: () {},
              );
            },
          );
        },
        child: Material(
          shadowColor: white,
          elevation: 1,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: red.withOpacity(.4),
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundImage:
                      NetworkImage(request!.vehicle.images[0].image),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${request?.rental.customer.firstName} ${request?.rental.customer.lastName}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        // ImageIcon(
                        //   AssetImage('assets/icons/location_tick.png'),
                        // ),
                        Text(
                          request?.rental.customerLocation ?? '',
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('23th July'),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: red.withOpacity(.5),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: const Text('10:57 AM'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class RequestInfo extends StatelessWidget {
  const RequestInfo({super.key, required this.request});
  final VRequest? request;
  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(
      height: 15,
    );
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          space,
          ListTile(
            leading: Image.asset('assets/car1.png'),
            title: Text(
              request?.vehicle.type ?? '',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
            ),
            subtitle: Text(
              'GT - 3452 45',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          space,
          const LocAndTime(),
          space,
          const LocAndTime(),
          space,
          divider,
          space,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Duration',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
              Text('20 hours',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          space,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Amount',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(fontWeight: FontWeight.w600),
              ),
              Text('GHc ${request?.rental.vehicleAmount.toString() ?? 0.00}',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(fontWeight: FontWeight.w600)),
            ],
          ),
          space,
          divider,
          space,
          Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 100,
                  height: 40,
                  child: CustomElevatedButton(
                    backgroundColor: red,
                    onPressed: () {
                      var requestID = request!.id.toString();
                      OwnerApiService().cancelRequest(requestID).then(
                        (value) {
                          Navigator.of(context).pop();
                        },
                      );
                    },
                    child: const Text('reject'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var requestID = request!.id.toString();
                    OwnerApiService().acceptRequest(requestID).then(
                      (value) {
                        Navigator.of(context).pop();

                        showDialog(
                            context: context,
                            builder: (context) => BottomSheet(
                                  builder: (context) => SizedBox(
                                    height: 100,
                                    child: Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: 100,
                                            height: 40,
                                            child: CustomElevatedButton(
                                              backgroundColor: red,
                                              onPressed: () {},
                                              child: const Text('call'),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 20,
                                          ),
                                          ElevatedButton(
                                            onPressed: () {},
                                            child: const Text('Message'),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  onClosing: () {},
                                ));
                      },
                    );
                  },
                  child: const Text('Accept'),
                )
              ],
            ),
          ),
          space,
        ],
      ),
    );
  }
}

class LocAndTime extends StatelessWidget {
  const LocAndTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Car pick up location',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.sizeOf(context).width * .5,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: yellow,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: const Row(
                children: [
                  ImageIcon(
                    AssetImage('assets/icons/location_tick.png'),
                  ),
                  Text(
                    'Circle Main Station',
                  ),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
        Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('23th July, 2023',
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(fontWeight: FontWeight.w500)),
            const SizedBox(height: 5),
            Container(
              width: MediaQuery.sizeOf(context).width * .3,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: yellow,
                  ),
                  borderRadius: BorderRadius.circular(5)),
              child: const Center(child: Text('10:57 AM')),
            )
          ],
        )
      ],
    );
  }
}
