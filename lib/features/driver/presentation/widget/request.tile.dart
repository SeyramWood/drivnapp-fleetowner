import 'package:drivn/features/driver/presentation/widget/request.dialog.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

import '../../../../shared/utils/constants/date_time.formatting.dart';
import '../../domain/entities/request.model.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({super.key, this.request});
  final DRequest? request;
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
                  child: Text(request!.rental.customer.firstName[0]),
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${request!.rental.customer.firstName} ${request!.rental.customer.lastName}',
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
                          request!.rental.customerLocation,
                        ),
                      ],
                    )
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(date.format(request!.createdAt)),
                    const SizedBox(height: 5),
                    Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: red.withOpacity(.5),
                          ),
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(time.format(request!.createdAt)),
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
