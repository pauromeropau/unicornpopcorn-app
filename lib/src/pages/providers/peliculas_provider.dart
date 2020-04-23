import 'dart:async';

import 'package:http/http.dart' as http;

import 'dart:convert';

import 'package:unicorn_popcorn/src/pages/models/pelicula_model.dart';

class PeliculasProvider {
  String _apikey = 'ec17528337247513ab6db9b524ccf49c';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  int _popularesPage = 0;

  bool _cargando = false;

  List<Pelicula> _populares = new List();

  final _popularesStreamController =
      StreamController<List<Pelicula>>.broadcast();

  Function(List<Pelicula>) get popularesSink =>
      _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream =>
      _popularesStreamController.stream;

  void disposeStreams() {
    _popularesStreamController?.close();
  }

  Future<List<Pelicula>> _procesarRespuesta(Uri url) async {
    final resp = await http.get(url);
    final decodedData = json.decode(resp.body);
    final peliculas = new Peliculas.fromJsonList(decodedData['results']);

    return peliculas.items;
  }

  Future<List<Pelicula>> getEnCines() async {
    final url = Uri.https(_url, '/3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });
    return await _procesarRespuesta(url);
  }

  Future<List<Pelicula>> getPopulares() async {
    if (_cargando) return [];

    _cargando = true;

    _popularesPage++;

    // print('Cargando siguientes...');
    
    final url = Uri.https(_url, '/3/movie/popular', {
      'api_key': _apikey,
      'language': _language,
      'page': _popularesPage.toString(),
    });
    final resp = await _procesarRespuesta(url);

    _populares.addAll(resp);

    popularesSink(_populares);
    _cargando = false;
    return resp;

    // return await _procesarRespuesta(url);
  }
}
