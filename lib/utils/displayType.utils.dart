import 'package:flutter/material.dart';

enum DisplayType {
  desktop,
  tablet,
  phone,
}

const _tabletBreakpoint = 700.0;

const _desktopBreakpoint = 900.0;

DisplayType displayTypeOf(BuildContext context) {
  if (MediaQuery.of(context).size.shortestSide >= _desktopBreakpoint)
    return DisplayType.desktop;
  else if (MediaQuery.of(context).size.shortestSide >= _tabletBreakpoint)
    return DisplayType.tablet;
  else
    return DisplayType.phone;
}

bool isDisplayDesktop(BuildContext context) =>
    displayTypeOf(context) == DisplayType.desktop;

bool isDisplayTablet(BuildContext context) =>
    displayTypeOf(context) == DisplayType.tablet;

bool isDisplayPhone(BuildContext context) =>
    displayTypeOf(context) == DisplayType.phone;

bool isDisplayNotPhone(BuildContext context) =>
    displayTypeOf(context) != DisplayType.phone;
