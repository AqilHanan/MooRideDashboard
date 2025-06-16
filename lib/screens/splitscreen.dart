// import 'package:flutter/material.dart';
// import 'mapPage.dart';
// import 'dashboardpage.dart';
//
// class SplitScreenMapPage extends StatelessWidget {
//   const SplitScreenMapPage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
//
//     return Scaffold(
//       body: isLandscape
//           ? Row(
//         children: [
//           Expanded(
//             flex: 1,
//             child: Scaffold(
//               backgroundColor: Colors.black,
//               body: SafeArea(
//                 child: Column(
//                   children: [
//                     // ───── TOP BAR ─────
//                     Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           const Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "ngee ann",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 36,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               Text(
//                                 "polytechnic",
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 28,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Column(
//                             crossAxisAlignment: CrossAxisAlignment.end,
//                             children: [
//                               const Text(
//                                 "MooVita",
//                                 style: TextStyle(
//                                   color: Colors.red,
//                                   fontSize: 36,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                               const Text(
//                                 "DRIVING AUTONOMOUS\nMOVER SOLUTIONS",
//                                 style: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 12,
//                                 ),
//                                 textAlign: TextAlign.right,
//                               ),
//                               const SizedBox(height: 4),
//                               Text(
//                                 // "Time: $_formattedTime",
//                                 "Time: $Bus1_Time",
//                                 style: const TextStyle(
//                                   color: Colors.yellow,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//
//                     // ───── MIDDLE SECTION ─────
//                     Expanded(
//                       child: Center(
//                         child: Column(
//                           mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Container(
//                               color: Colors.grey[900],
//                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                               child: Text(
//                                 "Next Bus Stop: $Bus1_Stop",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontSize: 32,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 20),
//                             Container(
//                               color: Colors.grey[900],
//                               padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                               child: Text(
//                                 // "ETA: N/A",
//                                 "ETA: $Bus1_ETA",
//                                 style: TextStyle(
//                                   color: Colors.orange,
//                                   fontSize: 28,
//                                   fontWeight: FontWeight.bold,
//                                 ),
//                               ),
//                             ),
//                             const SizedBox(height: 30),
//                             Text(
//                               "Passengers: $Bus1_Count\nSpeed: $Bus1_Speed km/h",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                 color: Colors.cyanAccent,
//                                 fontSize: 24,
//                                 height: 1.5,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//
//                     // ───── FOOTER ─────
//                     Container(
//                       width: double.infinity,
//                       color: Colors.grey[900],
//                       padding: const EdgeInsets.all(16),
//                       child: const Text(
//                         "Thank you for travelling with us. Enjoy your trip!",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(
//                           color: Colors.yellow,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ), // Your existing map widget
//           ),
//
//
//
//
//
//           // MAP PAGE
//
//
//
//
//           Expanded(
//             flex: 1,
//             child: Scaffold(
//               // body: currentLocation == null? LoadingScreen(isDarkMode: _isDarkMode) : Stack(
//               body: Stack(
//                 children: [
//                   FlutterMap(
//                     options: MapOptions(
//                       //initialCenter: LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                       initialCenter: currentLocation == null? LatLng(1.3331191965635956, 103.7765424614437) :
//                       LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                       initialZoom: 18,
//                       // initialRotation: _heading,
//                       initialRotation: 0,
//                       interactionOptions: const InteractionOptions(
//                           flags: ~InteractiveFlag.doubleTapZoom),
//                     ),
//                     children: [
//                       TileLayer(
//                         urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                         userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//                         tileBuilder: _isDarkMode == true
//                             ? (BuildContext context, Widget tileWidget, TileImage tile) {
//                           return ColorFiltered(
//                             colorFilter: const ColorFilter.matrix(<double>[
//                               -1,  0,  0, 0, 255,
//                               0, -1,  0, 0, 255,
//                               0,  0, -1, 0, 255,
//                               0,  0,  0, 1,   0,
//                             ]),
//                             child: tileWidget,
//                           );
//                         }
//                             : null,
//                       ),
//                       PolylineLayer(
//                         //polylineCulling: false,
//                           polylines: [
//                             Polyline(
//                               // points: now.hour > startAfternoonService ? routePointsAM : routePointsPM,
//                               points: routepoints,
//                               //points: ENT_TO_B23,
//                               color: Colors.blue,
//                               strokeWidth: 5,
//                               // Define a single StrokePattern
//                               pattern: StrokePattern.dashed(
//                                 segments: [1, 7],
//                                 patternFit: PatternFit.scaleUp,
//                               ),
//                             ),
//                           ]),
//                       MarkerLayer(
//                           markers: [
//                             Marker(
//                               point: ENT,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('ENT'),
//                                           content: Text('Entrance Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('ENT', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                                 point: Bus1_Location ??
//                                     LatLng(1.3323127398440282, 103.774728443874),
//                                 child: Container(
//                                   width: 50,
//                                   height: 60,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         'Bus1',
//                                         style: TextStyle(
//                                             fontSize: 8,
//                                             color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Icon(
//                                         Icons.directions_bus,
//                                         // Icons.circle_sharp,
//                                         color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                         size: 17,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//
//                             ),
//                             Marker(
//                                 point: Bus2_Location ??
//                                     LatLng(1.3323127398440282, 103.774728443874),
//                                 child: Container(
//                                   width: 50,
//                                   height: 60,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         'Bus2',
//                                         style: TextStyle(
//                                             fontSize: 8,
//                                             color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Icon(
//                                         Icons.directions_bus,
//                                         // Icons.circle_sharp,
//                                         color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                         size: 17,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//
//                             ),
//                             Marker(
//                                 point: Bus3_Location ??
//                                     LatLng(1.3323127398440282, 103.774728443874),
//                                 child: Container(
//                                   width: 50,
//                                   height: 60,
//                                   child: Column(
//                                     mainAxisSize: MainAxisSize.min,
//                                     children: [
//                                       Text(
//                                         'Bus3',
//                                         style: TextStyle(
//                                             fontSize: 8,
//                                             color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Icon(
//                                         Icons.directions_bus,
//                                         // Icons.circle_sharp,
//                                         // color: Colors.blue[900],
//                                         color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                         size: 17,
//                                       ),
//                                     ],
//                                   ),
//                                 )
//
//                             ),
//                             if (currentLocation != null)
//                               Marker(
//                                   point: currentLocation!,
//                                   child: CustomPaint(
//                                       size: Size(300, 200),
//                                       painter: CompassPainter(
//                                         direction: _heading,
//                                         arcSweepAngle: 360,
//                                         arcStartAngle: 0,
//                                       )
//                                   )
//                               ),
//                             Marker(
//                               point: CLE,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('CLE'),
//                                           content: Text('Clementi MRT Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : _isDarkMode ? Colors.blue[900] : Colors.red,
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             // color : _isDarkMode ? Colors.blue[900] : Colors.red,
//                             Marker(
//                               point: KAP,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('KAP'),
//                                           content: Text('King Albert Park MRT Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : _isDarkMode ? Colors.blue[900] : Colors.red,
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                                 point: OPP_KAP,
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   color: Colors.blue[900],
//                                   size: (25),
//                                 )
//                             ),
//                             Marker(
//                               point: B23,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('B23'),
//                                           content: Text('Block 23 Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('B23', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: SPH,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('SPH'),
//                                           content: Text('Sports Hall Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('SPH', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: SIT,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('SIT'),
//                                           content: Text('Singapore Institute of Technology Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('SIT', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: B44,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('B44'),
//                                           content: Text('Block 44 Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('B44', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: B37,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('B37'),
//                                           content: Text('Block 37 Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('B37', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: MAP,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('MAP'),
//                                           content: Text('Makan Place Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('MAP', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: HSC,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('HSC'),
//                                           content: Text('School of Health Sciences Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('HSC', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: LCT,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('LCT'),
//                                           content: Text('School of Life Sciences & Technology Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('LCT', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                             Marker(
//                               point: B72,
//                               child: GestureDetector(
//                                 onTap: (){
//                                   showDialog(context: context,
//                                       builder: (BuildContext context) {
//                                         return AlertDialog(
//                                           title: const Text('B72'),
//                                           content: Text('Block 72 Bus Stop'),
//                                           actions: [
//                                             TextButton(
//                                                 onPressed: () {
//                                                   Navigator.pop(context);
//                                                 },
//                                                 child: Text('Close'))
//                                           ],
//                                         );
//                                       }
//                                   );
//                                 },
//                                 child: Icon(
//                                   CupertinoIcons.location_circle_fill,
//                                   // color: Colors.red,
//                                   color : getMarkerColor('B72', busIndex),
//                                   size: (25),
//                                 ),
//                               ),
//                             ),
//                           ]),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(0, 30.0, 10.0, 0),
//                         child: CircularMenu(
//                             alignment: Alignment.topRight,
//                             radius: 80.0,
//                             toggleButtonColor: Colors.cyan,
//                             curve: Curves.easeInOut,
//                             items: [
//                               CircularMenuItem(
//                                   color: Colors.yellow[300],
//                                   iconSize: 30.0,
//                                   margin: 10.0,
//                                   padding: 10.0,
//                                   icon: Icons.info_rounded,
//                                   onTap: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Information_Page(isDarkMode: _isDarkMode)));
//                                   }
//                               ),
//                               CircularMenuItem(
//                                   color: Colors.green[300],
//                                   iconSize: 30.0,
//                                   margin: 10.0,
//                                   padding: 10.0,
//                                   icon: Icons.settings,
//                                   onTap: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme)));
//                                   }
//                               ),
//                               CircularMenuItem(
//                                   color: Colors.pink[300],
//                                   iconSize: 30.0,
//                                   margin: 10.0,
//                                   padding: 10.0,
//                                   icon: Icons.newspaper,
//                                   onTap: () {
//                                     Navigator.push(context, MaterialPageRoute(builder: (context) => NewsAnnouncement(isDarkMode: _isDarkMode)));
//                                   }
//                               ),
//                             ]
//                         ),
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.fromLTRB(8.0, 40.0, 0.0, 0),
//                         child: Align(
//                           alignment: Alignment.topLeft,
//                           child: ClipOval(
//                             child: Image.asset(
//                               'images/logo.jpeg',
//                               width: 70,
//                               height: 70,
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SlidingUpPanel(
//                     onPanelOpened: _onPanelOpened,
//                     onPanelClosed: _onPanelClosed,
//                     panelBuilder: (controller) {
//                       return Container(
//                         color: _isDarkMode ? Colors.lightBlue[900] : Colors.lightBlue[100],
//                         child: SingleChildScrollView(
//                             controller: controller,
//                             child: Column(
//                               children: [
//                                 Align(
//                                   alignment: Alignment.centerLeft,
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(8.0),
//                                     child: Text(
//                                       'MooBus on-demand',
//                                       style: TextStyle(
//                                         color: _isDarkMode ? Colors.white : Colors.black,
//                                         fontSize: 18,
//                                         fontWeight: FontWeight.bold,
//                                         fontFamily: 'Montserrat',
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 displayPage,
//                                 SizedBox(height: 16),
//                                 News_Announcement_Widget(isDarkMode: _isDarkMode),
//                                 SizedBox(height: 20),
//                               ],
//                             )
//                         ),
//                       );
//                     },
//                   ),
//                 ],
//               ),
//             );, // Placeholder for your dashboard
//           ),
//         ],
//       )
//           : Scaffold(
//         // body: currentLocation == null? LoadingScreen(isDarkMode: _isDarkMode) : Stack(
//         body: Stack(
//           children: [
//             FlutterMap(
//               options: MapOptions(
//                 //initialCenter: LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                 initialCenter: currentLocation == null? LatLng(1.3331191965635956, 103.7765424614437) :
//                 LatLng(currentLocation!.latitude, currentLocation!.longitude),
//                 initialZoom: 18,
//                 // initialRotation: _heading,
//                 initialRotation: 0,
//                 interactionOptions: const InteractionOptions(
//                     flags: ~InteractiveFlag.doubleTapZoom),
//               ),
//               children: [
//                 TileLayer(
//                   urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
//                   userAgentPackageName: 'dev.fleaflet.flutter_map.example',
//                   tileBuilder: _isDarkMode == true
//                       ? (BuildContext context, Widget tileWidget, TileImage tile) {
//                     return ColorFiltered(
//                       colorFilter: const ColorFilter.matrix(<double>[
//                         -1,  0,  0, 0, 255,
//                         0, -1,  0, 0, 255,
//                         0,  0, -1, 0, 255,
//                         0,  0,  0, 1,   0,
//                       ]),
//                       child: tileWidget,
//                     );
//                   }
//                       : null,
//                 ),
//                 PolylineLayer(
//                   //polylineCulling: false,
//                     polylines: [
//                       Polyline(
//                         // points: now.hour > startAfternoonService ? routePointsAM : routePointsPM,
//                         points: routepoints,
//                         //points: ENT_TO_B23,
//                         color: Colors.blue,
//                         strokeWidth: 5,
//                         // Define a single StrokePattern
//                         pattern: StrokePattern.dashed(
//                           segments: [1, 7],
//                           patternFit: PatternFit.scaleUp,
//                         ),
//                       ),
//                     ]),
//                 MarkerLayer(
//                     markers: [
//                       Marker(
//                         point: ENT,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('ENT'),
//                                     content: Text('Entrance Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('ENT', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                           point: Bus1_Location ??
//                               LatLng(1.3323127398440282, 103.774728443874),
//                           child: Container(
//                             width: 50,
//                             height: 60,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   'Bus1',
//                                   style: TextStyle(
//                                       fontSize: 8,
//                                       color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Icon(
//                                   Icons.directions_bus,
//                                   // Icons.circle_sharp,
//                                   color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                   size: 17,
//                                 ),
//                               ],
//                             ),
//                           )
//
//                       ),
//                       Marker(
//                           point: Bus2_Location ??
//                               LatLng(1.3323127398440282, 103.774728443874),
//                           child: Container(
//                             width: 50,
//                             height: 60,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   'Bus2',
//                                   style: TextStyle(
//                                       fontSize: 8,
//                                       color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Icon(
//                                   Icons.directions_bus,
//                                   // Icons.circle_sharp,
//                                   color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                   size: 17,
//                                 ),
//                               ],
//                             ),
//                           )
//
//                       ),
//                       Marker(
//                           point: Bus3_Location ??
//                               LatLng(1.3323127398440282, 103.774728443874),
//                           child: Container(
//                             width: 50,
//                             height: 60,
//                             child: Column(
//                               mainAxisSize: MainAxisSize.min,
//                               children: [
//                                 Text(
//                                   'Bus3',
//                                   style: TextStyle(
//                                       fontSize: 8,
//                                       color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                       fontWeight: FontWeight.bold),
//                                 ),
//                                 Icon(
//                                   Icons.directions_bus,
//                                   // Icons.circle_sharp,
//                                   // color: Colors.blue[900],
//                                   color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
//                                   size: 17,
//                                 ),
//                               ],
//                             ),
//                           )
//
//                       ),
//                       if (currentLocation != null)
//                         Marker(
//                             point: currentLocation!,
//                             child: CustomPaint(
//                                 size: Size(300, 200),
//                                 painter: CompassPainter(
//                                   direction: _heading,
//                                   arcSweepAngle: 360,
//                                   arcStartAngle: 0,
//                                 )
//                             )
//                         ),
//                       Marker(
//                         point: CLE,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('CLE'),
//                                     content: Text('Clementi MRT Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : _isDarkMode ? Colors.blue[900] : Colors.red,
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       // color : _isDarkMode ? Colors.blue[900] : Colors.red,
//                       Marker(
//                         point: KAP,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('KAP'),
//                                     content: Text('King Albert Park MRT Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : _isDarkMode ? Colors.blue[900] : Colors.red,
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                           point: OPP_KAP,
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             color: Colors.blue[900],
//                             size: (25),
//                           )
//                       ),
//                       Marker(
//                         point: B23,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('B23'),
//                                     content: Text('Block 23 Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('B23', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: SPH,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('SPH'),
//                                     content: Text('Sports Hall Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('SPH', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: SIT,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('SIT'),
//                                     content: Text('Singapore Institute of Technology Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('SIT', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: B44,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('B44'),
//                                     content: Text('Block 44 Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('B44', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: B37,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('B37'),
//                                     content: Text('Block 37 Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('B37', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: MAP,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('MAP'),
//                                     content: Text('Makan Place Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('MAP', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: HSC,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('HSC'),
//                                     content: Text('School of Health Sciences Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('HSC', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: LCT,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('LCT'),
//                                     content: Text('School of Life Sciences & Technology Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('LCT', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                       Marker(
//                         point: B72,
//                         child: GestureDetector(
//                           onTap: (){
//                             showDialog(context: context,
//                                 builder: (BuildContext context) {
//                                   return AlertDialog(
//                                     title: const Text('B72'),
//                                     content: Text('Block 72 Bus Stop'),
//                                     actions: [
//                                       TextButton(
//                                           onPressed: () {
//                                             Navigator.pop(context);
//                                           },
//                                           child: Text('Close'))
//                                     ],
//                                   );
//                                 }
//                             );
//                           },
//                           child: Icon(
//                             CupertinoIcons.location_circle_fill,
//                             // color: Colors.red,
//                             color : getMarkerColor('B72', busIndex),
//                             size: (25),
//                           ),
//                         ),
//                       ),
//                     ]),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(0, 30.0, 10.0, 0),
//                   child: CircularMenu(
//                       alignment: Alignment.topRight,
//                       radius: 80.0,
//                       toggleButtonColor: Colors.cyan,
//                       curve: Curves.easeInOut,
//                       items: [
//                         CircularMenuItem(
//                             color: Colors.yellow[300],
//                             iconSize: 30.0,
//                             margin: 10.0,
//                             padding: 10.0,
//                             icon: Icons.info_rounded,
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => Information_Page(isDarkMode: _isDarkMode)));
//                             }
//                         ),
//                         CircularMenuItem(
//                             color: Colors.green[300],
//                             iconSize: 30.0,
//                             margin: 10.0,
//                             padding: 10.0,
//                             icon: Icons.settings,
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme)));
//                             }
//                         ),
//                         CircularMenuItem(
//                             color: Colors.pink[300],
//                             iconSize: 30.0,
//                             margin: 10.0,
//                             padding: 10.0,
//                             icon: Icons.newspaper,
//                             onTap: () {
//                               Navigator.push(context, MaterialPageRoute(builder: (context) => NewsAnnouncement(isDarkMode: _isDarkMode)));
//                             }
//                         ),
//                       ]
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.fromLTRB(8.0, 40.0, 0.0, 0),
//                   child: Align(
//                     alignment: Alignment.topLeft,
//                     child: ClipOval(
//                       child: Image.asset(
//                         'images/logo.jpeg',
//                         width: 70,
//                         height: 70,
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//             SlidingUpPanel(
//               onPanelOpened: _onPanelOpened,
//               onPanelClosed: _onPanelClosed,
//               panelBuilder: (controller) {
//                 return Container(
//                   color: _isDarkMode ? Colors.lightBlue[900] : Colors.lightBlue[100],
//                   child: SingleChildScrollView(
//                       controller: controller,
//                       child: Column(
//                         children: [
//                           Align(
//                             alignment: Alignment.centerLeft,
//                             child: Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Text(
//                                 'MooBus on-demand',
//                                 style: TextStyle(
//                                   color: _isDarkMode ? Colors.white : Colors.black,
//                                   fontSize: 18,
//                                   fontWeight: FontWeight.bold,
//                                   fontFamily: 'Montserrat',
//                                 ),
//                               ),
//                             ),
//                           ),
//                           displayPage,
//                           SizedBox(height: 16),
//                           News_Announcement_Widget(isDarkMode: _isDarkMode),
//                           SizedBox(height: 20),
//                         ],
//                       )
//                   ),
//                 );
//               },
//             ),
//           ],
//         ),
//       );, // In portrait, show map only or adjust as needed
//     );
//   }
// }
