import 'package:fluttertoast/fluttertoast.dart';
import 'package:mesto_flutter/constants/theme_colors.dart';

void showError(String error) async {
  await Fluttertoast.showToast(
    msg: error,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 3,
    backgroundColor: ThemeColors.error,
    textColor: ThemeColors.white,
    fontSize: 16.0,
  );
}
