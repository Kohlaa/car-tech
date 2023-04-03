import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import '../../../../constants/components.dart';
import '../../../bloc/cubit.dart';
import '../../../bloc/states.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? image;
  var formProfileKey = GlobalKey<FormState>();

  Future pickImage(ImageSource source) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      //final imageTemporary = File(image.path);
      final imageTemporary = await saveImage(image.path);
      setState(() => this.image = imageTemporary);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future<File> saveImage(String imagePath) async {
    final directory = await getApplicationDocumentsDirectory();
    final name = basename(imagePath);
    final image = File('${directory.path}/$name');
    return File(imagePath).copy(image.path);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var cubit = CarCubit.get(context);
    return BlocConsumer<CarCubit, CarStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                height: size.height * .4,
                width: size.width,
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(60),
                      bottomLeft: Radius.circular(60)),
                  gradient: gradient,
                  color: Colors.blueGrey.withOpacity(.3),
                ),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      // Stack(
                      //   children: [
                      //     image != null
                      //         ? Hero(
                      //             tag: 'pro',
                      //             child: Container(
                      //               width: size.width * 0.46,
                      //               height: size.width * 0.46,
                      //               margin: const EdgeInsets.only(
                      //                 top: 24.0,
                      //                 bottom: 20.0,
                      //               ),
                      //               decoration: BoxDecoration(
                      //                   gradient: gradient,
                      //                   borderRadius:
                      //                       BorderRadius.circular(50)),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(2.2),
                      //                 child: Container(
                      //                   decoration: const BoxDecoration(
                      //                     shape: BoxShape.circle,
                      //                   ),
                      //                   child: ClipOval(
                      //                     child: Image.file(
                      //                       image!,
                      //                       fit: BoxFit.cover,
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           )
                      //         : Hero(
                      //             tag: 'pro',
                      //             child: Container(
                      //               width: size.width * 0.46,
                      //               height: size.width * 0.46,
                      //               margin: const EdgeInsets.only(
                      //                 top: 24.0,
                      //                 bottom: 20.0,
                      //               ),
                      //               decoration: BoxDecoration(
                      //                   gradient: gradient,
                      //                   borderRadius:
                      //                       BorderRadius.circular(60)),
                      //               child: Padding(
                      //                 padding: const EdgeInsets.all(2.2),
                      //                 child: Container(
                      //                   height: 80,
                      //                   decoration: const BoxDecoration(
                      //                     shape: BoxShape.circle,
                      //                     image: DecorationImage(
                      //                       fit: BoxFit.fill,
                      //                       image: NetworkImage(
                      //                         "https://cdn.icon-icons.com/icons2/3150/PNG/512/user_profile_male_icon_192702.png",
                      //                       ),
                      //                     ),
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //     Positioned(
                      //       bottom: 25,
                      //       right: 4,
                      //       child: CircleAvatar(
                      //         radius: 25,
                      //         backgroundColor:
                      //             const Color.fromRGBO(30, 10, 100, 1),
                      //         child: IconButton(
                      //           onPressed: () {
                      //             showDialog(
                      //               context: context,
                      //               builder: (_) => AlertDialog(
                      //                 content: Lottie.asset(
                      //                     'assets/lotties/image.json'),
                      //                 actions: [
                      //                   Center(
                      //                     child: Row(
                      //                       crossAxisAlignment:
                      //                           CrossAxisAlignment.center,
                      //                       mainAxisAlignment:
                      //                           MainAxisAlignment.center,
                      //                       children: [
                      //                         TextButton(
                      //                           onPressed: () => pickImage(
                      //                               ImageSource.camera),
                      //                           child: shadeMask(
                      //                             'Camera',
                      //                             const TextStyle(fontSize: 20),
                      //                           ),
                      //                         ),
                      //                         const SizedBox(width: 120),
                      //                         TextButton(
                      //                           onPressed: () => pickImage(
                      //                               ImageSource.gallery),
                      //                           child: shadeMask(
                      //                             'Gallery',
                      //                             const TextStyle(fontSize: 20),
                      //                           ),
                      //                         ),
                      //                       ],
                      //                     ),
                      //                   ),
                      //                 ],
                      //               ),
                      //             );
                      //           },
                      //           icon: iconSh(Icons.camera,size: 30),
                      //         ),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      Stack(
                        children: [
                          image != null
                              ? Container(
                                  width: size.width * 0.46,
                                  height: size.width * 0.46,
                                  margin: const EdgeInsets.only(
                                    top: 24.0,
                                    bottom: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                      gradient: gradient,
                                    shape: BoxShape.circle,),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.2),
                                    child: Container(
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: ClipOval(
                                        child: Image.file(
                                          image!,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              : Container(
                                  width: size.width * 0.46,
                                  height: size.width * 0.46,
                                  margin: const EdgeInsets.only(
                                    top: 24.0,
                                    bottom: 20.0,
                                  ),
                                  decoration: BoxDecoration(
                                    gradient: gradient,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(2.2),
                                    child: Container(
                                      height: 80,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage(
                                            "https://cdn.icon-icons.com/icons2/3150/PNG/512/user_profile_male_icon_192702.png",
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                          Positioned(
                            bottom: 25,
                            right: 4,
                            child: CircleAvatar(
                              radius: 25,
                              backgroundColor:
                                  const Color.fromRGBO(30, 10, 100, 1),
                              //backgroundColor: Colors.white,
                              child: IconButton(
                                onPressed: () {
                                  showDialog(
                                    context: context,
                                    builder: (_) => AlertDialog(
                                      content: Lottie.asset(
                                          'assets/lotties/image.json'),
                                      actions: [
                                        Center(
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  pickImage(
                                                    ImageSource.camera,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: shadeMask(
                                                  'Camera',
                                                  const TextStyle(fontSize: 20),
                                                ),
                                              ),
                                              const SizedBox(width: 120),
                                              TextButton(
                                                onPressed: () {
                                                  pickImage(
                                                    ImageSource.gallery,
                                                  );
                                                  Navigator.pop(context);
                                                },
                                                child: shadeMask(
                                                  'Gallery',
                                                  const TextStyle(fontSize: 20),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                },
                                icon: iconSh(Icons.camera, size: 30),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Text(
                        'ahmed mohamed',
                        style: TextStyle(fontSize: size.height*.04, color: Colors.blue),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'ahmedMohamed@gmail.com',
                        style: TextStyle(fontSize: size.height*.02, color: Colors.blue),
                      ),
                    ],
                  ),
                ),
              )),
        );
      },
    );
  }
}
