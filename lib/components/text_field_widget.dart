import 'package:flutter/material.dart';
import 'package:home_hub/custom_widget/space.dart';

Widget TextFieldWidget(String label, controller) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
      Space(4),
      TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
        maxLines: 1,
      ),
    ],
  );
}