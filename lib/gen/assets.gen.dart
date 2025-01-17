/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsFontsGen {
  const $AssetsFontsGen();

  /// File path: assets/fonts/Roboto-Regular.ttf
  String get robotoRegular => 'assets/fonts/Roboto-Regular.ttf';

  /// List of all assets
  List<String> get values => [robotoRegular];
}

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/bitcoin.png
  AssetGenImage get bitcoin => const AssetGenImage('assets/icons/bitcoin.png');

  /// File path: assets/icons/charity.png
  AssetGenImage get charity => const AssetGenImage('assets/icons/charity.png');

  /// File path: assets/icons/empty-cart.png
  AssetGenImage get emptyCart =>
      const AssetGenImage('assets/icons/empty-cart.png');

  /// File path: assets/icons/gift.png
  AssetGenImage get gift => const AssetGenImage('assets/icons/gift.png');

  /// File path: assets/icons/insurance.png
  AssetGenImage get insurance =>
      const AssetGenImage('assets/icons/insurance.png');

  /// File path: assets/icons/investment.png
  AssetGenImage get investment =>
      const AssetGenImage('assets/icons/investment.png');

  /// File path: assets/icons/location-pin.png
  AssetGenImage get locationPin =>
      const AssetGenImage('assets/icons/location-pin.png');

  /// File path: assets/icons/no_image.png
  AssetGenImage get noImage => const AssetGenImage('assets/icons/no_image.png');

  /// File path: assets/icons/remote-control.png
  AssetGenImage get remoteControl =>
      const AssetGenImage('assets/icons/remote-control.png');

  /// File path: assets/icons/shop.png
  AssetGenImage get shop => const AssetGenImage('assets/icons/shop.png');

  /// File path: assets/icons/trolley.png
  AssetGenImage get trolley => const AssetGenImage('assets/icons/trolley.png');

  /// File path: assets/icons/wallet.png
  AssetGenImage get wallet => const AssetGenImage('assets/icons/wallet.png');

  /// List of all assets
  List<AssetGenImage> get values => [
        bitcoin,
        charity,
        emptyCart,
        gift,
        insurance,
        investment,
        locationPin,
        noImage,
        remoteControl,
        shop,
        trolley,
        wallet
      ];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  /// File path: assets/images/banner_1.jpg
  AssetGenImage get banner1 =>
      const AssetGenImage('assets/images/banner_1.jpg');

  /// File path: assets/images/banner_2.jpeg
  AssetGenImage get banner2 =>
      const AssetGenImage('assets/images/banner_2.jpeg');

  /// File path: assets/images/banner_3.jpg
  AssetGenImage get banner3 =>
      const AssetGenImage('assets/images/banner_3.jpg');

  /// List of all assets
  List<AssetGenImage> get values => [banner1, banner2, banner3];
}

class Assets {
  Assets._();

  static const $AssetsFontsGen fonts = $AssetsFontsGen();
  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(
    this._assetName, {
    this.size,
    this.flavors = const {},
  });

  final String _assetName;

  final Size? size;
  final Set<String> flavors;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = true,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
