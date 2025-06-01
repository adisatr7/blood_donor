import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';

import 'package:blood_donor/services/location_service.dart';
import 'package:blood_donor/models/db/location.dart';
import 'package:geolocator/geolocator.dart';
import 'package:blood_donor/widgets/popups/app_dialog.dart';

class MapController extends GetxController {
  final LocationService _locationService = LocationService.instance;
  GoogleMapController? googleMapController;

  final Rxn<LatLng> currentLocation = Rxn<LatLng>();
  final RxList<Location> locations = <Location>[].obs;

  final TextEditingController searchController = TextEditingController();

  final RxBool isLoading = true.obs;

  @override
  void onInit() async {
    super.onInit();

    await _checkAndRequestLocationPermission();
    _locateUserLocation();
  }

  /// Method untuk mengambil GoogleMapController dari widget MapView
  void onMapCreated(GoogleMapController controller) {
    googleMapController = controller;
  }

  /// Method untuk mencari lokasi berdasarkan query. Untuk dipasangkan ke widget
  /// TextInput yang digunakan untuk mencari lokasi donor darah terdekat
  void searchLocation(String query) async {
    // Gunakan huruf kecil untuk pencarian
    final lowerQuery = query.toLowerCase();

    if (lowerQuery.isEmpty) {
      // Jika query kosong, tampilkan semua lokasi
      locations.assignAll(await _locationService.getAllLocations());
    } else {
      // Jika query search diberikan, cari lokasi berdasarkan nama
      locations.assignAll(await _locationService.searchLocations(lowerQuery));
    }

    if (googleMapController == null) {
      return;
    }

    if (locations.isEmpty) {
      // Jika tidak ada lokasi hasil pencarian, lompat ke lokasi user sekarang
      final LatLng userLocation = currentLocation.value!;
      _goToLocation(userLocation);

      // Tampilkan dialog jika tidak ada hasil pencarian
      showAppDialog(
        title: 'Tidak Ada Hasil',
        message: 'Tidak ada lokasi yang ditemukan untuk "$query".',
      );
      return;
    }

    if (query.isNotEmpty) {
      // Jika pencarian berhasil, tampilkan lokasi pertama
      final LatLng firstLocation = LatLng(
        locations.first.latitude,
        locations.first.longitude,
      );
      _goToLocation(firstLocation);
    } else {
      // Jika query pencarian kosong, lompat ke lokasi user sekarang
      final LatLng userLocation = currentLocation.value!;
      _goToLocation(userLocation);
    }
  }

  /// Method untuk mengambil marker dari daftar lokasi yang sudah diambil
  Set<Marker> getMarkers() {
    return locations.map((location) {
      return Marker(
        markerId: MarkerId(location.id.toString()),
        position: LatLng(location.latitude, location.longitude),
        infoWindow: InfoWindow(title: location.name),
      );
    }).toSet();
  }

  /// Cek dan minta izin lokasi ke user
  Future<void> _checkAndRequestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      // Minta izin lokasi jika belum diberikan
      permission = await Geolocator.requestPermission();

      // Jika user menolak izin, tampilkan pesan berikut
      if (permission == LocationPermission.denied) {
        showAppDialog(
          title: 'Izin Lokasi Ditolak',
          message: 'Aplikasi membutuhkan izin lokasi untuk membantu Anda mencari lokasi donor terdekat.',
        );
        return;
      }
    }
  }

  /// Method internal untuk melacak lokasi user saat ini
  Future<void> _locateUserLocation() async {
    try {
      isLoading.value = true;

      // Lacak posisi user saat ini
      final pos = await Geolocator.getCurrentPosition(
        // Akurasi lokasi diatur ke `low` karena kita tidak butuh akurasi
        // tinggi hanya untuk mencari lokasi donor darah terdekat
        locationSettings: LocationSettings(accuracy: LocationAccuracy.low),
      );
      currentLocation.value = LatLng(pos.latitude, pos.longitude);
    } on Exception catch (e) {
      showAppError('Gagal Menentukan Lokasi Anda', e);
    } finally {
      isLoading.value = false;
    }
  }

  void _goToLocation(LatLng location) {
    if (googleMapController == null) {
      return;
    }

    googleMapController!.animateCamera(
      CameraUpdate.newLatLng(location),
    );
  }
}
