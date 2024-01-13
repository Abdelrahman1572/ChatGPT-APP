import 'package:flutter/material.dart';

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  required validator,
  onChange,
  onSubmit,
  suffixpressed,
  onTap,
  bool isPassword = false,
  IconData? suffix,
  bool isClickable = true,
  required String label,
  required IconData prefix,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      obscureText: isPassword,
      style: const TextStyle(fontSize: 24),
      enabled: isClickable,
      validator: validator,
      cursorColor: Colors.white,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        hintStyle: TextStyle(color: Colors.white),
        floatingLabelAlignment: FloatingLabelAlignment.center,
        floatingLabelStyle: const TextStyle(fontSize: 24, color: Colors.white),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        prefixIcon: Icon(prefix, color: Colors.white,),
        suffixIcon: suffix != null ? IconButton(onPressed: suffixpressed, icon: Icon(
                  suffix,
                  color: Colors.white,)) : null,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
      ),
    );

Widget defaultButton({required Widget text, pressed,context}) => Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: TextButton(
        onPressed: pressed,
        child: text,
      ),
    );

Widget myDivider() => Container(
      height: 1.0,
      width: double.infinity,
      color: Colors.grey[300],
    );

void navigateTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

void navigateAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => widget,
    ),
    (Route<dynamic> route) => false);

// void showToasts({required String message, required ToastStates state}) {
//   Fluttertoast.showToast(
//       msg: message,
//       toastLength: Toast.LENGTH_LONG,
//       timeInSecForIosWeb: 1,
//       gravity: ToastGravity.BOTTOM,
//       backgroundColor: chooseToastColor(state),
//       textColor: Colors.white,
//       fontSize: 16.0);
// }
//
// enum ToastStates { SUCCESS, ERROR, WARNING }
//
// Color chooseToastColor(ToastStates state) {
//   Color colors;
//   switch (state) {
//     case ToastStates.SUCCESS:
//       colors = Colors.green;
//       break;
//     case ToastStates.ERROR:
//       colors = Colors.red;
//       break;
//     case ToastStates.WARNING:
//       colors = Colors.amber;
//       break;
//   }
//   return colors;
// }
