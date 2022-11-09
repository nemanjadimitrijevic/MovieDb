import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/ui/pages/favourites_widget/favourites_widget.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_bloc.dart';
import 'package:movies/ui/pages/home_page/bloc/network_connection_state.dart';
import 'package:movies/ui/pages/popular_movies_widget/popular_movies_widget.dart';
import 'package:movies/ui/widgets/bottom_navigation_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = [const PopularMoviesWidget(), const FavouritesWidget()];

  @override
  void initState() {
    super.initState();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      print('CONNN -> $result');
    });
  }

  var _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: const Color(MovieColor.colorBg),
          appBar: AppBar(
            backgroundColor: const Color(MovieColor.colorBg),
            title: Container(
              margin: const EdgeInsets.only(left: 20),
              child: Align(
                alignment: AlignmentDirectional.centerStart,
                child: SvgPicture.asset(MovieSvgIcons.logo,
                    width: 22, height: 24, allowDrawingOutsideViewBox: false),
              ),
            ),
            titleSpacing: 0,
          ),
          bottomNavigationBar: Container(
            color: const Color(MovieColor.colorNavBg),
            height: 60,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BottomNavigationItem(
                    iconSvg: MovieSvgIcons.navMovies,
                    title: 'Movies',
                    isSelected: _selectedIndex == 0,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 0;
                      });
                    }),
                BottomNavigationItem(
                    iconSvg: MovieSvgIcons.navFavourites,
                    title: 'Favourites',
                    isSelected: _selectedIndex == 1,
                    onPressed: () {
                      setState(() {
                        _selectedIndex = 1;
                      });
                    })
              ],
            ),
          ),
          body: _buildHomePage()),
    );
  }

  Widget _buildHomePage() {
    return BlocBuilder<NetworkConnectionBloc, NetworkConnectionState>(
        builder: (context, state) {
      bool isDisconnected = state is NetworkDisconnected;
      return Stack(
        children: [
          _pages[_selectedIndex],
          Visibility(
              visible: isDisconnected,
              child: Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: Container(
                    width: double.infinity,
                    color: Colors.redAccent,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "NOT CONNECTED",
                        style: TextStyle(color: Color(MovieColor.colorText)),
                      ),
                    )),
              ))
        ],
      );
    });
  }
}
