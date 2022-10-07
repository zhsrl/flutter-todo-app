import 'package:flutter/material.dart';

class AppColor {
  static const Color white = Color(0xFFFFFFFF);
  static const Color dark = Color(0xFF1C1D22);
  static const Color orange = Color(0xFFE9A356);
  static const Color green = Color(0xFF92FBAF);
  static const Color lowopacitywhite = Color(0xFF61646D);
  static const Color itemColor = Color(0xFF2A2D3D);

  static const LinearGradient priorityItemColor1 = LinearGradient(
    colors: [Color(0xFFE9A356), Color(0xFFFF666C)],
    begin: Alignment.bottomRight,
    end: Alignment.topLeft,
  );
}

class Utils {
  InputDecoration inputDecoration(String hintText) {
    return InputDecoration(
        isCollapsed: true,
        hintText: hintText,
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        hintStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color(0xFFBDBDBD)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xFF5DB075), width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }

  InputDecoration inputDecorationWithLabel(String hintText, String? labelText) {
    return InputDecoration(
        isCollapsed: true,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        labelText: labelText!,
        labelStyle: TextStyle(color: AppColor.white),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        hintStyle: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w500,
            color: Color(0xFFBDBDBD)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            borderSide: BorderSide(color: Color(0xFF5DB075), width: 1.5)),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFE8E8E8), width: 1.5),
            borderRadius: BorderRadius.all(Radius.circular(8))),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(8))));
  }

  ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showNotification(
      BuildContext context, String text) {
    final snackbar = SnackBar(
      content: Text(text),
    );
    // ignore: use_build_context_synchronously
    return ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
