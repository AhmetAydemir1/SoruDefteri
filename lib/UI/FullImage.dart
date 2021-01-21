import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ImageFull extends StatefulWidget {
  final String imgUrl;

  ImageFull(this.imgUrl);

  @override
  ImageFullState createState() => ImageFullState(imgUrl);
}

class ImageFullState extends State<ImageFull> {
  final String imgUrl;

  ImageFullState(this.imgUrl);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(backgroundColor: Colors.black26,shadowColor: Colors.transparent,),
      body: Hero(
        tag: imgUrl,
        child: Center(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,

            child: Material(
              child: PhotoView(
                backgroundDecoration: BoxDecoration(color: Colors.white),
                imageProvider: CachedNetworkImageProvider(imgUrl,),
                loadingBuilder: (context,a){
                  if(a!=null){return Center(child: CircularProgressIndicator(value: a.cumulativeBytesLoaded/a.expectedTotalBytes,),);}else{
                    return Center(child: CircularProgressIndicator(),);
                  }
                },
                minScale: PhotoViewComputedScale.contained * 1,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
