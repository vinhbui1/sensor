
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:misssaigon/common/herophoview.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'single.dart';
import 'package:photo_view/photo_view.dart';

class Declare extends StatefulWidget {
  List<dynamic> asset;
  

  // In the constructor, require a Todo.
  Declare({Key key, @required this.asset, })
      : super(key: key);
  @override
  _DeclareState createState() => _DeclareState();
}


class _DeclareState extends State<Declare> {
  var a = Singleton;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  color: Colors.black,
                  width: double.infinity,
                  child: Text(
                    " Declared Assets",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )),
            Container(
                padding: EdgeInsets.only(left: 7, right: 7, top: 10, bottom: 5),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Following assets that have been declared during the check-in process:",
                      style: TextStyle(fontSize: 18),
                    ),
                    widget.asset != null && widget.asset.length > 0
                        ? _aseetImage(0)
                        : _aseetImageNull(),
                    widget.asset != null && widget.asset.length > 1
                        ? _aseetImage(1)
                        : _aseetImageNull(),
                    widget.asset != null && widget.asset.length > 2
                        ? _aseetImage(2)
                        : _aseetImageNull(),
                  ],
                )),
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  padding: EdgeInsets.only(left: 5, right: 5, top: 5),
                  width: double.infinity,
                  child: RaisedButton(
                    onPressed: () {
                        PaintingBinding.instance.imageCache.clear();

                      Navigator.pop(context);
                    },
                    child: Text(
                      'DISMISS',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  _aseetImage(index) {
    return Row(
      children: <Widget>[
      
   
        
    //         Container(
    //       padding: EdgeInsets.only(top: 10),
    //       width: MediaQuery.of(context).size.width / 3,
    //       height: MediaQuery.of(context).size.width / 2.8,
    //       child: PhotoView(
    //   imageProvider: NetworkImage("http://dxcapphcm001.vdc.csc.com" +
    //                 widget.asset[index]["asset_image"]),
    // )
          
    //   //     GestureDetector(
    //   //   child: Hero(
    //   //     tag: 'imageHero',
    //   //     child:  Container(
    //   //       child: CachedNetworkImage(
    //   //       imageUrl:  "http://dxcapphcm001.vdc.csc.com" +
    //   //               widget.asset[index]["asset_image"],
           
           
       
    //   //     ),
    //   //     )
    //   //   ),
    //   //   onTap: () {
    //   //     Navigator.push(context, MaterialPageRoute(builder: (_) {
    //   //       return DetailScreen("http://dxcapphcm001.vdc.csc.com" +
    //   //               widget.asset[index]["asset_image"],);
    //   //     }));
    //   //   },
    //   // ),
          
    //       // GestureDetector(

    //       // //    onTap: () {
    //       // // Navigator.push(context, MaterialPageRoute(builder: (_) {
    //       // //   return DetailScreen(
    //       // //           NetworkImage(
    //       // //                   "http://dxcapphcm001.vdc.csc.com" +
    //       // //                       widget.asset[index]["asset_image"], ) ,
    //       // //             );
    //       // // }));},
    //       //     // onTap: ()  {
                 
    //       //     //   Navigator.push(
    //       //     //       context,
    //       //     //       MaterialPageRoute(
    //       //     //         builder: (context) => DetailScreen(
    //       //     //       NetworkImage(
    //       //     //               "http://dxcapphcm001.vdc.csc.com" +
    //       //     //                  Image.network("http://dxcapphcm001.vdc.csc.com" +
    //       //     //         ),
    //       //     //       ));
    //       //     // },
          
    //       //         child: Hero(
    //       //       tag: "someTag",
    //       //       child: Image.network("http://dxcapphcm001.vdc.csc.com" +
    //       //           widget.asset[index]["asset_image"],),
    //       //     )),
    //     ),



         Container(
                  // margin: const EdgeInsets.symmetric(
                  //   vertical: 20.0,
                  //   horizontal: 20.0,
                  // ),
                              padding: EdgeInsets.only(top: 5),

                  width: MediaQuery.of(context).size.width / 2.3,
            height: MediaQuery.of(context).size.height / 4.5,
                  child: ClipRect(
                    child: PhotoView(
                          imageProvider: NetworkImage("http://dxcapphcm001.vdc.csc.com" +
                    widget.asset[index]["asset_image"]),
                     // imageProvider: const Image.memory("http://dxcapphcm001.vdc.csc.com" +widget.asset[index]["asset_image"],),
                      maxScale: PhotoViewComputedScale.covered * 2.0,
                      minScale: PhotoViewComputedScale.contained * 0.8,
                      initialScale: PhotoViewComputedScale.covered,
                    ),
                  ),
                ),

          SizedBox(
          width: 7,
        ),
             Expanded(
           // width: MediaQuery.of(context).size.width / 5,
            child: Text(
              widget.asset[index]["asset_tag"] != null
                  ? widget.asset[index]["asset_tag"]
                  : "Asset tag",
              style: TextStyle(fontSize: 20,color: Colors.grey),
            )), 
            
      
      ],
      
    );
  }

  _aseetImageNull() {
    return Row(
      children: <Widget>[
        Container(
            padding: EdgeInsets.only(top: 5),
                 width: MediaQuery.of(context).size.width / 2.7,
            height: MediaQuery.of(context).size.height / 4.6,
            child: Image.asset("images/no_image.png")),
        SizedBox(
          width: 10,
        ),
        Container(
            width: MediaQuery.of(context).size.width / 3,
            child: Text(
              "Asset Tag",
              style: TextStyle(fontSize: 20, color: Colors.grey),
            ))
      ],
    );
  }

  @override
  void initState() {
    //imageCache.clear();
    super.initState();
        print("initiititititiitititiitti2212121222");

    //  DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache(); //clears all data in cache.
    //    PaintingBinding.instance.imageCache.clear();
    // imageCache.clear();
       PaintingBinding.instance.imageCache.clear();

    if (widget.asset == null) {
      widget.asset = [];
    }
  }
  @override
  void dispose() {

//    imageCache.clear();
     PaintingBinding.instance.imageCache.clear(); ////////clear cache image
super.dispose();
    //  DefaultCacheManager manager = new DefaultCacheManager();
    // manager.emptyCache(); //clears all data in cache.
   // print("ondisposeeeeeeeeeeeee232311111");
  //  widget.asset.clear();
     if(widget.asset !=null){
       widget.asset =null;
     }
  //  imageCache.clear();
  // PaintingBinding.instance.imageCache.clear();
   
    
  }


}


// class DetailScreen extends StatefulWidget {
//    final String imageProvider;
//    DetailScreen(this.imageProvider);

//   @override
//   _DetailScreenState createState() => _DetailScreenState();
// }

// class _DetailScreenState extends State<DetailScreen> {
//     @override
//   // initState() {
//   //     imageCache.clear();
//   //     PaintingBinding.instance.imageCache.clear();
//   //   SystemChrome.setEnabledSystemUIOverlays([]);
//   //   super.initState();
//   // }

//   // @override
//   // void dispose() {
//   //     imageCache.clear();
//   //     PaintingBinding.instance.imageCache.clear();
//   //   //SystemChrome.restoreSystemUIOverlays();
//   //   SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
//   //   super.dispose();
//   // }
//   @override
//   Widget build(BuildContext context ) {
//     return Scaffold(
//       body: GestureDetector(
//         child: Center(
//           child: Hero(
//             tag: 'imageHero',
//             child: CachedNetworkImage(imageUrl: widget.imageProvider,)
//           ),
//         ),
       
//       ),
//     );
//   }
// }



// class CustomChildExample extends StatelessWidget {
//  final String url;
//  CustomChildExample(this.url);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
           
              
//                   child: PhotoView.customChild(
//                     child: Container(
//                         decoration:
//                             const BoxDecoration(color: Colors.lightGreenAccent),
//                         padding: const EdgeInsets.all(10.0),
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: <Widget>[
//                             const Text(
//                               "Hello there, this is a text, that is a svg:",
//                               style: const TextStyle(fontSize: 10.0),
//                               textAlign: TextAlign.center,
//                             ),
//                            Image.network(url),
//                           ],
//                         )),
//                     childSize: const Size(220.0, 250.0),
//                     initialScale: 1.0,
//                   ),
                
//               );
//   }
// }