import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sensors/sensors.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:testsensor/test.dart';

void main() async {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sensors Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(
        child: SimpleTimeSeriesChart.withSampleData(),
      ),
    );
  }
}
//      home: MyHomePage(title: 'Flutter Demo Home Page'),

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Timer _timer;
  _write(
    List text,
  ) async {
    DateTime now = DateTime.now();

    final directory = await getExternalStorageDirectory();
    final file = File('${directory.path}/my_file+$now.txt');
    print(directory.path);
    for (int i = 0; i < text.length; i++) {
      await file.writeAsString(text[i], mode: FileMode.append);
    }
    print(result);
    setState(() {
      result.clear();
    });
  }

  // Future<String> _read() async {
  //   String text;
  //   try {
  //     final directory = await getExternalStorageDirectory();
  //     final file = File('${directory.path}/my_file.txt');
  //     text = await file.readAsString();
  //   } catch (e) {
  //     print("Couldn't read file");
  //   }
  //   return text;
  // }

  bool _start = false;
  void startTimer(int number) {
    final oneSec = Duration(milliseconds: number);
    _timer = new Timer.periodic(
      oneSec,
      (Timer timer) => setState(
        () {
          _streamSubscriptions
              .add(accelerometerEvents.listen((AccelerometerEvent event) {
            setState(() {
              // print(_accelerometerValues.toString() + "_gyroscopeValues");
              // print(DateTime.now().toUtc().microsecondsSinceEpoch);
              _accelerometerValues = <double>[event.x, event.y, event.z];
            });
          }));

          // time = time +
          //     [
          //       DateTime.now().toUtc().microsecondsSinceEpoch.toString() +
          //           "  "
          //     ];
          result = result +
              [
                "accelerometer" +
                    _accelerometerValues.toString() +
                    " , " +
                    DateTime.now().toUtc().millisecondsSinceEpoch.toString() +
                    "\n"
              ];

          _streamSubscriptions
              .add(gyroscopeEvents.listen((GyroscopeEvent event) {
            setState(() {
              // print(_gyroscopeValues.toString() + "_gyroscopeValues");
              // print(DateTime.now().toUtc().microsecondsSinceEpoch);
              _gyroscopeValues = <double>[event.x, event.y, event.z];
            });
          }));

          result = result +
              [
                "gyroscopeEvents" +
                    _gyroscopeValues.toString() +
                    " , " +
                    DateTime.now().toUtc().millisecondsSinceEpoch.toString() +
                    "\n"
              ];

          _streamSubscriptions.add(
              userAccelerometerEvents.listen((UserAccelerometerEvent event) {
            setState(() {
              // print(_userAccelerometerValues.toString() +
              //     "_userAccelerometerValues");
              // print(DateTime.now().toUtc().microsecondsSinceEpoch);
              _userAccelerometerValues = <double>[event.x, event.y, event.z];
            });
          }));

          result = result +
              [
                "userAccelerometerEvents" +
                    _userAccelerometerValues.toString() +
                    " , " +
                    DateTime.now().toUtc().millisecondsSinceEpoch.toString() +
                    "\n"
              ];

          //   print(time);
          // print(result);
          if (_start == false) {
            for (StreamSubscription<dynamic> subscription
                in _streamSubscriptions) {
              subscription.cancel();
            }
            timer.cancel();
          }
        },
      ),
    );
  }

  void start() {
    setState(() {
      _start = !_start;

      time.clear();
    });
  }

  List time = [];
  List result = [];
  List<double> _accelerometerValues;
  List<double> _userAccelerometerValues;
  List<double> _gyroscopeValues;
  List<StreamSubscription<dynamic>> _streamSubscriptions =
      <StreamSubscription<dynamic>>[];
  TextEditingController input = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final List<String> accelerometer =
        _accelerometerValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> gyroscope =
        _gyroscopeValues?.map((double v) => v.toStringAsFixed(1))?.toList();
    final List<String> userAccelerometer = _userAccelerometerValues
        ?.map((double v) => v.toStringAsFixed(1))
        ?.toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sensor Example'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Center(
              child: Container(
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "100 milliseconds default",
                //labelText: setDisplay(0),
                filled: true,
              ),
              controller: input,
            ),
            padding: EdgeInsets.all(30),
          )),
          FloatingActionButton(
            child: Text(_start ? "Stop" : "Start"),
            onPressed: () async {
              startTimer(input.text == "" ? 100 : int.parse(input.text));
              if (_start == true && result.isNotEmpty) {
                _write(
                  result,
                );
              }

              // result.map((f) => _write(f));
              start();
            },
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Accelerometer: $accelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('UserAccelerometer: $userAccelerometer'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
          Padding(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Gyroscope: $gyroscope'),
              ],
            ),
            padding: const EdgeInsets.all(16.0),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
    for (StreamSubscription<dynamic> subscription in _streamSubscriptions) {
      subscription.cancel();
    }
  }

  @override
  void initState() {
    requestPermission();
    super.initState();
  }

  Future<void> requestPermission() async {
    Map<PermissionGroup, PermissionStatus> permissions =
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
  }
}
