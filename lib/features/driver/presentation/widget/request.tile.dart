import 'package:drivn/features/driver/presentation/widget/request.dialog.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class RequestTile extends StatelessWidget {
  const RequestTile({super.key});

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
                builder: (context) => const RequestInfo(),
                onClosing: () {},
              );
            },
          );
        },
        child: Material(
          shadowColor: white,
          elevation: 5,
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 10,
              horizontal: 5,
            ),
            decoration: BoxDecoration(
                border: Border.all(
                  color: yellow,
                ),
                borderRadius: BorderRadius.circular(5)),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 28,
                ),
                const SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'John Doe',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                    const Row(
                      children: [
                        ImageIcon(
                          AssetImage('assets/icons/location_tick.png'),
                        ),
                        Text(
                          'Circle Main Station',
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
                            color: yellow,
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
