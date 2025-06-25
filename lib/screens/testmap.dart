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
import 'package:mini_project_five/utils/markerColour.dart';
import 'dart:async';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import '../services/getLocation.dart';
import '../services/mqtt.dart';
import '../utils/loading.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';


class testMap_Page extends StatefulWidget {
  const testMap_Page({super.key});

  @override
  State<testMap_Page> createState() => _testMap_PageState();
}


class _testMap_PageState extends State<testMap_Page> with WidgetsBindingObserver {
  Timer? _timer;
  int selectedBox = 0;
  LatLng? currentLocation;
  double _heading = 0.0;
  List<LatLng> routepoints = [];
  int service_time = 9;
  bool ignoring = false;
  bool _isDarkMode = false;

  LatLng? Bus1_Location;
  String? Bus1_Time;
  double? Bus1_Speed;
  String? Bus1_Stop;
  String? Bus1_ETA;
  int? Bus1_Count;

  LatLng? Bus2_Location;
  String? Bus2_Time;
  double? Bus2_Speed;
  String? Bus2_Stop;
  String? Bus2_ETA;
  int? Bus2_Count;

  LatLng? Bus3_Location;
  String? Bus3_Time;
  double? Bus3_Speed;
  String? Bus3_Stop;
  String? Bus3_ETA;
  int? Bus3_Count;

  int selectedBus = 1;

  Timer? _bus1Timeout;
  Timer? _bus2Timeout;
  Timer? _bus3Timeout;

  final mapController = MapController();



  LocationService _locationService = LocationService();
  MQTT_Connect _mqttConnect = MQTT_Connect();
  DateTime now = DateTime.now();

  LatLng ENT = LatLng(1.332959, 103.777306);
  LatLng CLE = LatLng(1.313434, 103.765811); // change to test out
  LatLng KAP = LatLng(1.335844, 103.783160);
  LatLng B23 = LatLng(1.333801, 103.775738);
  LatLng SPH = LatLng(1.335110, 103.775464);
  LatLng SIT = LatLng(1.334510, 103.774504);
  LatLng B44 = LatLng(1.3329522845882348, 103.77145520892851);
  LatLng B37 = LatLng(1.332797, 103.773304);
  LatLng MAP = LatLng(1.332473, 103.774377);
  LatLng HSC = LatLng(1.330028, 103.774623);
  LatLng LCT = LatLng(1.330895, 103.774870);
  LatLng B72 = LatLng(1.3314596165361228, 103.7761976140868);
  LatLng OPP_KAP = LatLng(1.336274, 103.783146); //OPP KAP

  LatLng? lastCenteredLocation;



  List<LatLng> AM_KAP = [
    // TODO: currently set to OPPKAP instead of KAP
    // LatLng(1.3365156413692888, 103.78278794804254), // KAP
    LatLng(1.335844, 103.783160),
    LatLng(1.326394, 103.775705), // UTURN
    LatLng(1.3329143792222058, 103.77742909276205), // ENT
    LatLng(1.3324019134469306, 103.7747380910866), // MAP
  ];

  List<LatLng> AM_CLE = [
    LatLng(1.3153179405495476, 103.76538319080443), // CLE
    LatLng(1.3329143792222058, 103.77742909276205), // ENT
    LatLng(1.3324019134469306, 103.7747380910866), // MAP
  ];

  List<LatLng> PM_KAP = [
    LatLng(1.3329143792222058, 103.77742909276205), // ENT
    LatLng(1.3339219201675242, 103.77574132061896), // B23
    LatLng(1.3350826567868576, 103.7754223503998), // SPH
    LatLng(1.3343686930989717, 103.77435631203087), // SIT
    LatLng(1.3329522845882348, 103.77145520892851), // B44
    LatLng(1.3327697559194817, 103.77323977064727), // B37
    LatLng(1.3325776073001032, 103.77438270405088),

    // LatLng(1.3324019134469306, 103.7747380910866), // MAP
    //TODO: something wrong with MAP to HSC
    LatLng(1.330028, 103.774623), //HSC
    LatLng(1.3307778258080973, 103.77543148160284), //between hsc and lct
    LatLng(1.3311533369747423, 103.77490110804173), // LCT
    LatLng(1.3312394356934057, 103.77644173403719), // B72
    LatLng(1.3365156413692888, 103.78278794804254), // OPPKAP
  ];

