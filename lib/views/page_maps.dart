import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PageMaps extends StatefulWidget {
  const PageMaps({super.key});

  @override
  State<PageMaps> createState() => _PageMapsState();
}

class _PageMapsState extends State<PageMaps> {
  static const LatLng _posisiAwal = LatLng(-0.9145625, 100.4635761);

  late GoogleMapController _mapController;

  final Set<Marker> _markers = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tambahMarker();
  }

  void _tambahMarker(){
    _markers.add(
      const Marker(
        markerId: MarkerId('Kampus'),
        position: _posisiAwal,
        infoWindow: InfoWindow(title: 'Politeknik Negeri Padang', snippet: 'Sumatera Barat'),
      )
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Maps'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: CameraPosition(
          target: _posisiAwal,
          zoom: 15,
        ),
        markers: _markers,//memasang marker yang sudah di buat
        onMapCreated: (controller){
          _mapController = controller;//callback saat peta selesai di buat
        },

        myLocationButtonEnabled: true,
        myLocationEnabled: true,
      ),
    );
  }
}
