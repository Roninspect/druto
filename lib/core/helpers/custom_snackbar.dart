import 'package:delightful_toast/delight_toast.dart';
import 'package:delightful_toast/toast/components/toast_card.dart';
import 'package:delightful_toast/toast/utils/enums.dart';
import 'package:flutter/material.dart';

showSnackbar(
    {required BuildContext context,
    required String text,
    bool inTop = false,
    required IconData leadingIcon,
    String? subtitle,
    required Color backgroundColor}) {
  DelightToastBar(
          builder: (tContext) => ToastCard(
                onTap: () {},
                color: backgroundColor,
                leading: Icon(
                  leadingIcon,
                  color: Colors.white,
                  size: 27,
                ),
                title: Text(
                  text,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                subtitle: subtitle == null
                    ? null
                    : Text(
                        subtitle,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
              ),
          autoDismiss: true,
          position: !inTop
              ? DelightSnackbarPosition.bottom
              : DelightSnackbarPosition.top,
          snackbarDuration: const Duration(seconds: 3))
      .show(context);
}
