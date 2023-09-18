import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

showImage({required String imageUrl, double radius = 10}) {
  return CachedNetworkImage(
    imageUrl: imageUrl,
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        image: DecorationImage(
          image: imageProvider,
          fit: BoxFit.cover,
          // colorFilter: const ColorFilter.mode(
          //   Colors.red,
          //   BlendMode.colorBurn,
          // ),
        ),
      ),
    ),
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()),
    errorWidget: (context, url, error) => const Icon(Icons.error),
  );
}
