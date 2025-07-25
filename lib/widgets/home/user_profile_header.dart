import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:blood_donor/models/db/user.dart';
import 'package:blood_donor/core/theme.dart';

class UserProfileHeader extends StatelessWidget {
  final Rxn<User> currentUser;
  final VoidCallback onGoToSettings;

  const UserProfileHeader({
    super.key,
    required this.currentUser,
    required this.onGoToSettings,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Row(
        children: <Widget>[
          // 📸 Foto profil
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.grey[300],
            backgroundImage: NetworkImage(
              (currentUser.value?.profilePicture?.path.isNotEmpty ?? false)
                  ? currentUser.value!.profilePicture!.path
                  : 'https://ui-avatars.com/api/?name=User&background=cccccc&color=ffffff',
            ),
          ),

          // Text group berisi nama user dan golongan darah
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // 🧑‍⚕️ Nama user
                  Text(
                    currentUser.value?.name ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),

                  // 🩸 Golongan Darah, hanya muncul jika golongan darah pernah di-input
                  if (currentUser.value?.mergedBloodType?.isNotEmpty == true)
                    RichText(
                      text: TextSpan(
                        children: <TextSpan>[
                          const TextSpan(
                            text: 'Golongan Darah: ',
                            style: AppTextStyles.bodyGray,
                          ),
                          TextSpan(
                            text: currentUser.value!.mergedBloodType,
                            style: AppTextStyles.bodyGrayBold,
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),

          // ⚙️ Tombol Pengaturan
          IconButton(icon: const Icon(Icons.menu), onPressed: onGoToSettings),
        ],
      ),
    );
  }
}
