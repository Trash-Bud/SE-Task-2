

import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

import '../model/Player.dart';

Future<Image>? loadImage(String assetPath) async {
  final data = await rootBundle.load(assetPath);
  final list = Uint8List.view(data.buffer);
  final completer = Completer<Image>();
  decodeImageFromList(list, completer.complete);
  return completer.future;
}
