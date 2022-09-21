import 'package:flutter/material.dart';

class SearchField extends StatelessWidget {
  final Function(String) onChange;
  const SearchField({Key? key, required this.onChange}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey, width: 1),
        borderRadius: const BorderRadius.all(
          Radius.circular(15),
        ),
      ),
      child: TextField(
        decoration: const InputDecoration(
          hintText: "Search...",
          floatingLabelBehavior: FloatingLabelBehavior.never,
          border: InputBorder.none,
        ),
        onChanged: (value) {
          onChange(value);
        },
      ),
    );
  }
}
