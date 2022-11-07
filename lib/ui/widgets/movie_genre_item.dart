import 'package:flutter/cupertino.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/domain/genre.dart';

class MovieGenreItems extends StatelessWidget {
  final List<int> genreIds;
  final List<Genre?>? genreList;
  const MovieGenreItems(
      {Key? key, required this.genreIds, required this.genreList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _createGenreList();
  }

  Widget _createGenreList() {
    return Wrap(
      children: addGenreItems(),
    );
  }

  List<Widget> addGenreItems() {
    List<Widget> genreWidgetList = [];
    for (var element in genreIds) {
      String? genreName;
      genreList?.forEach((genre) {
        if (genre?.id == element) {
          genreName = genre?.name;
        }
      });
      if (genreName != null) genreWidgetList.add(_createGenre(genreName!));
    }

    return genreWidgetList;
  }

  Widget _createGenre(String genre) {
    return Container(
      margin: const EdgeInsets.only(right: 4, top: 5),
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
