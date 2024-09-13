import 'package:flutter/material.dart';

extension MediaQueryValues on BuildContext {
  // getting heigh & width
  double get width => MediaQuery.of(this).size.width;
  double get height => MediaQuery.of(this).size.height;

  // height gaps
  double get microGap => height * 0.005;
  double get smGap => height * 0.01;
  double get mdGap => height * 0.025;

  //width gaps
  double get wSmGap => width * 0.01;
  double get wMdGap => width * 0.05;

  //font sizes
  double get f13 => width * 0.030;
  double get f15 => width * 0.040;
  double get f16 => width * 0.045;
  double get f17 => width * 0.050;
  double get f20 => width * 0.052;
  double get f18 => width * 0.042;
  double get f35 => width * 0.08;

  //icon sizes
  double get ism => width * 0.04;

  // text oversflow limit width sizes
  double get midOverflow => width * 0.45;
}
