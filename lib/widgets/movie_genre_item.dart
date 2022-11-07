import 'package:flutter/cupertino.dart';
import 'package:movies/common/colors.dart';

class MovieGenreItems extends StatelessWidget {
  final List<int> genreIds;
  const MovieGenreItems({Key? key, required this.genreIds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [_createGenre("genre")],
    );
  }

  Widget _createGenre(String genre) {
    return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(4)),
          color: Color(MovieColor.colorPrimaryFaded)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(genre,
            style: const TextStyle(
                color: Color(MovieColor.colorText),
                fontSize: 11,
                fontWeight: FontWeight.w400)),
      ),
    );
  }
}