  List<LatLng> PM_CLE = [
    LatLng(1.3329143792222058, 103.77742909276205), // ENT
    LatLng(1.3339219201675242, 103.77574132061896), // B23
    LatLng(1.3350826567868576, 103.7754223503998), // SPH
    LatLng(1.3343686930989717, 103.77435631203087), // SIT
    LatLng(1.3329522845882348, 103.77145520892851), // B44
    LatLng(1.3327697559194817, 103.77323977064727), // B37
    LatLng(1.3325776073001032, 103.77438270405088),
    // LatLng(1.3324019134469306, 103.7747380910866), // MAP
    //TODO: something wrong with MAP to HSC
    LatLng(1.330028, 103.774623), //HSC
    LatLng(1.3307778258080973, 103.77543148160284), //between hsc and lct
    LatLng(1.3311533369747423, 103.77490110804173), // LCT
    LatLng(1.3312394356934057, 103.77644173403719), // B72
    LatLng(1.331820636037709, 103.77790742890757), //CLE UTURN
    LatLng(1.314967973664341, 103.765121458707), //CLE A

  ];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _getLocation();
    _mqttConnect = MQTT_Connect();
    _mqttConnect.createState().initState(); // Assuming you have this function in your MQTT_Connect class.



    Timer.periodic(Duration(seconds: 1), (timer) {
      if (selectedBus == 1 && Bus1_Location != null) {
        if (Bus1_Location != lastCenteredLocation) {
          centerMapOnSelectedBus();
          print("Polling: Centering on new location");
        }
      } else if (selectedBus == 2 && Bus2_Location != null) {
        if (Bus2_Location != lastCenteredLocation) {
          centerMapOnSelectedBus();
        }
      } else if (selectedBus == 3 && Bus3_Location != null) {
        if (Bus3_Location != lastCenteredLocation) {
          centerMapOnSelectedBus();
        }
      }
    });

    // Subscribe to the ValueNotifier for bus location updates
    // BUS 1
    // BUS 1
    // BUS 1
    MQTT_Connect.bus1LocationNotifier.addListener(() {
      _resetBus1Timeout();
      setState(() {
        Bus1_Location = MQTT_Connect.bus1LocationNotifier.value;
      });
    });

    MQTT_Connect.bus1SpeedNotifier.addListener(() {
      _resetBus1Timeout();
      setState(() {
        Bus1_Speed = MQTT_Connect.bus1SpeedNotifier.value;
      });
    });
    MQTT_Connect.bus1TimeNotifier.addListener(() {
      _resetBus1Timeout();
      setState(() {
        Bus1_Time = MQTT_Connect.bus1TimeNotifier.value;
      });
    });

    MQTT_Connect.bus1StopNotifier.addListener(() {
      _resetBus1Timeout();
      setState(() {
        Bus1_Stop = MQTT_Connect.bus1StopNotifier.value;
      });
    });

    MQTT_Connect.bus1ETANotifier.addListener(() {
      _resetBus1Timeout();
      setState(() {
        Bus1_ETA = MQTT_Connect.bus1ETANotifier.value;
      });
    });

    MQTT_Connect.bus1CountNotifier.addListener(() {
      _resetBus1Timeout();
      setState(() {
        Bus1_Count = MQTT_Connect.bus1CountNotifier.value;
      });
    });
    // BUS 1
    // BUS 1
    // BUS 1

    // BUS 2
    // BUS 2
    // BUS 2
    MQTT_Connect.bus2LocationNotifier.addListener(() {
      _resetBus2Timeout();
      setState(() {
        Bus2_Location = MQTT_Connect.bus2LocationNotifier.value;
      });
    });

    MQTT_Connect.bus2SpeedNotifier.addListener(() {
      _resetBus2Timeout();
      setState(() {
        Bus2_Speed = MQTT_Connect.bus2SpeedNotifier.value;
      });
    });
    MQTT_Connect.bus2TimeNotifier.addListener(() {
      _resetBus2Timeout();
      setState(() {
        Bus2_Time = MQTT_Connect.bus2TimeNotifier.value;
      });
    });

