library dart_lastfm;

import 'dart:convert';
import 'package:dart_lastfm/models/stream.dart';
import 'package:dart_lastfm/services/network.dart';
import 'package:flutter/material.dart';

class LastFM {
  final String username;
  final String key;

  LastFM({@required this.key, @required this.username});

  Future<StreamModel> fetchData() async {
    NetworkService networkService = NetworkService(
      endPoint:
          "http://ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=$username&api_key=$key&format=json&limit=1",
    );

    String data = await networkService.retrieveCall();

    final StreamModel model = StreamModel(
      artist: jsonDecode(data)["recenttracks"]["track"][0]["artist"]["#text"],
      coverArt: jsonDecode(data)["recenttracks"]["track"][0]["image"][3]
          ["#text"],
      name: jsonDecode(data)["recenttracks"]["track"][0]["name"],
      url: jsonDecode(data)["recenttracks"]["track"][0]["url"],
    );

    return model;
  }
}
