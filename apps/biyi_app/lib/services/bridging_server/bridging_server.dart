import 'dart:async';
import 'dart:convert';

import 'package:biyi_app/includes.dart';
import 'package:flutter/foundation.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart' as shelf_io;
import 'package:shelf_router/shelf_router.dart';

class BridgingServer {
  BridgingServer._();

  /// The shared instance of [BridgingServer].
  static final BridgingServer instance = BridgingServer._();

  Handler get handler {
    final router = Router();

    router.get('/ocr_engines', (
      Request request,
    ) {
      List<OcrEngineConfig> list = localDb.ocrEngines.list();
      return Response.ok(json.encode(list));
    });

    router.get('/ocr_engines/<identifier>', (
      Request request,
      String identifier,
    ) {
      OcrEngineConfig? config = localDb.ocrEngine(identifier).get();
      if (config != null) {
        return Response.ok(json.encode(config));
      }
      return Response.notFound(json.encode({'error': 'not found'}));
    });

    router.post('/ocr_engines/<identifier>/recognizeText', (
      Request request,
      String identifier,
    ) async {
      final payload = await request.readAsString();
      final body = json.decode(payload);
      String base64Image = body['base64Image'];
      base64Image = base64Image.replaceAll('data:image/png;base64,', '');
      RecognizeTextResponse recognizeTextResponse =
          await sharedOcrClient.use(identifier).recognizeText(
                RecognizeTextRequest(
                  base64Image: base64Image,
                ),
              );
      return Response.ok(json.encode(recognizeTextResponse));
    });

    // You can catch all verbs and use a URL-parameter with a regular expression
    // that matches everything to catch app.
    router.all('/<ignored|.*>', (Request request) {
      return Response.notFound('Page not found');
    });

    return router;
  }

  Future<void> start({
    required String address,
    required int port,
  }) async {
    final server = await shelf_io.serve(handler, address, port);
    if (kDebugMode) {
      print('Server running on $address:${server.port}');
    }
  }
}
