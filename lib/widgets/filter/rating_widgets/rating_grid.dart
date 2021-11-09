import 'package:flutter/material.dart';
import 'package:harmony/widgets/filter/category_widgets/category_item.dart';
import 'package:harmony/widgets/filter/rating_widgets/rating_item.dart';
import 'package:harmony/widgets/filter/rating_widgets/rating_model.dart';

class RatingGrid extends StatefulWidget {
  @override
  _RatingGridState createState() => _RatingGridState();

  final Function(int) ratingChangedCallback;

  const RatingGrid(this.ratingChangedCallback, {Key? key}) : super(key: key);
}

class _RatingGridState extends State<RatingGrid> {

  List<RatingModel> items = [
    RatingModel(true, 1),
    RatingModel(true, 2),
    RatingModel(true, 3),
    RatingModel(false, 4),
    RatingModel(false, 5),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: items.length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index){
        return SizedBox(
          width: 50,
          height: 30,
          child: InkWell(
            highlightColor: Colors.transparent,
            overlayColor: MaterialStateProperty.all(Colors.transparent),
            splashColor: CategoryItem.activeColor,
            onTap: (){
              setState(() {
                for (var element in items) {
                  if (index + 1 >= element.rating) {
                    element.isSelected = true;
                  } else {
                    element.isSelected = false;
                  }
                }
                widget.ratingChangedCallback(items[index].rating);
              });
            },
            child: RatingItem(items[index]),
          ),
        );
      },
    );
  }
}
