import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

showImage({required String imageUrl, double radius = 10}) {
  return CachedNetworkImage(
    imageUrl: imageUrl, // The URL of the image to load
    imageBuilder: (context, imageProvider) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius), // Optional: Apply a border radius to the image
        image: DecorationImage(
          image: imageProvider, // The loaded image provider
          fit: BoxFit.cover, // Optional: Specify how the image should fit in the container
        ),
      ),
    ),
    placeholder: (context, url) =>
        const Center(child: CircularProgressIndicator()), // Placeholder while loading
    errorWidget: (context, url, error) => const Icon(Icons.error), // Widget to display on error
  );
}
