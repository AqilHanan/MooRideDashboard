import 'package:circular_menu/circular_menu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:latlong2/latlong.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:mini_project_five/data/global.dart';
import 'package:mini_project_five/screens/afternoonScreen.dart';
import 'package:mini_project_five/screens/info.dart';
import 'package:mini_project_five/screens/morningScreen.dart';
import 'package:mini_project_five/screens/newsAnnouncement.dart';
import 'package:mini_project_five/screens/settings.dart';
import 'dart:async';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../services/getLocation.dart';
import '../services/mqtt.dart';
import '../utils/loading.dart';

class Map_Page extends StatefulWidget {
  const Map_Page({super.key});

  @override
  State<Map_Page> createState() => _Map_PageState();
}

class _Map_PageState extends State<Map_Page> with WidgetsBindingObserver {
  Timer? _timer;
  int selectedBox = 0;
  LatLng? currentLocation;
  double _heading = 0.0;
  List<LatLng> routepoints = [];
  int service_time = 9;
  bool ignoring = false;
  bool _isDarkMode = false;
  LatLng? Bus_Location;
  LocationService _locationService = LocationService();
  MQTT_Connect _mqttConnect = MQTT_Connect();
  DateTime now = DateTime.now();
  
  List<LatLng> ENT_TO_B23 = [
    LatLng(1.3327930713846318, 103.77771893587253),
    LatLng(1.333101, 103.776525),
    LatLng(1.333618, 103.776227),
    LatLng(1.333739, 103.775779),
    LatLng(1.3339219201675242, 103.77574132061896),
    LatLng(1.335013, 103.775976),
    LatLng(1.3350826567868576, 103.7754223503998),
    LatLng(1.3343686930989717, 103.77435631203087),
    LatLng(1.3329522845882348, 103.77145520892851), //b44
    LatLng(1.332733, 103.771030),
    //maybe add one turn more here to make it look nicer ?
    LatLng(1.332234, 103.771065),
    LatLng(1.331942, 103.772277),
    LatLng(1.3327697559194817, 103.77323977064727), //b37
    LatLng(1.332927, 103.773556),
    LatLng(1.3324019134469306, 103.7747380910866) , //map
    LatLng(1.3298012679376835, 103.77465550100018) //hsc

  ];



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getLocation();
    _mqttConnect = MQTT_Connect();
    _mqttConnect.createState().initState(); // Assuming you have this function in your MQTT_Connect class.

