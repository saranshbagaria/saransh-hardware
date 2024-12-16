import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../appConst/app_images.dart';
import 'common_app_shimmer.dart';

class ReusableImageWithShimmer extends StatelessWidget {
  const ReusableImageWithShimmer({
    super.key,
    required this.url,
    required this.height,
    this.width,
    this.onTap,
    this.isCircle = true,
    this.boxFit = BoxFit.cover,
    this.placeholderUrl = AppImages.imgPlaceHolder,
    this.isBackDrop = false,
    this.borderRadius = 0.0,
    this.isProfile = false,
    this.errorWidget,
    this.shimmerBuilder,
    this.imageBuilder,
    this.fadeInDuration = const Duration(milliseconds: 500),
    this.fadeOutDuration = const Duration(milliseconds: 1000),
    this.memCacheHeight,
    this.memCacheWidth,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
    this.filterQuality = FilterQuality.low,
    this.placeholderFadeInDuration = Duration.zero,
    this.alignment = Alignment.center,
    this.repeat = ImageRepeat.noRepeat,
    this.matchTextDirection = false,
    this.useOldImageOnUrlChange = false,
    this.color,
    this.placeholderBuilder,
  });

  final double height;
  final double? width;
  final String url;
  final bool isCircle;
  final bool isBackDrop;
  final BoxFit boxFit;
  final String placeholderUrl;
  final void Function()? onTap;
  final double borderRadius;
  final bool isProfile;
  final Widget Function(BuildContext, String, dynamic)? errorWidget;
  final Widget Function(BuildContext, String)? shimmerBuilder;
  final Widget Function(BuildContext, ImageProvider<Object>)? imageBuilder;
  final Duration fadeInDuration;
  final Duration fadeOutDuration;
  final int? memCacheHeight;
  final int? memCacheWidth;
  final int? maxWidthDiskCache;
  final int? maxHeightDiskCache;
  final FilterQuality filterQuality;
  final Duration placeholderFadeInDuration;
  final Alignment alignment;
  final ImageRepeat repeat;
  final bool matchTextDirection;
  final bool useOldImageOnUrlChange;
  final Color? color;
  final Widget Function(BuildContext)? placeholderBuilder;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(isCircle ? height / 2 : borderRadius),
        child: SizedBox(
          height: height,
          width: width ?? height,
          child: url.isNotEmpty
              ? CachedNetworkImage(
            imageUrl: url,
            errorWidget: errorWidget ?? _defaultPlaceholder,
            fit: boxFit,
            placeholder: shimmerBuilder ?? _defaultShimmerBuilder,
            imageBuilder: imageBuilder,
            fadeInDuration: fadeInDuration,
            fadeOutDuration: fadeOutDuration,
            memCacheHeight: memCacheHeight,
            memCacheWidth: memCacheWidth,
            maxWidthDiskCache: maxWidthDiskCache,
            maxHeightDiskCache: maxHeightDiskCache,
            filterQuality: filterQuality,
            placeholderFadeInDuration: placeholderFadeInDuration,
            alignment: alignment,
            repeat: repeat,
            matchTextDirection: matchTextDirection,
            useOldImageOnUrlChange: useOldImageOnUrlChange,
            color: color,
          )
              : errorWidget?.call(context, url, 'Empty URL') ?? _defaultPlaceholder(context, url, 'Empty URL'),
        ),
      ),
    );
  }

  Widget _defaultPlaceholder(BuildContext context, String url, dynamic error) {
    return SvgPicture.asset(
      isProfile ? AppImages.imgDummyProfile : placeholderUrl,
      fit: BoxFit.cover,
    );
  }

  Widget _defaultShimmerBuilder(BuildContext context, String url) {
    return isCircle
        ? CommonAppShimmer.circular(height: height)
        : CommonAppShimmer.rectangular(height: height);
  }
}