    MQTT_Connect.bus2StopNotifier.addListener(() {
      _resetBus2Timeout();
      setState(() {
        Bus2_Stop = MQTT_Connect.bus2StopNotifier.value;
      });
    });

    MQTT_Connect.bus2ETANotifier.addListener(() {
      _resetBus2Timeout();
      setState(() {
        Bus2_ETA = MQTT_Connect.bus2ETANotifier.value;
      });
    });

    MQTT_Connect.bus2CountNotifier.addListener(() {
      _resetBus2Timeout();
      setState(() {
        Bus2_Count = MQTT_Connect.bus2CountNotifier.value;
      });
    });
    // BUS 2
    // BUS 2
    // BUS 2

    // BUS 3
    // BUS 3
    // BUS 3
    MQTT_Connect.bus3LocationNotifier.addListener(() {
      _resetBus3Timeout();
      setState(() {
        Bus3_Location = MQTT_Connect.bus3LocationNotifier.value;
      });
    });

    MQTT_Connect.bus3SpeedNotifier.addListener(() {
      _resetBus3Timeout();
      setState(() {
        Bus3_Speed = MQTT_Connect.bus3SpeedNotifier.value;
      });
    });
    MQTT_Connect.bus3TimeNotifier.addListener(() {
      _resetBus3Timeout();
      setState(() {
        Bus3_Time = MQTT_Connect.bus3TimeNotifier.value;
      });
    });

    MQTT_Connect.bus3StopNotifier.addListener(() {
      _resetBus3Timeout();
      setState(() {
        Bus3_Stop = MQTT_Connect.bus3StopNotifier.value;
      });
    });

    MQTT_Connect.bus3ETANotifier.addListener(() {
      _resetBus3Timeout();
      setState(() {
        Bus3_ETA = MQTT_Connect.bus3ETANotifier.value;
      });
    });

