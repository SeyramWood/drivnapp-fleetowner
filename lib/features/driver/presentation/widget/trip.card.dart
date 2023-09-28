import 'package:drivn/features/driver/domain/entities/trips.model.dart';
import 'package:drivn/shared/utils/constants/dimensions.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/audio.player.dart';
import '../../../../shared/utils/constants/colors.dart';
import '../../../../shared/utils/constants/date_time.formatting.dart';
import '../../../auth/presentation/widget/elevated.button.dart';
import '../../data/api/driver.api.service.dart';

class TripCard extends StatefulWidget {
  const TripCard({super.key, required this.tripInfo});
  final DTrip? tripInfo;

  @override
  State<TripCard> createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    var space = const SizedBox(
      height: 15,
    );
    return Card(
      surfaceTintColor: white,
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            space,
            DateNTime(
              tripInfo: widget.tripInfo,
              title: 'Car pick up location',
              subtitle: widget.tripInfo!.rental.customerLocation,
              daTe: widget.tripInfo!.rental.pickupDate,
            ),
            space,
            DateNTime(
              tripInfo: widget.tripInfo,
              title: 'Car return location',
              subtitle: widget.tripInfo!.rental.customerLocation,
              daTe: widget.tripInfo!.rental.returnDate,
            ),
            space,
            ExpansionTile(
              title: Text(isExpanded ? 'show less' : 'show more'),
              onExpansionChanged: (value) {
                setState(() {
                  isExpanded = value;
                });
              },
              children: [
                AudioPlayer(
                    source: widget.tripInfo!.rental.customerLocationAudio),
                space,
                divider,
                space,
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Duration',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${widget.tripInfo!.rental.returnDate.difference(widget.tripInfo!.rental.pickupDate).inHours.toString()} hour(s)',
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .copyWith(fontWeight: FontWeight.w600),
                    ),
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
                    Text(
                        'GHC ${widget.tripInfo!.rental.driverAmount.toString()}',
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(fontWeight: FontWeight.w600)),
                  ],
                ),
                space,
              ],
            ),
            // divider,
            Visibility(
              visible: widget.tripInfo?.tripStatus == 'ended' ? false : true,
              child: Column(
                children: [
                  space,
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: CustomElevatedButton(
                            backgroundColor:
                                widget.tripInfo?.tripStatus != 'started'
                                    ? blue
                                    : grey,
                            onPressed: widget.tripInfo?.tripStatus != 'started'
                                ? () {
                                    var bookingID =
                                        widget.tripInfo!.id.toString();
                                    DriverApiService()
                                        .updateTripStatus(bookingID, 'started');
                                  }
                                : null,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.start),
                                Text('Start trip'),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                          width: 140,
                          height: 40,
                          child: CustomElevatedButton(
                            backgroundColor:
                                widget.tripInfo?.tripStatus == 'started'
                                    ? red
                                    : grey,
                            onPressed: widget.tripInfo?.tripStatus == 'started'
                                ? () {
                                    var bookingID =
                                        widget.tripInfo!.id.toString();
                                    DriverApiService()
                                        .updateTripStatus(bookingID, 'ended');
                                  }
                                : null,
                            child: const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(Icons.stop_circle_outlined),
                                Text('End trip'),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  space,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class DateNTime extends StatelessWidget {
  const DateNTime({
    super.key,
    required this.tripInfo,
    required this.title,
    required this.subtitle,
    required this.daTe,
  });
  final DTrip? tripInfo;
  final String title;
  final String subtitle;
  final DateTime daTe;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
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
                    subtitle,
                  ),
                ],
              ),
            )
          ],
        ),
        const Spacer(),
        Column(
          children: [
            Text(date.format(daTe),
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
              child: Center(child: Text(time.format(daTe))),
            )
          ],
        )
      ],
    );
  }
}
