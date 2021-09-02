import 'package:flutter/material.dart';

const TextStyle _text = TextStyle(
  fontStyle: FontStyle.normal,
);

TextStyle regular10 = _text.copyWith(fontSize: 10);
TextStyle regular12 = _text.copyWith(fontSize: 12);
TextStyle regular14 = _text.copyWith(fontSize: 14);

TextStyle normal32w700 = _text.copyWith(
  fontSize: 32,
  fontWeight: FontWeight.w700,
);
TextStyle normal24w700 = _text.copyWith(
  fontSize: 24,
  fontWeight: FontWeight.w700,
);
TextStyle normal18w500 = _text.copyWith(
  fontSize: 18,
  fontWeight: FontWeight.w500,
);
TextStyle normal14w700 = normal32w700.copyWith(
  fontSize: 14,
);
TextStyle normal14w400 = _text.copyWith(
  fontSize: 14,
  fontWeight: FontWeight.w400,
);
TextStyle normal16w500 = normal32w700.copyWith(
  fontSize: 16,
  fontWeight: FontWeight.w500,
);

TextStyle matHeadline6 = _text.copyWith(
  fontWeight: FontWeight.w500,
  fontSize: 20,
  letterSpacing: 0.15,
);

const TextStyle text1 = TextStyle(
  fontFamily: 'Roboto',
  color: Colors.black,
  fontWeight: FontWeight.w700,
  fontSize: 32,
  fontStyle: FontStyle.normal,
);

const TextStyle text2 = TextStyle(
  color: Colors.red,
  fontSize: 24,
  fontWeight: FontWeight.w700,
  fontStyle: FontStyle.normal,
  fontFamily: 'Roboto',
);

const TextStyle text3 = TextStyle(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w500,
  fontStyle: FontStyle.normal,
  fontFamily: 'Roboto',
);

const TextStyle text4 = TextStyle(
  color: Colors.grey,
  fontSize: 14,
  fontWeight: FontWeight.w400,
  fontStyle: FontStyle.normal,
  fontFamily: 'Roboto',
);
