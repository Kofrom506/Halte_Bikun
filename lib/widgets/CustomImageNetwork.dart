// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter/painting.dart';
// import 'package:flutter/widgets.dart';
// import 'package:http/http.dart' as http;
// import 'dart:typed_data'; // for Uint8List
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
//
// class CustomNetworkImage extends ImageProvider<CustomNetworkImage> {
//   final String url;
//
//   CustomNetworkImage(this.url);
//
//   @override
//   ImageStreamCompleter load(CustomNetworkImage key, DecoderCallback decode) {
//     return MultiFrameImageStreamCompleter(
//       codec: _loadAsync(key),
//       scale: 1.0,
//       informationCollector: () sync* {
//         yield ErrorDescription('Image URL: $url');
//       },
//     );
//   }
//
//   Future<Codec> _loadAsync(CustomNetworkImage key) async {
//     var response = await http.get(Uri.parse('${key.url}?${DateTime.now().millisecondsSinceEpoch}'));
//     return await PaintingBinding.instance.instantiateImageCodec(Uint8List.fromList(response.bodyBytes));
//   }
//
//   @override
//   Future<CustomNetworkImage> obtainKey(ImageConfiguration configuration) {
//     return SynchronousFuture<CustomNetworkImage>(this);
//   }
//
//   @override
//   bool operator ==(Object other) {
//     if (other.runtimeType != runtimeType) return false;
//     final CustomNetworkImage typedOther = other;
//     return url == typedOther.url;
//   }
//
//   @override
//   int get hashCode => url.hashCode;
// }
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Disable Image Cache'),
//         ),
//         body: Center(
//           child: Image(
//             image: CustomNetworkImage('https://example.com/your_image_url.jpg'), // Replace with your image URL
//             fit: BoxFit.cover,
//           ),
//         ),
//       ),
//     );
//   }
// }
