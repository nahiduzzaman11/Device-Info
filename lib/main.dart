/*import 'dart:async';
import 'dart:developer' as developer;
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

void _enablePlatformOverrideForDesktop() {
  if (!kIsWeb && (Platform.isWindows || Platform.isLinux)) {
    debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  }
}

void main() {
  _enablePlatformOverrideForDesktop();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: const Color(0x9f4376f8),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _connectionStatus = 'Unknown';
  final NetworkInfo _networkInfo = NetworkInfo();

  @override
  void initState() {
    super.initState();
    _initNetworkInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WIFI INFO'),
        elevation: 4,
      ),
      body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Network info',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              Text(_connectionStatus),
            ],
          )),
    );
  }

  Future<void> _initNetworkInfo() async {
    String? wifiName,
        wifiBSSID,
        wifiIPv4,
        wifiIPv6,
        wifiGatewayIP,
        wifiBroadcast,
        wifiSubmask;

    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        // Request permissions as recommended by the plugin documentation:
        // https://github.com/fluttercommunity/plus_plugins/tree/main/packages/network_info_plus/network_info_plus
        if (await Permission.locationWhenInUse.request().isGranted) {
          wifiName = await _networkInfo.getWifiName();
        }
        else if (await Permission.location.isDenied) {
          await Permission.locationWhenInUse.request();
        }
        else if (await Permission.location.isRestricted) {
          openAppSettings();
        } else {
          wifiName = 'Unauthorized to get Wifi Name';
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi Name', error: e);
      wifiName = 'Failed to get Wifi Name';
    }

    try {
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        // Request permissions as recommended by the plugin documentation:
        // https://github.com/fluttercommunity/plus_plugins/tree/main/packages/network_info_plus/network_info_plus
        if (await Permission.locationWhenInUse.request().isGranted) {
          wifiBSSID = await _networkInfo.getWifiBSSID();
        } else if (await Permission.location.isDenied) {
          await Permission.locationWhenInUse.request();
        }
        else if (await Permission.location.isRestricted) {
          openAppSettings();
        } else {
          wifiBSSID = 'Unauthorized to get Wifi BSSID';
        }
      } else {
        wifiName = await _networkInfo.getWifiName();
      }
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi BSSID', error: e);
      wifiBSSID = 'Failed to get Wifi BSSID';
    }

    try {
      wifiIPv4 = await _networkInfo.getWifiIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv4', error: e);
      wifiIPv4 = 'Failed to get Wifi IPv4';
    }

    try {
      wifiIPv6 = await _networkInfo.getWifiIPv6();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi IPv6', error: e);
      wifiIPv6 = 'Failed to get Wifi IPv6';
    }

    try {
      wifiSubmask = await _networkInfo.getWifiSubmask();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi submask address', error: e);
      wifiSubmask = 'Failed to get Wifi submask address';
    }

    try {
      wifiBroadcast = await _networkInfo.getWifiBroadcast();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi broadcast', error: e);
      wifiBroadcast = 'Failed to get Wifi broadcast';
    }

    try {
      wifiGatewayIP = await _networkInfo.getWifiGatewayIP();
    } on PlatformException catch (e) {
      developer.log('Failed to get Wifi gateway address', error: e);
      wifiGatewayIP = 'Failed to get Wifi gateway address';
    }

    setState(() {
      _connectionStatus = 'Wifi Name: $wifiName\n'
          'Wifi BSSID: $wifiBSSID\n'
          'Wifi IPv4: $wifiIPv4\n'
          'Wifi IPv6: $wifiIPv6\n'
          'Wifi Broadcast: $wifiBroadcast\n'
          'Wifi Gateway: $wifiGatewayIP\n'
          'Wifi Submask: $wifiSubmask\n';
    });
  }
}*/

import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/services.dart';


void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> _deviceInfo = {};
  bool _isLoading = true;
  String _uniqueDeviceId = '';

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    try {
      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        _deviceInfo['Model'] = androidInfo.model;
        _deviceInfo['Brand'] = androidInfo.brand;
        _deviceInfo['AndroidApiLevel'] = androidInfo.id;
        _deviceInfo['Device'] = androidInfo.device;
        _deviceInfo['Display'] = androidInfo.display;
        _deviceInfo['Fingerprint'] = androidInfo.fingerprint;
        _deviceInfo['Hardware'] = androidInfo.hardware;
        _deviceInfo['Host'] = androidInfo.host;
        _deviceInfo['Manufacturer'] = androidInfo.manufacturer;
        _deviceInfo['Product'] = androidInfo.product;
        _deviceInfo['Tags'] = androidInfo.tags;
        _deviceInfo['Type'] = androidInfo.type;

        // _deviceInfo['bootloader'] = androidInfo.bootloader;
        // _deviceInfo['serialNumber'] = androidInfo.serialNumber;
        // _deviceInfo['isLowRamDevice'] = androidInfo.isLowRamDevice;
        // _deviceInfo['systemFeatures'] = androidInfo.systemFeatures.length;
        // _deviceInfo['supported32BitAbis'] = androidInfo.supported32BitAbis.length;
        // _deviceInfo['supported64BitAbis'] = androidInfo.supported64BitAbis.length;
        // _deviceInfo['supportedAbis'] = androidInfo.supportedAbis.length;
        // _deviceInfo['version'] = androidInfo.version;
        List<String> data = [
          androidInfo.model,
          androidInfo.brand,
          androidInfo.id,
          androidInfo.device,
          androidInfo.display,
          androidInfo.fingerprint,
          androidInfo.hardware,
          androidInfo.host,
          androidInfo.manufacturer,
          androidInfo.product,
          androidInfo.tags,
          androidInfo.type
        ];
        _uniqueDeviceId = base64Encode(utf8.encode(data.join('|')));
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        _deviceInfo['Model'] = iosInfo.model;
        _deviceInfo['Brand'] = iosInfo.name;
        _deviceInfo['IosVersion'] = iosInfo.systemVersion;
        _deviceInfo['IdentifierForVendor'] = iosInfo.identifierForVendor;
        _deviceInfo['LocalizedModel'] = iosInfo.localizedModel;
        _deviceInfo['SystemName'] = iosInfo.systemName;
        //_deviceInfo['data'] = iosInfo.data.length;
        //_deviceInfo['isPhysicalDevice'] = iosInfo.isPhysicalDevice;
        //_deviceInfo['utsname'] = iosInfo.utsname;
      }
      _deviceInfo['OperatingSystem'] = Platform.operatingSystem;
    } on PlatformException catch (e) {
      // Handle platform-specific exceptions
      print('Error getting device info: ${e.message}');
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _getDeviceInfo();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Device Info'),
        ),
        body: Center(
          child: _isLoading
              ? const CircularProgressIndicator() // Show loading indicator while fetching data
              : SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        itemCount: _deviceInfo.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          String key = _deviceInfo.keys.elementAt(index);
                          String value = _deviceInfo[key];
                          return ListTile(
                            title: Text(key),
                            subtitle: Text(value),
                          );
                        },
                      ),
                      const SizedBox(height: 20.0),

                      // Display the unique device ID
                      Text(
                        'Unique Device ID (Anonymized):\n$_uniqueDeviceId',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
