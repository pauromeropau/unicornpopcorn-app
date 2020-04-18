import 'package:flutter/material.dart';

import 'package:unicorn_popcorn/src/pages/widgets/card_swiper_widget.dart';

import 'providers/peliculas_provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Películas en cines'),
        backgroundColor: Colors.black,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {},
          )
        ],
      ),
      // body: SafeArea(
      //   child: Text('Hola mundo!!'),
      // )
      body: Container(
        child: Column(
          children: <Widget>[_swiperTarjetas()],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    final peliculasProvider = new PeliculasProvider();
    peliculasProvider.getEnCines();
    return CardSwiper(peliculas: [1, 2, 3]);
  }
}
