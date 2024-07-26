import 'package:cityguide/bindings/general_bindings.dart';
import 'package:cityguide/firebase_options.dart';
import 'package:cityguide/repositories/repos/authentication_repository.dart';
import 'package:cityguide/utils/constants/color.dart';
import 'package:cityguide/utils/constants/image_strings.dart';
import 'package:cityguide/utils/popups/animation_loader.dart';
import 'package:cityguide/utils/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cityguide/screens/mainscreens/welcome.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main() async{
  ///widget binding
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  ///--initialize Firebase and Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  ///--Getx local storage
  await GetStorage.init();

  /// -- Await Splash until other items load
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  ///--initialize Firebase and Authentication Repository
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform).then((FirebaseApp value) => Get.put(AuthenticationRepository()));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.system,
      theme:TAppTheme.lightTheme,
      darkTheme: TAppTheme.darkTheme,
      initialBinding: GeneralBindings(),
      home:Scaffold(
        backgroundColor: TColors.primary,
        body: Container(
          child:  const Column(
            children: [
              SizedBox(
                height: 250,
              ),
              TAnimationLoaderWidget(text: '', animation: TImages.decorAnimation)
            ],
          ),
        ),
      ),
    );
  }
}