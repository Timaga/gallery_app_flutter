import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gallery_app/bloc/gallery_cubit.dart';
import 'package:gallery_app/services/network_helper.dart';
import '../bloc/full_screenImage.dart';
import '../keys.dart';

class PhotoGallery extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GalleryCubit, GalleryState>(
      builder: (context, state) {
        if (state is GalleryLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is ImagesLoaded) {
          return Scaffold(
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(6.0),
                child: GridView.builder(
                    itemCount: state.images.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 6,
                        mainAxisSpacing: 6),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FullscreenImage(
                                  ImageUrl: state.images[index]),
                            ),
                          );
                        },
                        child: Image.network(
                          state.images[index],
                          fit: BoxFit.cover,
                        ),
                      ); 
                    }),
              ),
            ),
          );
        }
        return Container();
      },
    );
  }
}
