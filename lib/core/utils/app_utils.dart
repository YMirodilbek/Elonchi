part of "imports.dart";

sealed class PUtils {
  PUtils._();

  // padding
  static const EdgeInsets kPaddingAll2 = EdgeInsets.all(2);
  static const EdgeInsets kPaddingAll4 = EdgeInsets.all(4);
  static const EdgeInsets kPaddingAll6 = EdgeInsets.all(6);
  static const EdgeInsets kPaddingAll8 = EdgeInsets.all(8);
  static const EdgeInsets kPaddingAll10 = EdgeInsets.all(10);
  static const EdgeInsets kPaddingAll12 = EdgeInsets.all(12);
  static const EdgeInsets kPaddingAll14 = EdgeInsets.all(14);
  static const EdgeInsets kPaddingAll16 = EdgeInsets.all(16);
  static const EdgeInsets kPaddingAll18 = EdgeInsets.all(18);
  static const EdgeInsets kPaddingAll24 = EdgeInsets.all(24);
  static const EdgeInsets kPaddingAll32 = EdgeInsets.all(32);
  static const EdgeInsets kPaddingSymHor16 = EdgeInsets.symmetric(horizontal: 16);
  static const EdgeInsets kPaddingSymHor32 = EdgeInsets.symmetric(horizontal: 32);
  static const EdgeInsets kPaddingSymHor24 = EdgeInsets.symmetric(horizontal: 24);
  static const EdgeInsets kPaddingSymHor12 = EdgeInsets.symmetric(horizontal: 12);
  static const EdgeInsets kPaddingSymHor8 = EdgeInsets.symmetric(horizontal: 8);
  static const EdgeInsets kPaddingSymHor6 = EdgeInsets.symmetric(horizontal: 6);
  static const EdgeInsets kPaddingSymHor4 = EdgeInsets.symmetric(horizontal: 4);
  static const EdgeInsets kPaddingSymVer8 = EdgeInsets.symmetric(vertical: 8);
  static const EdgeInsets kPaddingSymVer16 = EdgeInsets.symmetric(vertical: 16);
  static const EdgeInsets kPaddingSymVer12 = EdgeInsets.symmetric(vertical: 12);
  static const EdgeInsets kPaddingSymVer24 = EdgeInsets.symmetric(vertical: 24);
  static const EdgeInsets kPaddingSymVer10 = EdgeInsets.symmetric(vertical: 10);
  static const EdgeInsets kPaddingSymVer20 = EdgeInsets.symmetric(vertical: 20);
  static const EdgeInsets kPaddingSymVer36 = EdgeInsets.symmetric(vertical: 36);
  static const EdgeInsets kPaddingSymVer6Hor10 = EdgeInsets.symmetric(vertical: 6, horizontal: 10);
  static const EdgeInsets kPaddingSymVer12Hor16 = EdgeInsets.symmetric(vertical: 12, horizontal: 16);
  static const EdgeInsets kPaddingSymVer2Hor10 = EdgeInsets.symmetric(vertical: 2, horizontal: 10);
  static const EdgeInsets kPaddingSymVer2Hor6 = EdgeInsets.symmetric(vertical: 2, horizontal: 6);
  static const EdgeInsets kPaddingSymVer4Hor8 = EdgeInsets.symmetric(vertical: 4, horizontal: 8);
  static const EdgeInsets kPaddingSymVer10Hor12 = EdgeInsets.symmetric(vertical: 10, horizontal: 12);
  static const EdgeInsets kPaddingSymVer10Hor16 = EdgeInsets.symmetric(vertical: 10, horizontal: 16);
  static const EdgeInsets kPaddingSymVer8Hor16 = EdgeInsets.symmetric(vertical: 8, horizontal: 16);
  static const EdgeInsets kPaddingSymVer24Hor16 = EdgeInsets.symmetric(vertical: 24, horizontal: 16);

  // border radius
  static const Radius kRadius = Radius.zero;
  static const BorderRadius kBorderRadius = BorderRadius.zero;
  static const BorderRadius kBorderRadius2 = BorderRadius.all(Radius.circular(2));
  static const BorderRadius kBorderRadius4 = BorderRadius.all(Radius.circular(4));
  static const BorderRadius kBorderRadius8 = BorderRadius.all(Radius.circular(8));
  static const BorderRadius kBorderRadius12 = BorderRadius.all(Radius.circular(12));
  static const BorderRadius kBorderRadius14 = BorderRadius.all(Radius.circular(14));
  static const BorderRadius kBorderRadius10 = BorderRadius.all(Radius.circular(10));
  static const BorderRadius kBorderRadius16 = BorderRadius.all(Radius.circular(16));
  static const BorderRadius kBorderRadius20 = BorderRadius.all(Radius.circular(20));
  static const BorderRadius kBorderRadius24 = BorderRadius.all(Radius.circular(24));
  static const BorderRadius kBorderRadius64 = BorderRadius.all(Radius.circular(64));
  static const BorderRadius kBorderRadius100 = BorderRadius.all(Radius.circular(100));
  static const BorderRadius kBorderRadiusTop8 = BorderRadius.only(
    topLeft: Radius.circular(8),
    topRight: Radius.circular(8),
  );
  static const BorderRadius kBorderRadiusTop16 = BorderRadius.only(
    topLeft: Radius.circular(16),
    topRight: Radius.circular(16),
  );
  static const BorderRadius kBorderRadiusBottom12 = BorderRadius.only(
    bottomLeft: Radius.circular(12),
    bottomRight: Radius.circular(12),
  );
  static const BorderRadius kBorderRadiusBottom16 = BorderRadius.only(
    bottomLeft: Radius.circular(16),
    bottomRight: Radius.circular(16),
  );
}