    MQTT_Connect.bus3CountNotifier.addListener(() {
      _resetBus3Timeout();
      setState(() {
        Bus3_Count = MQTT_Connect.bus3CountNotifier.value;
      });
    });
    // BUS 3
    // BUS 3
    // BUS 3
  }

  void centerMapOnSelectedBus() {
    LatLng? selectedLocation;

    if (selectedBus == 1) {
      selectedLocation = Bus1_Location;
    } else if (selectedBus == 2) {
      selectedLocation = Bus2_Location;
    } else if (selectedBus == 3) {
      selectedLocation = Bus3_Location;
    }

    if (selectedLocation != null && selectedLocation != lastCenteredLocation) {
      mapController.move(selectedLocation, 18.0);
      lastCenteredLocation = selectedLocation;
    }
  }

  void _resetBus1Timeout() {
    _bus1Timeout?.cancel();
    _bus1Timeout = Timer(Duration(seconds: 30), () {
      setState(() {
        print("timing bus1 out");
        Bus1_Location = null;
        Bus1_Time = null;
        Bus1_Speed = null;
        Bus1_Stop = null;
        Bus1_ETA = null;
        Bus1_Count = null;
      });
    });
  }

  void _resetBus2Timeout() {
    _bus2Timeout?.cancel();
    _bus2Timeout = Timer(Duration(seconds: 30), () {
      setState(() {
        print("timing bus2 out");
        Bus2_Location = null;
        Bus2_Time = null;
        Bus2_Speed = null;
        Bus2_Stop = null;
        Bus2_ETA = null;
        Bus2_Count = null;
      });
    });
  }

  void _resetBus3Timeout() {
    _bus3Timeout?.cancel();
    _bus3Timeout = Timer(Duration(seconds: 30), () {
      setState(() {
        print("timing bus3 out");
        Bus3_Location = null;
        Bus3_Time = null;
        Bus3_Speed = null;
        Bus3_Stop = null;
        Bus3_ETA = null;
        Bus3_Count = null;
      });
    });
  }






  // void _getLocation() {
  //   _locationService.getCurrentLocation().then((location) {
  //     setState(() {
  //       currentLocation = location;
  //       print('Printing current location: $currentLocation');
  //       print("Bus Location: ${Bus1_Location}");
  //     });
  //   });
  //   _locationService.initCompass((heading){
  //     setState(() {
  //       _heading = heading;
  //     });
  //   });
  // }

  void _getLocation() {
    // Initial location fetch
    _locationService.getCurrentLocation().then((location) {
      setState(() {
        currentLocation = location;
        print('Printing current location: $currentLocation');
      });
    });

    // Set up periodic location updates
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      _locationService.getCurrentLocation().then((location) {
        setState(() {
          currentLocation = location;
          print('Updated location: $currentLocation');
        });
      });
    });

    // Compass heading updates
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

  void updateSelectedBox(int selectedBox) async {
    setState(() {
      this.selectedBox = selectedBox;
      if (selectedBox == 1) { //KAP
        //fetchRoute(LatLng(1.3359291665604225, 103.78307744418207));
        //fetchAM_KAPRoute();
        if (now.hour > startAfternoonService)
          fetchRoute(PM_KAP);
        else
          fetchRoute(AM_KAP);
      }
      else if (selectedBox == 2) { //CLE
        //fetchRoute(LatLng(1.3157535241817033, 103.76510924418207));
        //fetchAM_CLERoute();
        if (now.hour > startAfternoonService)
          fetchRoute(PM_CLE);
        else
          fetchRoute(AM_CLE);
      }
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _timer?.cancel();
    _bus1Timeout?.cancel();
    _bus2Timeout?.cancel();
    _bus3Timeout?.cancel();
    super.dispose();
  }


  Future<void> fetchRoute(List<LatLng> waypoints) async {
    // LatLng start = LatLng(1.3327930713846318, 103.77771893587253);
    String waypointsStr = waypoints.map((point) => '${point.longitude},${point.latitude}').join(';');
    // TODO: Currently set to morning route, add additional for afternoon route
    var url = Uri.parse(
        'http://router.project-osrm.org/route/v1/foot/${waypointsStr}?overview=simplified&steps=true&continue_straight=true');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      setState(() {
        routepoints.clear();
        //routepoints.add(start);
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
    // final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    // Widget displayPage = Morning_Screen(updateSelectedBox: updateSelectedBox);
    // Widget displayPage = Afternoon_Screen(updateSelectedBox: updateSelectedBox, isDarkMode: _isDarkMode);
    Widget displayPage = now.hour > startAfternoonService ? Afternoon_Screen(updateSelectedBox: updateSelectedBox, isDarkMode: _isDarkMode,) : Morning_Screen(updateSelectedBox: updateSelectedBox);
    final String busTime = selectedBus == 1 ? (Bus1_Time ?? "N/A")
        : selectedBus == 2 ? (Bus2_Time ?? "N/A")
        : (Bus3_Time ?? "N/A");

    final String busStop = selectedBus == 1 ? (Bus1_Stop ?? "N/A")
        : selectedBus == 2 ? (Bus2_Stop ?? "N/A")
        : (Bus3_Stop ?? "N/A");

    final String busETA = selectedBus == 1 ? (Bus1_ETA ?? "N/A")
        : selectedBus == 2 ? (Bus2_ETA ?? "N/A")
        : (Bus3_ETA ?? "N/A");

    final int busCount = selectedBus == 1 ? (Bus1_Count ?? 0)
        : selectedBus == 2 ? (Bus2_Count ?? 0)
        : (Bus3_Count ?? 0);

    final double busSpeed = selectedBus == 1 ? (Bus1_Speed ?? 0.0)
        : selectedBus == 2 ? (Bus2_Speed ?? 0.0)
        : (Bus3_Speed ?? 0.0);
    final String busRoute = selectedBus == 1 ? "KAP Route" : selectedBus == 2 ? "KAP Route" : "Clementi Route"; // You edit content later
    AppBar(title: Text('MooRide Dashboard'),);
    return Scaffold(
      body:
      // isLandscape ?
      Row(
          children: [

            // ─── Main Panel ───
            Expanded(
              flex: 1,
              // SizedBox(
              // width: MediaQuery.of(context).size.width * 0.5,
              child: Container(
                color: Colors.black,
                child: SafeArea(
                  child: Container(
                    color: Colors.black,
                    child: SafeArea(


                      child: Column(
                        children: [
                          // ───── TOP BAR ─────
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "ngee ann",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "polytechnic",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Row(
                                      children: List.generate(3, (index) {
                                        return Padding(
                                          padding: const EdgeInsets.only(right: 8.0),
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: selectedBus == index + 1 ? Colors.orange : Colors.grey,
                                            ),
                                            onPressed: () {
                                              setState(() {
                                                selectedBus = index + 1;
                                                if (selectedBus == 1) {
                                                  fetchRoute(PM_KAP);
                                                }
                                                if (selectedBus == 2) {
                                                  fetchRoute(PM_KAP);
                                                }
                                                if (selectedBus == 3) {
                                                  fetchRoute(PM_CLE);
                                                }
                                                centerMapOnSelectedBus();
                                              });
                                            },
                                            child: Text('B${index + 1}'),
                                          ),
                                        );
                                      }),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    const Text(
                                      "MooVita",
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 36,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const Text(
                                      "DRIVING AUTONOMOUS\nMOVER SOLUTIONS",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                      textAlign: TextAlign.right,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      "Time: $busTime",
                                      style: const TextStyle(
                                        color: Colors.yellow,
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),

                          // ───── MIDDLE SECTION ─────
                          Expanded(
                            // SizedBox(
                            child: Center(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    color: Colors.grey[900],
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                                    child: Text(
                                      "Next Bus Stop: $busStop",
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 32,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  Container(
                                    color: Colors.grey[900],
                                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
                                    child: Text(
                                      "ETA: $busETA",
                                      style: const TextStyle(
                                        color: Colors.orange,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 30),
                                  Text(
                                    "Passengers: ${busCount.toString()}\nSpeed: ${busSpeed.toString()} km/h",
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.cyanAccent,
                                      fontSize: 24,
                                      height: 1.5,
                                    ),
                                  ),
                                  const SizedBox(height: 16),

                                  // ─── Route Display ───
                                  Text(
                                    "Route: $busRoute",
                                    style: const TextStyle(
                                      color: Colors.lightGreenAccent,
                                      fontSize: 22,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // ───── FOOTER ─────
                          Container(
                            width: double.infinity,
                            color: Colors.grey[900],
                            padding: const EdgeInsets.all(16),
                            child: const Text(
                              "Thank you for travelling with us. Enjoy your trip!",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),





            // MAP PAGE





            Expanded(
              flex: 1,
              child: Container(
                color: Colors.white,
                child: Column(

                children: [
                  Expanded(
                    child: Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController,
                      options: MapOptions(
                        //initialCenter: LatLng(currentLocation!.latitude, currentLocation!.longitude),
                        initialCenter: currentLocation == null ? LatLng(
                            1.3331191965635956, 103.7765424614437) :
                        LatLng(currentLocation!.latitude,
                            currentLocation!.longitude),
                        initialZoom: 18,
                        // initialRotation: _heading,
                        initialRotation: 0,
                        interactionOptions: const InteractionOptions(
                            flags: ~InteractiveFlag.doubleTapZoom),
                      ),
                      children: [
                        TileLayer(
                          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          // urlTemplate: 'https://a.tile.openstreetmap.fr/hot/{z}/{x}/{y}.png',
                          // userAgentPackageName: 'com.ngeeannpoly.mooride',
                          userAgentPackageName: 'dev.fleaflet.flutter_map.example',

                          tileBuilder: _isDarkMode == true
                              ? (BuildContext context, Widget tileWidget,
                              TileImage tile) {
                            return ColorFiltered(
                              colorFilter: const ColorFilter.matrix(<double>[
                                -1, 0, 0, 0, 255,
                                0, -1, 0, 0, 255,
                                0, 0, -1, 0, 255,
                                0, 0, 0, 1, 0,
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
                                // points: now.hour > startAfternoonService ? routePointsAM : routePointsPM,
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
                            ]),
                        MarkerLayer(
                            markers: [
                              Marker(
                                point: ENT,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('ENT'),
                                            content: Text('Entrance Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('ENT', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              if(Bus1_Location != null) Marker(
                                  point: Bus1_Location!,
                                  // point: Bus1_Location ??
                                  //     LatLng(1.3323127398440282, 103.774728443874),
                                  child: Container(
                                    width: 50,
                                    height: 60,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Bus1',
                                          style: TextStyle(
                                              fontSize: 8,
                                              // color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.directions_bus,
                                          // Icons.circle_sharp,
                                          // color: _isDarkMode ? Colors
                                          //     .lightBlueAccent : Colors
                                          //     .blue[900],
                                          color: Colors.red,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  )

                              ),
                              if(Bus2_Location != null) Marker(
                                point: Bus2_Location!,
                                // point: Bus2_Location ??
                                //     LatLng(1.3323127398440282, 103.774728443874),
                                child: Container(
                                  width: 50,
                                  height: 60,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        'Bus2',
                                        style: TextStyle(
                                            fontSize: 8,
                                            // color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900]
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Icon(
                                        Icons.directions_bus,
                                        // Icons.circle_sharp,
                                        // color: _isDarkMode ? Colors
                                        //     .lightBlueAccent : Colors.blue[900],
                                        color: Colors.red,
                                        size: 17,
                                      ),
                                    ],
                                  ),
                                ),

                              ),
                              if(Bus3_Location != null) Marker(
                                  point: Bus3_Location!,
                                  // point: Bus3_Location ??
                                  //     LatLng(1.3323127398440282, 103.774728443874),
                                  child: Container(
                                    width: 50,
                                    height: 60,
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text(
                                          'Bus3',
                                          style: TextStyle(
                                              fontSize: 8,
                                              // color: _isDarkMode ? Colors.lightBlueAccent : Colors.blue[900],
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Icon(
                                          Icons.directions_bus,
                                          // Icons.circle_sharp,
                                          // color: Colors.blue[900],
                                          // color: _isDarkMode ? Colors
                                          //     .lightBlueAccent : Colors
                                          //     .blue[900],
                                          color: Colors.red,
                                          size: 17,
                                        ),
                                      ],
                                    ),
                                  )

                              ),
                              if (currentLocation != null)
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
                                ),
                              Marker(
                                point: CLE,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('CLE'),
                                            content: Text(
                                                'Clementi MRT Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: Colors.blue[900],
                                    size: (25),
                                  ),
                                ),
                              ),
                              // color : _isDarkMode ? Colors.blue[900] : Colors.red,
                              Marker(
                                point: KAP,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('KAP'),
                                            content: Text(
                                                'King Albert Park MRT Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: Colors.blue[900],
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                  point: OPP_KAP,
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    color: Colors.blue[900],
                                    size: (25),
                                  )
                              ),
                              Marker(
                                point: B23,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('B23'),
                                            content: Text('Block 23 Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('B23', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: SPH,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('SPH'),
                                            content: Text(
                                                'Sports Hall Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('SPH', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: SIT,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('SIT'),
                                            content: Text(
                                                'Singapore Institute of Technology Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('SIT', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: B44,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('B44'),
                                            content: Text('Block 44 Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('B44', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: B37,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('B37'),
                                            content: Text('Block 37 Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('B37', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: MAP,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('MAP'),
                                            content: Text(
                                                'Makan Place Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('MAP', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: HSC,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('HSC'),
                                            content: Text(
                                                'School of Health Sciences Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('HSC', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: LCT,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('LCT'),
                                            content: Text(
                                                'School of Life Sciences & Technology Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('LCT', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                              Marker(
                                point: B72,
                                child: GestureDetector(
                                  onTap: () {
                                    showDialog(context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('B72'),
                                            content: Text('Block 72 Bus Stop'),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('Close'))
                                            ],
                                          );
                                        }
                                    );
                                  },
                                  child: Icon(
                                    CupertinoIcons.location_circle_fill,
                                    // color: Colors.red,
                                    color: getMarkerColor('B72', busIndex),
                                    size: (25),
                                  ),
                                ),
                              ),
                            ]),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(0, 30.0, 10.0, 0),
                        //   child: CircularMenu(
                        //       alignment: Alignment.topRight,
                        //       radius: 80.0,
                        //       toggleButtonColor: Colors.cyan,
                        //       curve: Curves.easeInOut,
                        //       items: [
                        //         CircularMenuItem(
                        //             color: Colors.yellow[300],
                        //             iconSize: 30.0,
                        //             margin: 10.0,
                        //             padding: 10.0,
                        //             icon: Icons.info_rounded,
                        //             onTap: () {
                        //               Navigator.push(context, MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       Information_Page(
                        //                           isDarkMode: _isDarkMode)));
                        //             }
                        //         ),
                        //         CircularMenuItem(
                        //             color: Colors.green[300],
                        //             iconSize: 30.0,
                        //             margin: 10.0,
                        //             padding: 10.0,
                        //             icon: Icons.settings,
                        //             onTap: () {
                        //               Navigator.push(context, MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       Settings(isDarkMode: _isDarkMode,
                        //                           onThemeChanged: _toggleTheme)));
                        //             }
                        //         ),
                        //         CircularMenuItem(
                        //             color: Colors.pink[300],
                        //             iconSize: 30.0,
                        //             margin: 10.0,
                        //             padding: 10.0,
                        //             icon: Icons.newspaper,
                        //             onTap: () {
                        //               Navigator.push(context, MaterialPageRoute(
                        //                   builder: (context) =>
                        //                       NewsAnnouncement(
                        //                           isDarkMode: _isDarkMode)));
                        //             }
                        //         ),
                        //       ]
                        //   ),
                        // ),
                        // Padding(
                        //   padding: const EdgeInsets.fromLTRB(8.0, 40.0, 0.0, 0),
                        //   child: Align(
                        //     alignment: Alignment.topLeft,
                        //     child: ClipOval(
                        //       child: Image.asset(
                        //         'images/logo.jpeg',
                        //         width: 70,
                        //         height: 70,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                    // SlidingUpPanel(
                    //   onPanelOpened: _onPanelOpened,
                    //   onPanelClosed: _onPanelClosed,
                    //   panelBuilder: (controller) {
                    //     return Container(
                    //       color: _isDarkMode ? Colors.lightBlue[900] : Colors.lightBlue[100],
                    //       child: SingleChildScrollView(
                    //         controller: controller,
                    //         child: ConstrainedBox(
                    //           constraints: BoxConstraints(
                    //             minHeight: 0,
                    //             maxHeight: MediaQuery.of(context).size.height * 0.7,
                    //           ),
                    //           child: IntrinsicHeight(
                    //             child: Column(
                    //               crossAxisAlignment: CrossAxisAlignment.start,
                    //               children: [
                    //                 // Title
                    //                 Align(
                    //                   alignment: Alignment.centerLeft,
                    //                   child: Padding(
                    //                     padding: const EdgeInsets.all(8.0),
                    //                     child: Text(
                    //                       'MooBus on-demand',
                    //                       style: TextStyle(
                    //                         color: _isDarkMode ? Colors.white : Colors.black,
                    //                         fontSize: 18,
                    //                         fontWeight: FontWeight.bold,
                    //                         fontFamily: 'Montserrat',
                    //                       ),
                    //                     ),
                    //                   ),
                    //                 ),
                    //
                    //                 // Display page
                    //                 displayPage,
                    //
                    //                 // Spacing
                    //                 SizedBox(height: 16),
                    //
                    //                 // News widget
                    //                 News_Announcement_Widget(isDarkMode: _isDarkMode),
                    //
                    //                 // Additional spacing
                    //                 SizedBox(height: 20),
                    //
                    //                 // Bus info (ensure all are Strings or use toString)
                    //                 Padding(
                    //                   padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    //                   child: Column(
                    //                     crossAxisAlignment: CrossAxisAlignment.start,
                    //                     children: [
                    //                       Text('${Bus1_Stop ?? "Stop: N/A"}'),
                    //                       Text('${Bus1_Speed ?? "Speed: N/A"}'),
                    //                       Text('${Bus1_Count ?? "Count: N/A"}'),
                    //                       Text('${Bus1_ETA ?? "ETA: N/A"}'),
                    //                       Text('${Bus1_Time ?? "Time: N/A"}'),
                    //                     ],
                    //                   ),
                    //                 ),
                    //
                    //                 SizedBox(height: 16),
                    //               ],
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     );
                    //   },
                    // ),sliding

                  ],
                ),
              ),
    ]
            ),
              )
            )
          ]
      ),
    );
  }
}
