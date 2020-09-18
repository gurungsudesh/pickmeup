import 'package:flutter/material.dart';
import 'package:flutterLogin/services/auth.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AuthServices _authService = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick me Up'),
        actions: [
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('Log out'),
            onPressed: () async {
              await _authService.signOut();
            },
          )
        ],
      ),
      // body: GoogleMap(
      //   initialCameraPosition: CameraPosition(
      //     target: LatLng(28.209499, 83.959518),
      //     zoom: 12,
      //   ),
      //   myLocationEnabled: true,
      // ),
    );
  }
}
