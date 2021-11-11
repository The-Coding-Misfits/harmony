import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_model.dart';
import 'package:harmony/widgets/filter/filter_sheet/filter_top_bar.dart';
import 'package:harmony/widgets/filter/filter_sheet/mixin&interface/filter_sheet_creator.dart';

class NearbyPage extends StatefulWidget {
  const NearbyPage({Key? key}) : super(key: key);

  @override
  _NearbyPageState createState() => _NearbyPageState();
}

class _NearbyPageState extends State<NearbyPage> with FilterSheetCreator{

  FilterModel filterModel = FilterModel();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            FilterTopBar(

            ),
          ],
        ),
      )
    );
  }
}
