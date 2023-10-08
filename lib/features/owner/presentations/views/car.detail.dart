import 'dart:io';

import 'package:drivn/features/owner/data/api/owner.api.dart';
import 'package:drivn/features/owner/domain/entities/vehicle.model.dart';
import 'package:drivn/features/owner/presentations/providers/owner.impl.dart';
import 'package:drivn/features/owner/presentations/widget/car.carousel.dart';
import 'package:drivn/shared/errors/error.alert.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../shared/show.snacbar.dart';
import '../../../../shared/utils/constants/colors.dart';

class CarDetails extends StatelessWidget {
  const CarDetails({super.key, required this.vehicle});
  final Vehicle vehicle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Car details')),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height / 3.5,
              child: CarCarousel(images: vehicle.images),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 20),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Car ID: ${vehicle.registrationNumber}  ',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(fontSize: 20),
                        ),
                        const Icon(Icons.copy)
                      ],
                    ),
                    Text(
                      'Type:   ${vehicle.type}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 20),
                    ),
                    Text(
                      'Brand: ${vehicle.brand}',
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium!
                          .copyWith(fontSize: 20),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star_border_outlined,
                          color: yellow,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            TextSpan(
                              text: '4.8',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium!
                                  .copyWith(fontSize: 20),
                            ),
                            TextSpan(
                              text: '  (200+ review)',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .copyWith(
                                      fontSize: 15,
                                      color: black.withOpacity(.4)),
                            )
                          ]),
                        ),
                        const Spacer(),
                        TextButton(
                            onPressed: () async {
                              final result = await context
                                  .read<OwnerImplProvider>()
                                  .addInsurance('${vehicle.id}');
                              result.fold(
                                  (failure) =>
                                      showErrorDialogue(context, failure),
                                  (success) =>
                                      showCustomSnackBar(context, success));
                            },
                            child: const Text('Add Insurance'))
                      ],
                    ),
                    const Divider(),
                    Text(
                      'All Features',
                      style:
                          Theme.of(context).textTheme.headlineLarge!.copyWith(
                                color: black,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                    ),
                  ],
                ),
              ]),
            ),
          ),
          SliverPadding(
            padding:
                const EdgeInsets.symmetric(horizontal: 10.0).copyWith(top: 20),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisExtent: 150,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  if (vehicle.features.isEmpty) {
                    return const Center(
                      child: Text(
                          'No features available to show for this vehicle'),
                    );
                  }
                  var feature = vehicle.features[index];
                  return Card(
                    surfaceTintColor: white,
                    color: white,
                    shadowColor: white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Icon(Icons.auto_awesome),
                          Text(feature.info),
                          Text(feature.name),
                        ],
                      ),
                    ),
                  );
                },
                childCount: vehicle.features.length,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Visibility(
              visible: vehicle.moreFeatures != null &&
                  vehicle.moreFeatures!.isNotEmpty,
              child: ExpansionTile(
                  backgroundColor: blue.withOpacity(.1),
                  title: const Text('More features'),
                  children: List.generate(
                    vehicle.moreFeatures?.split(',').length ?? 0,
                    (index) {
                      return ListTile(
                        title: Text(vehicle.moreFeatures!.split(',')[index]),
                      );
                    },
                  )),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const ImageIcon(AssetImage('assets/icons/edit.png')),
      ),
    );
  }
}
