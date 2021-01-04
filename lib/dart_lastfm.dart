library dart_lastfm;

import 'dart:convert';

import 'package:dart_lastfm/models/stream.dart';
import 'package:dart_lastfm/services/network.dart';
import 'package:flutter/material.dart';

/// A Calculator.
class LastFM {
  final String username;
  final String key;

  LastFM({@required this.key, @required this.username});

  Future<String> _callData() async {
    NetworkService networkService = NetworkService(
      endPoint:
          "ws.audioscrobbler.com/2.0/?method=user.getrecenttracks&user=$username&api_key=$key&format=json&limit=1",
    );

    return await networkService.retrieveCall();
  }

  Future<StreamModel> getData() async {
    final String data = await _callData();

    StreamModel model = StreamModel(
      artist: jsonDecode(data)["recenttracks"]["tracks"][0]["artist"]["#text"],
      coverArt: jsonDecode(data)["recenttracks"]["tracks"][0]["image"][3]
          ["#text"],
    );

    print(model);
  }
}
