import 'package:flutter/material.dart';
import 'package:unicorn_popcorn/src/pages/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;

  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3,
    );

    _pageController.addListener(() {
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        // print('Cargar siguientes');
        siguientePagina();
      }
    });

    return Container(
        height: _screenSize.height * 0.2,
        child: PageView.builder(
          pageSnapping: false,
          itemCount: peliculas.length,
          controller: _pageController,
          // children: _tarjetas(context)),
          itemBuilder: (context, i) => _tarjeta(context, peliculas[i]),
        ));
  }

  // List<Widget> _tarjetas(context) {
  //   return peliculas.map((pelicula) {}).toList();
  // }

  Widget _tarjeta(BuildContext context, Pelicula pelicula) {
    final tarjeta = Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(pelicula.getPosterImg()),
              fit: BoxFit.cover,
              height: 125.0,
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            pelicula.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          )
        ],
      ),
    );
    return GestureDetector(
      onTap: () {
        // print('tap');
        // print('Nombre pelicula: ${pelicula.title}');
        Navigator.pushNamed(context, 'detalle', arguments: pelicula);
      },
      child: tarjeta,
    );
  }
}
