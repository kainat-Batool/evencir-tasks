import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/*
 * This extension on the num type provides convenient methods to create
 * SizedBox widgets with specified dimensions, adapting to web and mobile
 * platforms using the flutter_screenutil package.
 */
extension SizedBoxExtension on num {
  // Creates a vertical SizedBox with a specified height
  SizedBox get height =>
      SizedBox(height: kIsWeb ? toDouble() : toDouble().h);

  // Creates a horizontal SizedBox with a specified width
  SizedBox get width =>
      SizedBox(width: kIsWeb ? toDouble() : toDouble().w);

  // Creates a SizedBox with both width and height specified
  SizedBox get space => SizedBox(
      width: kIsWeb ? toDouble() : toDouble().w,
      height: kIsWeb ? toDouble() : toDouble().h);
}
