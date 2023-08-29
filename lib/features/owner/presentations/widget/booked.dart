import 'package:drivn/features/owner/presentations/views/booked.car.detail.page.dart';
import 'package:drivn/shared/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

class BookedCarsBuilder extends StatelessWidget {
  const BookedCarsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return const InfoCard();
      },
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: .5,
        color: white,
        child: Column(children: [
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height / 4.5,
            padding: const EdgeInsets.only(right: 5),
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                image: DecorationImage(
                    image: AssetImage('assets/bg.png'), fit: BoxFit.fitWidth)),
            child: Stack(
              alignment: Alignment.bottomRight,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: SizedBox(
                    // padding: const EdgeInsets.all(8.0),
                    height: 40, width: 90,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).push(PageTransition(
                          type: PageTransitionType.fade,
                          duration: const Duration(milliseconds: 500),
                          child: const MoreOfBookedCar(),
                        ));
                      },
                      style: ElevatedButton.styleFrom(
                          padding:
                              const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          backgroundColor: Colors.red),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text('More', style: TextStyle(fontSize: 12)),
                          SizedBox(width: 8),
                          Icon(Icons.arrow_forward),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                const Tile(
                  leading: 'leadingText',
                  trailing: 'trailingText',
                ),
                Divider(
                  color: black.withOpacity(.1),
                ),
                const Tile(
                  leading: 'leadingText',
                  trailing: 'trailingText',
                ),
                Divider(
                  color: black.withOpacity(.1),
                ),
                const Tile(
                  leading: 'leadingText',
                  trailing: 'trailingText',
                ),
                Divider(
                  color: black.withOpacity(.1),
                ),
                const Tile(
                  leading: 'leadingText',
                  trailing: 'trailingText',
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}

class Tile extends StatelessWidget {
  const Tile({super.key, required this.leading, required this.trailing});
  final String leading;
  final String trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [Text(leading), Text(trailing)],
    );
  }
}
