import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/blocs/network_connection_bloc/network_connection_bloc.dart';
import 'package:movies/blocs/network_connection_bloc/network_connection_state.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/ui/pages/home_layout.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: SafeArea(
          child: _buildHomePage(),
        ));
  }

  Widget _buildHomePage() {
    return BlocBuilder<NetworkConnectionBloc, NetworkConnectionState>(
        builder: (context, state) {
      return Stack(
        children: [
          const HomeLayout(),
          Visibility(
              visible: !state.isConnected,
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
