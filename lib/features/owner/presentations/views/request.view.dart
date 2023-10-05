import 'dart:async';

import 'package:drivn/features/auth/presentation/providers/user.auth.provider.dart';
import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import 'package:drivn/shared/utils/cached.network.image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/utils/audio.player.dart';
import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/constants/date_time.formatting.dart';
import '../../../../shared/utils/constants/dimensions.dart';
import '../../../auth/presentation/widget/elevated.button.dart';
import '../../domain/entities/v.request.model.dart';

class RequestsView extends StatefulWidget {
  const RequestsView({super.key});

  @override
  State<RequestsView> createState() => _RequestsViewState();
}

class _RequestsViewState extends State<RequestsView> {
  var streamData;

  final StreamController<List<VRequest>> _streamController = StreamController();
  // ignore: unused_field
  late Timer _timer;
  fetchRequest() async {
    if (mounted) {
      await context
          .read<OwnerImplProvider>()
          .fetchRequests(
            context.read<UserAuthProvider>().userID,
          )
          .then(
        (value) {
          if (value is List<VRequest>) {
            streamData = value;
          }
        },
      );

      if (!_streamController.isClosed) {
        _streamController.sink.add(streamData);
      }
    }
  }

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
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

class RequestTile extends StatefulWidget {
  const RequestTile({super.key, this.request});
  final VRequest? request;

  @override
  State<RequestTile> createState() => _RequestTileState();
}

class _RequestTileState extends State<RequestTile>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

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
                animationController: animationController,
                builder: (context) => RequestInfo(request: widget.request),
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
                  child: Text(widget.request!.rental.customer.firstName[0]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${widget.request?.rental.customer.firstName} ${widget.request?.rental.customer.lastName}',
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
                          widget.request?.rental.customerLocation ?? '',
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      date.format(widget.request!.createdAt),
                    ),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: red.withOpacity(.5),
                        ),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        time.format(widget.request!.createdAt),
                      ),
                    ),
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
            leading: SizedBox(
                width: 80,
                child: showImage(imageUrl: request!.vehicle.images[0].image)),
            title: Text(
              request?.vehicle.type ?? '',
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
            ),
            subtitle: Text(
              request?.vehicle.id.toString() ?? '',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          space,
          LocAndTime(
            rentInfo: request,
          ),
          space,
          // LocAndTime(rentInfo: request),
          if (request?.rental.customerLocationAudio != null)
            AudioPlayer(source: request!.rental.customerLocationAudio),
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
              Text(
                  '${DateTime.parse(request!.rental.returnTime.toIso8601String()).difference(DateTime.parse(request!.rental.pickupTime.toIso8601String())).inHours} Hours',
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
                      showDialog(
                        barrierDismissible: false,
                        context: context,
                        builder: (context) {
                          final controller = TextEditingController();
                          return AlertDialog(
                            content: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: red),
                                    borderRadius: BorderRadius.circular(5)),
                                child: TextFormField(
                                  controller: controller,
                                  maxLines: 4,
                                  decoration: const InputDecoration(
                                      contentPadding: EdgeInsets.all(5),
                                      hintText: 'reason to decline',
                                      border: InputBorder.none),
                                )),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).pop(),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  print(requestID);
                                  context
                                      .read<OwnerImplProvider>()
                                      .cancelRequest(requestID, controller.text)
                                      .then(
                                    (value) {
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                child: const Text(
                                  'Continue',
                                  style: TextStyle(color: red),
                                ),
                              )
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Decline'),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    var requestID = request!.id.toString();
                    context
                        .read<OwnerImplProvider>()
                        .acceptRequest(requestID)
                        .then(
                      (value) {
                        Navigator.of(context).pop();

                        // showDialog(
                        //     context: context,
                        //     builder: (context) => BottomSheet(
                        //           builder: (context) => SizedBox(
                        //             height: 100,
                        //             child: Center(
                        //               child: Row(
                        //                 mainAxisAlignment:
                        //                     MainAxisAlignment.center,
                        //                 children: [
                        //                   SizedBox(
                        //                     width: 100,
                        //                     height: 40,
                        //                     child: CustomElevatedButton(
                        //                       backgroundColor: red,
                        //                       onPressed: () {},
                        //                       child: const Text('call'),
                        //                     ),
                        //                   ),
                        //                   const SizedBox(
                        //                     width: 20,
                        //                   ),
                        //                   ElevatedButton(
                        //                     onPressed: () {},
                        //                     child: const Text('Message'),
                        //                   )
                        //                 ],
                        //               ),
                        //             ),
                        //           ),
                        //           onClosing: () {},
                        //         ));
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
  const LocAndTime({super.key, required this.rentInfo});
  final VRequest? rentInfo;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cutomer location',
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
              child: Row(
                children: [
                  const ImageIcon(
                    AssetImage('assets/icons/location_tick.png'),
                  ),
                  Text(
                    rentInfo!.rental.customerLocation,
                    style: const TextStyle(overflow: TextOverflow.ellipsis),
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
            Text(date.format(rentInfo!.rental.pickupDate),
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
              child:
                  Center(child: Text(time.format(rentInfo!.rental.pickupDate))),
            )
          ],
        )
      ],
    );
  }
}
