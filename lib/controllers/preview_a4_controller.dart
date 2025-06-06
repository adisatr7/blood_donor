import 'package:blood_donor/models/db/appointment.dart';
import 'package:blood_donor/models/db/user.dart';
import 'package:get/get.dart';

import 'package:blood_donor/services/appointment_service.dart';

class PreviewA4Controller extends GetxController {
  final AppointmentService _appointmentService = AppointmentService.instance;
  final Rx<User> user = Rx<User>(User.fromMap({
    'nik': '1236547890987456',
    'name': 'Jax Hammer',
    'profilePicture': '/public/uploads/1748571719916.jpg',
    'birthPlace': 'City',
    'birthDate': '2001-01-12T17:00:00.000Z',
    'gender': 'MALE',
    'job': 'Mahasiswa',
    'weightKg': 75,
    'heightCm': 170,
    'bloodType': 'O',
    'rhesus': 'POSITIVE',
    'address': 'Japan 123',
    'noRt': 0,
    'noRw': 0,
    'village': 'Desa Desa',
    'district': 'Kkk',
    'city': 'Kabupaten',
    'province': 'Bengkulu'
  }));
  final Rxn<Appointment> appointment = Rxn<Appointment>();

  @override
  void onInit() async{
    super.onInit();

    appointment.value = await _appointmentService.getById(4);
  }
}