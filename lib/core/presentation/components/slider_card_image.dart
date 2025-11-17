import 'package:flutter/material.dart';
import 'image_with_shimmer.dart';

import '../../resources/app_colors.dart';

class SliderCardImage extends StatelessWidget {
  final String imageUrl;

  const SliderCardImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return ShaderMask(
      blendMode: BlendMode.dstIn,
      shaderCallback: (rect) {
        return LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.black, AppColors.transparent],
          stops: [0.5, 1],
        ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
      },
      child: ImageWithShimmer(
        imageUrl: imageUrl,
        width: double.infinity,
        height: size.height * 0.6,
      ),
    );
  }
}
