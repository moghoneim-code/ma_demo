import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

import '../../../constants/k_colors.dart';
import '../../../shared/widgets/loading_widget.dart';

class ImagesGallery extends StatefulWidget {
  final List<String> images;

  const ImagesGallery({super.key, required this.images});

  @override
  State<ImagesGallery> createState() => _ImagesGalleryState();
}

class _ImagesGalleryState extends State<ImagesGallery> {
  List<String> get images => widget.images;

  /// [PageViewDialog] is a dialog to show the images in an interactive way
  void _openImagesGallery() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PageViewDialog(images: images),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (images.isEmpty) {
      return const SizedBox.shrink();
    }
    if (images.length == 1) {
      return ImageItem(
        image: images.first,
      );
    }
    final size = MediaQuery.of(context).size;

    /// [height] is the height of the list view
    /// 33% of the screen height
    final height = size.height * 0.33;
    return SizedBox(
      height: height,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: images.length,
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(
                  right: 8.0,
                ),
                child: ImageItem(
                    image: images[index],
                    size: Size(size.width * 0.44, height),

                    /// [onTap] to open the [PageViewDialog]
                    onTap: _openImagesGallery),
              )),
    );
  }
}

/// [ImageItem] is a widget to show the image in the list view
class ImageItem extends StatelessWidget {
  final VoidCallback? onTap;
  final String image;
  final Size? size;

  const ImageItem({
    super.key,
    this.onTap,
    required this.image,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    Widget child = InkWell(
      onTap: onTap,
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        placeholder: (context, url) => const LoadingWidget(),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    );
    child = child;
    if (size == null) return child;
    return SizedBox.fromSize(size: size, child: child);
  }
}

class PageViewDialog extends StatefulWidget {
  final List<String> images;

  const PageViewDialog({super.key, required this.images});

  @override
  State<PageViewDialog> createState() => PageViewDialogState();
}

class PageViewDialogState extends State<PageViewDialog> {
  late final PageController _pageController;
  final _currentPageNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    _pageController = PageController();
    _pageController.addListener(() {
      _currentPageNotifier.value = _pageController.page!.round();
    });
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _currentPageNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        elevation: 0,
        leading: const BackButton(color: Colors.white),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Stack(
          children: [
            /// [PageView.builder] to show the images in a page view in order to swipe between them
            PageView.builder(
              controller: _pageController,
              itemCount: widget.images.length,
              itemBuilder: (context, index) {
                final image = widget.images[index];
                return InteractiveViewer(
                  child: CachedNetworkImage(
                    imageUrl: image,
                    fit: BoxFit.fitWidth,
                    placeholder: (context, url) => const LoadingWidget(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  ),
                );
              },
            ),
            Align(
              alignment: const Alignment(0.0, 0.95),
              child: CirclePageIndicator(
                dotColor: Colors.grey.shade300,
                selectedDotColor: KColors.mainColorDarkMode,
                itemCount: widget.images.length,
                currentPageNotifier: _currentPageNotifier,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
