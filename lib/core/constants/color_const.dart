import 'package:flutter/material.dart';

class ColorConst {
  ColorConst._();

  static const Color primary50 = Color(0xffe5e5f1);
  static const Color primary100 = Color(0xffbebedd);
  static const Color primary200 = Color(0xff9494c5);
  static const Color primary300 = Color(0xff6b6baf);
  static const Color primary400 = Color(0xff4e4c9f);
  static const Color primary500 = Color(0xff312e8f);
  static const Color primary600 = Color(0xff2c2886);
  static const Color primary700 = Color(0xff241e7b);
  static const Color primary800 = Color(0xff1b146f);
  static const Color primary900 = Color(0xff0b015b);

  static const Color complementary50 = Color(0xfff7f5e6);
  static const Color complementary100 = Color(0xffeae6c0);
  static const Color complementary200 = Color(0xffdbd598);
  static const Color complementary300 = Color(0xffccc56f);
  static const Color complementary400 = Color(0xffc0ba4f);
  static const Color complementary500 = Color(0xffb4ae2e);
  static const Color complementary600 = Color(0xffa3a026);
  static const Color complementary700 = Color(0xff8c8d1c);
  static const Color complementary800 = Color(0xff767b13);
  static const Color complementary900 = Color(0xff515b01);

  static const Color analogous50 = Color(0xffe5e9f1);
  static const Color analogous100 = Color(0xffbec8dd);
  static const Color analogous200 = Color(0xff95a4c6);
  static const Color analogous300 = Color(0xff6c81b0);
  static const Color analogous400 = Color(0xff4b67a0);
  static const Color analogous500 = Color(0xff274e92);
  static const Color analogous600 = Color(0xff204689);
  static const Color analogous700 = Color(0xff163d7e);
  static const Color analogous800 = Color(0xff0d3472);
  static const Color analogous900 = Color(0xff01235b);

  static const Color analogous2_50 = Color(0xffefe2ee);
  static const Color analogous2_100 = Color(0xffd7b6d7);
  static const Color analogous2_200 = Color(0xffbe86bd);
  static const Color analogous2_300 = Color(0xffa358a3);
  static const Color analogous2_400 = Color(0xff913692);
  static const Color analogous2_500 = Color(0xff7e1180);
  static const Color analogous2_600 = Color(0xff720e7b);
  static const Color analogous2_700 = Color(0xff620873);
  static const Color analogous2_800 = Color(0xff53046b);
  static const Color analogous2_900 = Color(0xff38015b);

  static const Gradient gradient1 = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [ColorConst.primary600, ColorConst.primary300],
  );

  static const Gradient gradient2 = LinearGradient(
    begin: Alignment(0.00, -1.00),
    end: Alignment(0, 1),
    colors: [
      Color.fromRGBO(199, 238, 255, 1),
      Color.fromRGBO(199, 238, 255, 0.5)
    ],
  );

  static const Gradient gradient3 = LinearGradient(
    colors: [ColorConst.primary600, ColorConst.primary300],
  );
}
