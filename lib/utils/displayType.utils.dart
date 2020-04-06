import 'dart:math';

import 'package:flutter/material.dart';

enum DisplayType {
  phone,
  tablet,
  desktop,
}

const _tabletBreakpoint = 700.0;

const _desktopBreakpoint = 900.0;

class ScaleUtils {
  DisplayType displayType;

  ScaleUtils.of(BuildContext context) {
    if (MediaQuery.of(context).size.shortestSide >= _desktopBreakpoint)
      this.displayType = DisplayType.desktop;
    else if (MediaQuery.of(context).size.shortestSide >= _tabletBreakpoint)
      this.displayType = DisplayType.tablet;
    else
      this.displayType = DisplayType.phone;
  }

  bool isDesktop() => this.displayType == DisplayType.desktop;

  bool isTablet() => this.displayType == DisplayType.tablet;

  bool isPhone() => this.displayType == DisplayType.phone;

  bool isNotPhone() => this.displayType != DisplayType.phone;

  // When text is larger, this factor becomes larger, but at smaller rate
  double reducedTextScale() {
    int textScaleFactor = this.displayType.index + 1;
    return textScaleFactor >= 1 ? (1 + textScaleFactor) / 2 : 1;
  }

  // When text is larger, this factor becomes larger at the same rate.
  // But when text is smaller, this factor stays at 1.
  double cappedTextScale() {
    double textScaleFactor = (this.displayType.index + 1) as double;
    return max(textScaleFactor, 1);
  }
}
