import 'package:flutter/cupertino.dart';

class FavouritesWidget extends StatefulWidget {
  const FavouritesWidget({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _FavouritesWidgetState();
}

class _FavouritesWidgetState extends State<FavouritesWidget> {
  @override
  Widget build(BuildContext context) {
    return const Text("Favourites");
  }
}
