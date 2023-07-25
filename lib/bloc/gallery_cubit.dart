import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:gallery_app/keys.dart';
import 'package:gallery_app/services/network_helper.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  GalleryCubit() : super(GalleryInitial());
 
  Future<void> getPhotos() async {
     emit(GalleryLoading());
    List<String> images = [];
    String url = "https://pixabay.com/api/?key=$ApiKey";
    NetworkHelper networkHelper = NetworkHelper(url: url);
    dynamic data = await networkHelper.getData();
    List<dynamic> hitsList = data["hits"] as List;
    for (int i = 0; i < hitsList.length; i++) {
      images.add(
        (hitsList[i]["largeImageURL"]),
      );
    }
    emit(ImagesLoaded(images: images));
  }
}
