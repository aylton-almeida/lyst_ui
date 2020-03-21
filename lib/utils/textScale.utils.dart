import 'dart:math';

import 'package:flutter/material.dart';

import 'displayType.utils.dart';

double _textScaleFactor(BuildContext context) {
  if (isDisplayTablet(context))
    return 2;
  else if (isDisplayDesktop(context))
    return 3;
  else
    return 1;
}

// When text is larger, this factor becomes larger, but at smaller hate
double reducedTextScale(BuildContext context) {
  double textScaleFactor = _textScaleFactor(context);
  return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
}

// When text is larger, this factor becomes larger at the same rate.
// But when text is smaller, this factor stays at 1.
double cappedTextScale(BuildContext context) {
  double textScaleFactor = _textScaleFactor(context);
  return max(textScaleFactor, 1);
}
