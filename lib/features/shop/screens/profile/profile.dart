import 'package:Quarry/common/widgets/appbar/appbar.dart';
import 'package:Quarry/common/widgets/custom_shapes/container/t_circular_image.dart';
import 'package:Quarry/common/widgets/text/section_heading.dart';
import 'package:Quarry/data/repositories/authentication_repository/authentication_repository.dart';
import 'package:Quarry/features/shop/screens/profile/controller/profile_controller.dart';
import 'package:Quarry/features/shop/screens/profile/widgets/TProfileMenu.dart';
import 'package:Quarry/utils/constants/image_strings.dart';
import 'package:Quarry/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProfileController());

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            TAppBar( showBackArrow: true,title: Text('Profile')),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              final user = controller.user.value;
              return Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: Column(
                  children: [
                    /// Profile Picture
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          CircleAvatar(
                            radius: 40, // since width & height were 80
                            backgroundColor: Colors.blue, // Pick your color
                            backgroundImage: user.profilePicture != null && user.profilePicture.isNotEmpty
                                ? NetworkImage(user.profilePicture)
                                : null,
                            child: user.profilePicture == null || user.profilePicture.isEmpty
                                ? Text(
                              user.firstName.isNotEmpty
                                  ? user.firstName[0].toUpperCase()
                                  : '',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                                : null,
                          ),

                          TextButton(
                            onPressed: () {},
                            child: const Text('Change Profile Picture'),
                          ),
                        ],
                      ),
                    ),

                    /// Details
                    SizedBox(height: TSizes.spaceBtwItems / 2),
                    const Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    const TSectionHeading(title: 'Details', showActionButton: false),
                    SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                      title: 'Name',
                      value: user.fullName,
                    ),
                    SizedBox(height: TSizes.spaceBtwItems),

                    TProfileMenu(
                      title: 'User ID',
                      value: user.id,
                    ),

                    TProfileMenu(
                      title: 'E-mail',
                      value: user.email,

                    ),
                    TProfileMenu(
                      title: 'Phone Number',
                      value: user.phoneNumber,

                    ),
                    TProfileMenu(
                      title: 'Company',
                      value: user.company,
                    ),

                    const Divider(),
                    SizedBox(height: TSizes.spaceBtwItems),
                    Center(
                      child: TextButton(
                        onPressed: () {
                          AuthenticationRepository.instance.logOut();
                        },
                        child: const Text(
                          'Logout',
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            })

          ],
        ),
      ),
    );
  }
}
