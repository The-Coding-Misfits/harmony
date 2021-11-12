import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';
import 'package:harmony/models/user.dart';
import 'package:harmony/services/auth_service.dart';
import 'package:harmony/services/firestore.dart';

class FavoriteIconButton extends StatefulWidget {
  final Place place;
  const FavoriteIconButton({Key? key, required this.place}) : super(key: key);

  @override
  FavoriteIconButtonState createState() => FavoriteIconButtonState();
}

class FavoriteIconButtonState extends State<FavoriteIconButton> {
  HarmonyUser currentUser = AuthService.currHarmonyUser!;
  FireStoreService fireStoreService = FireStoreService();

  @override
  Widget build(BuildContext context) {
    bool isFavorited = currentUser.favoritesID.contains(widget.place.id);

    return IconButton(
      icon: isFavorited ? const Icon(Icons.favorite, color: Colors.red) : const Icon(Icons.favorite_border, color: Colors.red),
      onPressed: () {
        if (isFavorited) {
          removeFromFavorites();
        } else {
          addToFavorites();
        }
        setState(() {});
      },
    );
  }

  removeFromFavorites() {
    fireStoreService.removeFavoriteFromUser(widget.place.id, currentUser);
    print(currentUser.favoritesID);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Removed spot from favorites!"))
    );
  }

  addToFavorites() {
    fireStoreService.addFavoriteToUser(widget.place.id, currentUser);
    print(currentUser.favoritesID);
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Added spot to favorites!"))
    );
  }
}