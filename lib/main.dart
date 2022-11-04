import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_bloc.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_event.dart';
import 'package:movies/blocs/popular_movies_bloc/popular_movies_state.dart';
import 'package:movies/common/colors.dart';
import 'package:movies/common/icons.dart';
import 'package:movies/domain/popular_movies.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Movies',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final PopularMoviesBloc _popularMoviesBloc = PopularMoviesBloc();

  @override
  void initState() {
    _popularMoviesBloc.add(GetPopularMovies());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: _buildPopularMoviesList(),
    );
  }

  Widget _buildPopularMoviesList() {
    return Container(
      margin: const EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _popularMoviesBloc,
        child: BlocListener<PopularMoviesBloc, PopularMoviesState>(
          listener: (context, state) {
            // if (state is CovidError) {
            //   ScaffoldMessenger.of(context).showSnackBar(
            //     SnackBar(
            //       content: Text(state.message!),
            //     ),
            //   );
            // }
          },
          child: BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
            builder: (context, state) {
              if (state is PopularMoviesInitial) {
                return _buildLoading();
              } else if (state is PopularMoviesLoading) {
                return _buildLoading();
              } else if (state is PopularMoviesLoaded) {
                return _buildCard(context, state.movies);
              }
              // else if (state is CovidError) {
              //   return Container();
              // }
              else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, PopularMovies model) {
    return ListView.builder(
      itemCount: model.movies!.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: Card(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  Text("Title: ${model.movies![index].title}"),
                  Text("Original Title: ${model.movies![index].originalTitle}"),
                  Text("Overview: ${model.movies![index].overview}"),
                  Text(
                      "Vote: ${model.movies![index].voteAverage}/${model.movies![index].voteCount}"),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildLoading() => const Center(
      child: CircularProgressIndicator(color: Color(MovieColor.colorPrimary)));
}
