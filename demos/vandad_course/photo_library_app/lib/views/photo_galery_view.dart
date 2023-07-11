import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:image_picker/image_picker.dart';

import '../bloc/app_bloc.dart';
import 'main_popup_menu_button.dart';
import 'storage_image_view.dart';

/// Implement `PhotoGalleryView`.
class PhotoGalleryView extends HookWidget {
  const PhotoGalleryView({super.key});

  @override
  Widget build(BuildContext context) {
    // Memoized make flutter widfet remember a particular instance of an a object
    // so you dont have to create this object while you're instance build function
    // or initState is run and then you have to dispose when dispose is called.

    // As long key is the same then image picker is going to be the same instance
    // otherwise if the key our widget changes then there's going to be a new
    // instance of ImagePicker created for us.
    final picker = useMemoized(() => ImagePicker(), [key]);

    // Watch images from state if null, pass empty images.
    final images = context.watch<AppBloc>().state.images ?? [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Photo Gallery'),
        actions: [
          IconButton(
            onPressed: () async {
              final image = await picker.pickImage(
                source: ImageSource.gallery,
              );
              if (image == null) {
                return;
              }
              context.read<AppBloc>().add(
                    AppEventUploadImage(
                      filePathToUpload: image.path,
                    ),
                  );
            },
            icon: const Icon(
              Icons.upload,
            ),
          ),
          const MainPopupMenuButton(),
        ],
      ),
      body: GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(8),
        mainAxisSpacing: 20.0,
        crossAxisSpacing: 20.0,
        children: images
            .map(
              (img) => StorageImageView(
                image: img,
              ),
            )
            .toList(),
      ),
    );
  }
}
