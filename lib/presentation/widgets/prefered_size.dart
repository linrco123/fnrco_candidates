// ignore_for_file: file_names

import 'package:flutter/material.dart';

PreferredSize myPreferredSize({required String title}) {
  return PreferredSize(
    preferredSize: const Size.fromHeight(250),
    child: Container(
      height: 203,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 5,
            offset: Offset(0, 1),
          ),
        ],
        image: DecorationImage(
          image: AssetImage("assets/images/png/company.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            bottom: 20,
            right: 40,
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 27,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    blurRadius: 5,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}