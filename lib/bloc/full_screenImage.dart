import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

class FullscreenImage extends StatelessWidget {
  final String ImageUrl;

  FullscreenImage({required this.ImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Stack(
          children: [
            Center(
              child: Hero(
                tag: ImageUrl,
                child: Image.network(ImageUrl),
              ),
            ),
            Align(
                alignment: Alignment.topRight,
                child: IconButton(
                    onPressed: () async {
                      var response = await Dio().get(ImageUrl,
                          options: Options(responseType: ResponseType.bytes));

                      await ImageGallerySaver.saveImage(
                          Uint8List.fromList(response.data));
                    },
                    icon: Icon(Icons.download)))
          ],
        ),
      ),
    );
  }
}
