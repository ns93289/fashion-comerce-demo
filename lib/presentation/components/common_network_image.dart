import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../data/dataSources/remote/api_constant.dart';

class CommonNetworkImage extends StatelessWidget {
  final String image;
  final BoxFit? fit;

  const CommonNetworkImage({super.key, required this.image, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: "${BaseUrl.url}$image",
      width: double.maxFinite,
      height: double.maxFinite,
      fit: fit ?? BoxFit.cover,
      fadeInDuration: Duration.zero,
      placeholderFadeInDuration: Duration.zero,
    );
  }
}
