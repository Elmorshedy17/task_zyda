// import 'package:flutter/material.dart';
// // import 'package:google_maps_webservice/places.dart';
// import 'package:flutter_google_places/flutter_google_places.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:google_place/google_place.dart';
// import 'package:m1/features/ads/sign_up_manager.dart';
// import 'package:m1/app_core/app_core.dart';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:google_place/google_place.dart';
// import 'dart:async';
//
//
// class StoreMap extends StatefulWidget {
//   final String placeId;
//   final GooglePlace googlePlace;
//
//   StoreMap({Key key, this.placeId, this.googlePlace}) : super(key: key);
//   @override
//
//   _StoreMapState createState() => _StoreMapState(this.placeId, this.googlePlace);
// }
//
// class _StoreMapState extends State<StoreMap> {
//   final String placeId;
//   final GooglePlace googlePlace;
//
//   _StoreMapState(this.placeId, this.googlePlace);
//
//
//   DetailsResult detailsResult;
//   List<Uint8List> images = [];
//
//
//
//   List <Tab>tabs = [
//     Tab("Location",0),
//     Tab("Account",1),
//     Tab("Verity",2),
//   ];
//
//   List<AutocompletePrediction> predictions = [];
//
//   BitmapDescriptor pinLocationIcon;
//
//
//   @override
//   void initState() {
//     getDetils(this.placeId);
//     // String apiKey = DotEnv().env['https://maps.googleapis.com/maps/api/place/autocomplete/json?key=AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I&input=vodafone%20international&language=en&components=country%3Aeg&types=establishment'];
//     // googlePlace = GooglePlace('AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I');
//     BitmapDescriptor.fromAssetImage(ImageConfiguration(devicePixelRatio: 2.5),
//         'assets/images/icn_round_location_pin.png')
//         .then((onValue) {
//       pinLocationIcon = onValue;
//     });
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     var HomeManger = context.use<HomeManger>();
//
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         leading: InkWell(
//           onTap: (){},
//           child: Icon(Icons.keyboard_backspace,color: Color(0xffd95265)),
//         ),
//         centerTitle: true,
//         title: Text("Sign Up",style: TextStyle(color: Color(0xffd95265)),),
//
//       ),
//       body: StreamBuilder(
//           initialData: 0,
//           stream: HomeManger.tabs.stream,
//           builder: (context, snapshot) {
//             return Container(
//               padding: EdgeInsets.all(15),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   SizedBox(
//                     height: 10,),
//                   Container(
//                     height: 50,
//                     // color: Colors.red,
//                     child: ListView(
//                       children: tabs.map((e) => InkWell(
//                         onTap: (){
//                           HomeManger.tabs.add(e.id);
//                         },
//                         child: Container(
//                           padding: EdgeInsets.only(right: 15),
//                           child: Column(
//                             children: [
//                               Text(e.title,style: TextStyle(
//                                   color: snapshot.data == e.id ? Color(0xffd95265) : Color(0xffc8ccda),
//                                   fontSize: 16
//                               ),),
//                               SizedBox(height: 5,),
//                               Container(
//                                 width: 80,
//                                 height: 3,
//                                 decoration: BoxDecoration(
//                                   color:snapshot.data == e.id ? Color(0xffd95265) : Color(0xffc8ccda),
//                                   shape: BoxShape.rectangle,
//                                   borderRadius: BorderRadius.circular(5),
//                                 ),
//                               )
//                             ],
//                             mainAxisSize: MainAxisSize.min,
//                             mainAxisAlignment: MainAxisAlignment.start,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                           ),
//                         ),
//                       )).toList(),
//                       scrollDirection: Axis.horizontal,
//
//                     ),),
//                   Row(
//                     children: [
//                       Container(
//                         child: Image.asset("assets/images/icn_company.png"),
//                       ),
//                       SizedBox(width: 8,),
//                       Text("Set your work location",style: TextStyle(color: Color(0xff727a8a),fontSize: 16,fontWeight: FontWeight.w600),)
//                     ],
//                   ),
//                   SizedBox(height: 20,),
//                   detailsResult != null && detailsResult.types != null
//                       ? Container(
//                     margin: EdgeInsets.only(left: 15, top: 10),
//                     height: 50,
//                     child: ListView.builder(
//                       scrollDirection: Axis.horizontal,
//                       itemCount: detailsResult.types.length,
//                       itemBuilder: (context, index) {
//                         return Container(
//                           margin: EdgeInsets.only(right: 10),
//                           child: Chip(
//                             label: Text(
//                               detailsResult.types[index],
//                               style: TextStyle(
//                                 color: Colors.white,
//                               ),
//                             ),
//                             backgroundColor: Colors.blueAccent,
//                           ),
//                         );
//                       },
//                     ),
//                   )
//                       : Container(),
//                   Container(
//                     margin: EdgeInsets.only(left: 15, top: 10),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Icon(Icons.location_on),
//                       ),
//                       title: Text(
//                         detailsResult != null &&
//                             detailsResult.formattedAddress != null
//                             ? 'Address: ${detailsResult.name}'
//                             : "Address: null",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15, top: 10),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Icon(Icons.location_searching),
//                       ),
//                       title: Text(
//                         detailsResult != null &&
//                             detailsResult.geometry != null &&
//                             detailsResult.geometry.location != null
//                             ? 'Geometry: ${detailsResult.geometry.location.lat.toString()},${detailsResult.geometry.location.lng.toString()}'
//                             : "Geometry: null",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15, top: 10),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Icon(Icons.timelapse),
//                       ),
//                       title: Text(
//                         detailsResult != null &&
//                             detailsResult.utcOffset != null
//                             ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
//                             : "UTC offset: null",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15, top: 10),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Icon(Icons.rate_review),
//                       ),
//                       title: Text(
//                         detailsResult != null &&
//                             detailsResult.rating != null
//                             ? 'Rating: ${detailsResult.rating.toString()}'
//                             : "Rating: null",
//                       ),
//                     ),
//                   ),
//                   Container(
//                     margin: EdgeInsets.only(left: 15, top: 10),
//                     child: ListTile(
//                       leading: CircleAvatar(
//                         child: Icon(Icons.attach_money),
//                       ),
//                       title: Text(
//                         detailsResult != null &&
//                             detailsResult.priceLevel != null
//                             ? 'Price level: ${detailsResult.priceLevel.toString()}'
//                             : "Price level: null",
//                       ),
//                     ),
//                   ),
//                   Container(
//                       height: 300,
//                       width: 300,
//                       child: MapSample())
//                 ],
//               ),
//             );
//           }
//       ),
// // This trailing comma makes auto-formatting nicer for build methods.
//     );
//
//   }
//   void autoCompleteSearch(String value) async {
//     var result = await googlePlace.autocomplete.get(value,components:[Component("country", "eg")],language: "en",types:"establishment");
//     if (result != null && result.predictions != null && mounted) {
//       setState(() {
//         predictions = result.predictions;
//       });
//     }
//   }
//   void getDetils(String placeId) async {
//     var result = await this.googlePlace.details.get(placeId);
//     if (result != null && result.result != null && mounted) {
//       setState(() {
//         detailsResult = result.result;
//         images = [];
//       });
//       print("detailsResult${detailsResult}");
//       if (result.result.photos != null) {
//         for (var photo in result.result.photos) {
//           getPhoto(photo.photoReference);
//         }
//       }
//     }
//   }
//
//   void getPhoto(String photoReference) async {
//     var result = await this.googlePlace.photos.get(photoReference, null, 400);
//     if (result != null && mounted) {
//       setState(() {
//         images.add(result);
//       });
//     }
//   }
// }
//
//
// class Tab {
//   String title;
//   int id;
//   Tab(this.title,this.id);
// }
//
// class DetailsPage extends StatefulWidget {
//   final String placeId;
//   final GooglePlace googlePlace;
//
//   DetailsPage({Key key, this.placeId, this.googlePlace}) : super(key: key);
//
//   @override
//   _DetailsPageState createState() =>
//       _DetailsPageState(this.placeId, this.googlePlace);
// }
//
// class _DetailsPageState extends State<DetailsPage> {
//   final String placeId;
//   final GooglePlace googlePlace;
//
//   _DetailsPageState(this.placeId, this.googlePlace);
//
//   DetailsResult detailsResult;
//   List<Uint8List> images = [];
//
//   @override
//   void initState() {
//     getDetils(this.placeId);
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Details"),
//         backgroundColor: Colors.blueAccent,
//       ),
//       floatingActionButton: FloatingActionButton(
//         backgroundColor: Colors.blueAccent,
//         onPressed: () {
//           getDetils(this.placeId);
//         },
//         child: Icon(Icons.refresh),
//       ),
//       body: SafeArea(
//         child: Container(
//           margin: EdgeInsets.only(right: 20, left: 20, top: 20),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: <Widget>[
//               Container(
//                 height: 200,
//                 child: ListView.builder(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: images.length,
//                   itemBuilder: (context, index) {
//                     return Container(
//                       width: 250,
//                       child: Card(
//                         elevation: 4,
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(10.0),
//                         ),
//                         child: ClipRRect(
//                           borderRadius: BorderRadius.circular(10.0),
//                           child: Image.memory(
//                             images[index],
//                             fit: BoxFit.fill,
//                           ),
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//               SizedBox(
//                 height: 10,
//               ),
//               Expanded(
//                 child: Card(
//                   elevation: 4,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(10.0),
//                   ),
//                   child: ListView(
//                     children: <Widget>[
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: Text(
//                           "Details",
//                           style: TextStyle(
//                             fontSize: 20,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                       ),
//                       detailsResult != null && detailsResult.types != null
//                           ? Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         height: 50,
//                         child: ListView.builder(
//                           scrollDirection: Axis.horizontal,
//                           itemCount: detailsResult.types.length,
//                           itemBuilder: (context, index) {
//                             return Container(
//                               margin: EdgeInsets.only(right: 10),
//                               child: Chip(
//                                 label: Text(
//                                   detailsResult.types[index],
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                                 backgroundColor: Colors.blueAccent,
//                               ),
//                             );
//                           },
//                         ),
//                       )
//                           : Container(),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.location_on),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.formattedAddress != null
//                                 ? 'Address: ${detailsResult.name}'
//                                 : "Address: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.location_searching),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.geometry != null &&
//                                 detailsResult.geometry.location != null
//                                 ? 'Geometry: ${detailsResult.geometry.location.lat.toString()},${detailsResult.geometry.location.lng.toString()}'
//                                 : "Geometry: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.timelapse),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.utcOffset != null
//                                 ? 'UTC offset: ${detailsResult.utcOffset.toString()} min'
//                                 : "UTC offset: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.rate_review),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.rating != null
//                                 ? 'Rating: ${detailsResult.rating.toString()}'
//                                 : "Rating: null",
//                           ),
//                         ),
//                       ),
//                       Container(
//                         margin: EdgeInsets.only(left: 15, top: 10),
//                         child: ListTile(
//                           leading: CircleAvatar(
//                             child: Icon(Icons.attach_money),
//                           ),
//                           title: Text(
//                             detailsResult != null &&
//                                 detailsResult.priceLevel != null
//                                 ? 'Price level: ${detailsResult.priceLevel.toString()}'
//                                 : "Price level: null",
//                           ),
//                         ),
//                       ),
//                       // MapSample(pinLocationIcon)
//                     ],
//                   ),
//                 ),
//               ),
//               Container(
//                 margin: EdgeInsets.only(top: 20, bottom: 10),
//                 child: Image.asset("assets/powered_by_google.png"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void getDetils(String placeId) async {
//     var result = await this.googlePlace.details.get(placeId);
//     if (result != null && result.result != null && mounted) {
//       setState(() {
//         detailsResult = result.result;
//         images = [];
//       });
//       print("detailsResult${detailsResult}");
//       if (result.result.photos != null) {
//         for (var photo in result.result.photos) {
//           getPhoto(photo.photoReference);
//         }
//       }
//     }
//   }
//
//   void getPhoto(String photoReference) async {
//     var result = await this.googlePlace.photos.get(photoReference, null, 400);
//     if (result != null && mounted) {
//       setState(() {
//         images.add(result);
//       });
//     }
//   }
// }
// class MapSample extends StatefulWidget {
//   // final pinLocationIcon ;
//   //
//   // MapSample(this.pinLocationIcon);
//
//   @override
//   State<MapSample> createState() => MapSampleState();
// }
//
// class MapSampleState extends State<MapSample> {
//
//   List<Marker> markers = [];
//
//   Completer<GoogleMapController> _controller = Completer();
//
//
//   void _onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//
//     // setState(() {
//     //   markers.add(
//     //     Marker(
//     //         markerId: MarkerId("hhh"),
//     //         position:
//     //         LatLng(25.4215415802915, 49.57626108029149),
//     //         infoWindow: InfoWindow(title: 'ttt'),
//     //         icon: widget.pinLocationIcon),
//     //   );
//     // });
//
//     return Stack(
//       children: <Widget>[
//         GoogleMap(
//           scrollGesturesEnabled: true,
//           myLocationEnabled: false,
//           mapType: MapType.normal,
//           compassEnabled: true,
//           zoomControlsEnabled: true,
//           zoomGesturesEnabled: true,
//           onMapCreated: _onMapCreated,
//           initialCameraPosition: CameraPosition(
//             target: LatLng(25.4202053,
//                 49.574952),
//             zoom: 12,
//           ),
//           markers: Set<Marker>.of(markers), //
//         ),
//       ],
//     );
//   }
//
//
// }
//
