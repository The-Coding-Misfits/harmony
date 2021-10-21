import 'package:flutter/material.dart';

class FilterSheet extends StatefulWidget {
  const FilterSheet({Key? key}) : super(key: key);

  @override
  _FilterSheetState createState() => _FilterSheetState();
}

class _FilterSheetState extends State<FilterSheet> {
  @override

  int farValue;



  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Expanded( //To make space for the top bar
            flex: 1,
            child: SizedBox(),
          ),

        ],
      ),
    );
  }
}
