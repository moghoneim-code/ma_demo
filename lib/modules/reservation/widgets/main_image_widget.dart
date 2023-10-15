import 'package:flutter/material.dart';
import 'images_gallery.dart';

class MainImageWidget extends StatefulWidget {
  final String imageUrl;

  const MainImageWidget({super.key, required this.imageUrl});

  @override
  State<MainImageWidget> createState() => _MainImageWidgetState();
}

class _MainImageWidgetState extends State<MainImageWidget> {
  @override
  Widget build(BuildContext context) {
    return ImageItem(image: widget.imageUrl, onTap: () => _openImagesGallery());
  }

  void _openImagesGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PageViewDialog(images: [widget.imageUrl]),
      ),
    );
  }
}
