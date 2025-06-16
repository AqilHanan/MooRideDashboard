// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'dart:async';
// import 'mapPage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:flutter_map/flutter_map.dart';
// import 'package:mini_project_five/data/global.dart';
// import 'dart:async';
// import 'package:sliding_up_panel/sliding_up_panel.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
// import '../services/getLocation.dart';
// import '../services/mqtt.dart';
// import '../utils/loading.dart';
// import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
//
//
// class DashboardPage extends StatefulWidget {
//   @override
//   _DashboardPageState createState() => _DashboardPageState();
// }
//
// class _DashboardPageState extends State<DashboardPage> {
//   String _formattedTime = '';
//
//   void _updateTime() {
//     final now = DateTime.now();
//     final formatter = DateFormat('HH:mm:ss');
//     setState(() {
//       _formattedTime = formatter.format(now);
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: Column(
//           children: [
//             // ───── TOP BAR ─────
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   const Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "ngee ann",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 36,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       Text(
//                         "polytechnic",
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: 28,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Column(
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: [
//                       const Text(
//                         "MooVita",
//                         style: TextStyle(
//                           color: Colors.red,
//                           fontSize: 36,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const Text(
//                         "DRIVING AUTONOMOUS\nMOVER SOLUTIONS",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: 12,
//                         ),
//                         textAlign: TextAlign.right,
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         // "Time: $_formattedTime",
//                         "Time: $Bus1_Time",
//                         style: const TextStyle(
//                           color: Colors.yellow,
//                           fontSize: 20,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//
//             // ───── MIDDLE SECTION ─────
//             Expanded(
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Container(
//                       color: Colors.grey[900],
//                       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
//                       child: Text(
//                         "Next Bus Stop: $Bus1_Stop",
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 32,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 20),
//                     Container(
//                       color: Colors.grey[900],
//                       padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
//                       child: Text(
//                         // "ETA: N/A",
//                         "ETA: $Bus1_ETA",
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 28,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                     const SizedBox(height: 30),
//                     Text(
//                       "Passengers: $Bus1_Count\nSpeed: $Bus1_Speed km/h",
//                       textAlign: TextAlign.center,
//                       style: TextStyle(
//                         color: Colors.cyanAccent,
//                         fontSize: 24,
//                         height: 1.5,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//
//             // ───── FOOTER ─────
//             Container(
//               width: double.infinity,
//               color: Colors.grey[900],
//               padding: const EdgeInsets.all(16),
//               child: const Text(
//                 "Thank you for travelling with us. Enjoy your trip!",
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Colors.yellow,
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
