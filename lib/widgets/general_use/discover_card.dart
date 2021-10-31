import 'package:flutter/material.dart';

class DiscoverCard extends StatelessWidget {
  final double rating;
  final String imageUrl;
  final double distance;

  const DiscoverCard({Key? key, required this.rating, required this.imageUrl, required this.distance}) : super(key: key);

  createRatingIcons() {
    if (1 <= rating && 2 > rating) {
      return const [
        Icon(Icons.circle, color: Colors.red, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
      ];
    } else if (2 <= rating && 3 > rating) {
      return const [
        Icon(Icons.circle, color: Colors.red, size: 20),
        Icon(Icons.circle, color: Colors.red, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
      ];
    } else if (3 <= rating && 4 > rating) {
      return const [
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
      ];
    } else if (4 <= rating && 5 > rating) {
      return const [
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Colors.grey, size: 20),
      ];
    } else if (4 <= rating && 5 > rating) {
      return const [
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
        Icon(Icons.circle, color: Color(0xff00CA9D), size: 20),
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: GestureDetector(
        onTap: () {},
        child: Column(
          children: [
            Image.asset(imageUrl),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(top: 10, bottom: 5, left: 10),
                child: Text('Great place for a picnic!', style: TextStyle(fontSize: 20)),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                  padding: const EdgeInsets.only(bottom: 5, left: 10),
                  child: Row(
                    children: [
                      Row(
                        children: createRatingIcons()
                      ),
                      Text(' $rating/5.0 • ${distance}KM Nearby',
                          style: const TextStyle(
                              fontSize: 16,
                              color: Color(0xff6a6a6a),
                              fontWeight: FontWeight.bold
                          )
                      ),
                    ],
                  )
              ),
            )
          ],
        ),
      ),
    );
  }
}