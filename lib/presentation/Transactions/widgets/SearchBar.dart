import 'package:flutter/material.dart';

class SearchTransactionsBar extends StatelessWidget {
  const SearchTransactionsBar({
    Key? key,
    required this.onChanged,
    required this.controller,
    // required this.title
  }) : super(key: key);
  // final String title;
  final void Function(String)? onChanged;
  final TextEditingController? controller;
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F6F9) // Light mode color
        : Colors.grey[800], borderRadius: BorderRadius.circular(30)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(Icons.search
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                decoration: const InputDecoration(
                    hintText: "Search", border: InputBorder.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}