    // Subscribe to the ValueNotifier for bus location updates
    MQTT_Connect.busLocationNotifier.addListener(() {
      setState(() {
        Bus_Location = MQTT_Connect.busLocationNotifier.value;
      });
    });
  }

  void _getLocation() {
    _locationService.getCurrentLocation().then((location) {
      setState(() {
        currentLocation = location;
        print('Printing current location: $currentLocation');
      });
    });
    _locationService.initCompass((heading){
      setState(() {
        _heading = heading;
      });
    });
  }

  void _toggleTheme(bool value) {
    setState(() {
      _isDarkMode = value;
    });
  }

  void updateSelectedBox(int selectedBox) {
    setState(() {
      this.selectedBox = selectedBox;
      if (selectedBox == 1)
        fetchRoute(LatLng(1.3359291665604225, 103.78307744418207));
      else if (selectedBox == 2)
        fetchRoute(LatLng(1.3157535241817033, 103.76510924418207));
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    //subscription.cancel();
    //client.disconnect();
    super.dispose();
  }

  Future<void> fetchRoute(LatLng destination) async {
    LatLng start = LatLng(1.3327930713846318, 103.77771893587253);
    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/foot/${destination.longitude},${destination
            .latitude};${start.longitude},${start
            .latitude}?overview=simplified&steps=true');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        routepoints.clear();
        routepoints.add(start);
        var data = jsonDecode(response.body);

        if (data['routes'] != null) {
          String encodedPolyline = data['routes'][0]['geometry'];
          List<LatLng> decodedCoordinates = PolylinePoints()
              .decodePolyline(encodedPolyline)
              .map((point) => LatLng(point.latitude, point.longitude))
              .toList();
          routepoints.addAll(decodedCoordinates);
        }
      });
    }
  }

  void _onPanelOpened() {
    setState(() {
      ignoring = true;
    });
  }

  void _onPanelClosed() {
    setState(() {
      ignoring = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget displayPage = now.hour > startAfternoonService ? Afternoon_Screen(updateSelectedBox: updateSelectedBox, isDarkMode: _isDarkMode,) : Morning_Screen(updateSelectedBox: updateSelectedBox);
     return Scaffold(
      body: currentLocation == null? LoadingScreen(isDarkMode: _isDarkMode) : Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(currentLocation!.latitude, currentLocation!.longitude),
              initialZoom: 18,
              initialRotation: _heading,
              interactionOptions: const InteractionOptions(
                  flags: ~InteractiveFlag.doubleTapZoom),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                tileBuilder: _isDarkMode == true
                    ? (BuildContext context, Widget tileWidget, TileImage tile) {
                  return ColorFiltered(
                    colorFilter: const ColorFilter.matrix(<double>[
                      -1,  0,  0, 0, 255,
                      0, -1,  0, 0, 255,
                      0,  0, -1, 0, 255,
                      0,  0,  0, 1,   0,
                    ]),
                    child: tileWidget,
                  );
                }
                    : null,
              ),
              PolylineLayer(
                //polylineCulling: false,
                  polylines: [
                    Polyline(
                      points: routepoints,
                      //points: ENT_TO_B23,
                      color: Colors.blue,
                      strokeWidth: 5,
                      // Define a single StrokePattern
                      pattern: StrokePattern.dashed(
                        segments: [1, 7],
                        patternFit: PatternFit.scaleUp,
                      ),
                    ),
                    Polyline(
                      points: ENT_TO_B23,
                      color: Colors.blue,
                      strokeWidth: 5,
                      pattern: StrokePattern.dashed(
                          segments: [1,7],
                        patternFit: PatternFit.scaleUp ,
                      )
                    )
                  ]),
              MarkerLayer(markers: [
                Marker(
                    point: Bus_Location ??
                        LatLng(1.3323127398440282, 103.774728443874),
                    child: Icon(
                      Icons.circle_sharp,
                      color: Colors.blueAccent,
                      size: 23,
                    )
                ),
                Marker(
                    point: currentLocation!,
                    child: CustomPaint(
                        size: Size(300, 200),
                        painter: CompassPainter(
                          direction: _heading,
                          arcSweepAngle: 360,
                          arcStartAngle: 0,
                        )
                    )
                )
              ]),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30.0, 10.0, 0),
                child: CircularMenu(
                    alignment: Alignment.topRight,
                    radius: 80.0,
                    toggleButtonColor: Colors.cyan,
                    curve: Curves.easeInOut,
                    items: [
                      CircularMenuItem(
                          color: Colors.yellow[300],
                          iconSize: 30.0,
                          margin: 10.0,
                          padding: 10.0,
                          icon: Icons.info_rounded,
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Information_Page(isDarkMode: _isDarkMode)));
                          }
                      ),
                      CircularMenuItem(
                          color: Colors.green[300],
                          iconSize: 30.0,
                          margin: 10.0,
                          padding: 10.0,
                          icon: Icons.settings,
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => Settings(isDarkMode: _isDarkMode, onThemeChanged: _toggleTheme)));
                          }
                      ),
                      CircularMenuItem(
                          color: Colors.pink[300],
                          iconSize: 30.0,
                          margin: 10.0,
                          padding: 10.0,
                          icon: Icons.newspaper,
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewsAnnouncement(isDarkMode: _isDarkMode)));
                          }
                      ),
                    ]
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(8.0, 40.0, 0.0, 0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: ClipOval(
                    child: Image.asset(
                      'images/logo.jpeg',
                      width: 70,
                      height: 70,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ],
          ),
          SlidingUpPanel(
            onPanelOpened: _onPanelOpened,
            onPanelClosed: _onPanelClosed,
            panelBuilder: (controller) {
              return Container(
                color: _isDarkMode ? Colors.lightBlue[900] : Colors.lightBlue[100],
                child: SingleChildScrollView(
                    controller: controller,
                    child: Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'MooBus on-demand',
                              style: TextStyle(
                                color: _isDarkMode ? Colors.white : Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        displayPage,
                        SizedBox(height: 16),
                        News_Announcement_Widget(isDarkMode: _isDarkMode),
                        SizedBox(height: 20),
                      ],
                    )
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

