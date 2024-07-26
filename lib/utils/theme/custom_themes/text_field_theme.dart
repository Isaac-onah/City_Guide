import 'package:cityguide/utils/constants/color.dart';
import 'package:flutter/material.dart';


class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: Colors.grey,
    suffixIconColor: Colors.grey,
// constraints: const BoxConstraints.expand (height: 14.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.black),
    errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
    floatingLabelStyle: const TextStyle().copyWith(
        color: Colors.black.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide (width: 1, color: Colors.grey),),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide (width: 1, color: Colors.grey),),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderSide: const BorderSide (width: 1, color: Colors.black12),
      borderRadius: BorderRadius.circular(14),),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide (width: 1, color: Colors.red),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(14),
      borderSide: const BorderSide (width: 2, color: TColors.primary),
    ),


  ); // InputDecoration Theme
  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
  errorMaxLines: 3,
  prefixIconColor: Colors.grey,
  suffixIconColor: Colors.grey,
// constraints: const BoxConstraints.expand (height: 14.inputFieldHeight),
  labelStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
  hintStyle: const TextStyle().copyWith(fontSize: 14, color: Colors.white),
  errorStyle: const TextStyle().copyWith(fontStyle: FontStyle.normal),
  floatingLabelStyle: const TextStyle().copyWith(
  color: Colors.black.withOpacity(0.8)),
  border: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide (width: 1, color: Colors.grey),),
  enabledBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide (width: 1, color: Colors.grey),),
  focusedBorder: const OutlineInputBorder().copyWith(
  borderSide: const BorderSide (width: 1, color: Colors.white),
  borderRadius: BorderRadius.circular(14),),
  errorBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide (width: 1, color: Colors.red),
  ),
  focusedErrorBorder: const OutlineInputBorder().copyWith(
  borderRadius: BorderRadius.circular(14),
  borderSide: const BorderSide (width: 2, color: TColors.primary),
  ),
  );

}