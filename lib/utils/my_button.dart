// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class MyButton extends StatefulWidget {
  Function()? onTap;
  MyButton({super.key, required this.onTap});

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: Colors.grey.shade900,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade800,
              spreadRadius: 1,
              blurRadius: 7,
              offset: Offset(2, 3),
            ),
          ],
        ),
        child: Center(child: Text("Save", style: TextStyle(fontSize: 22))),
      ),
    );
  }
}
