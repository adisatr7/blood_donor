import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:blood_donor/controllers/map_controller.dart';
import 'package:blood_donor/core/theme.dart';
import 'package:blood_donor/widgets/buttons/app_back_button.dart';
import 'package:blood_donor/widgets/inputs/text_input.dart';

class MapView extends StatelessWidget {
  MapView({super.key});

  final MapController controller = Get.put(MapController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Obx(() {
          // Jika masih loading, tampilkan indikator loading
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          // Jika lokasi saat ini tidak tersedia, tampilkan pesan
          if (controller.currentLocation.value == null) {
            return const Center(
              child: Text(
                'Gagal menentukan lokasi Anda. Silakan aktifkan GPS, '
                'ijinkan aplikasi ini untuk mengakses GPS, dan coba lagi.',
                style: AppTextStyles.bodyGray,
              ),
            );
          }

          final LatLng latLng = controller.currentLocation.value!;

          return Stack(
            children: <Widget>[
              // Widget utama Google Maps
              GoogleMap(
                initialCameraPosition: CameraPosition(target: latLng, zoom: 15),
                markers: controller.getMarkers(),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                onMapCreated: controller.onMapCreated,
              ),

              // Kumpulan widget yang mengambang di atas UI Google Maps
              SafeArea(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        spacing: 12,
                        children: [
                          // Tombol Kembali
                          AppBackButton(elevated: true, label: ''),

                          // Kolom Pencarian
                          Expanded(
                            child: Column(
                              children: [
                                const SizedBox(height: 16),
                                TextInput(
                                  label: '',
                                  placeholder: 'Cari lokasi...',
                                  controller: controller.searchController,
                                  onSubmitted: controller.searchLocation,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
