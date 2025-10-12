import 'package:evencir_task/routers/routers.dart';
import 'package:evencir_task/routers/routers_name.dart';
import 'package:evencir_task/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: AppColor.blue,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarColor: AppColor.primary,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(430, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Fitness App',
          theme: ThemeData(
            primaryColor: AppColor.primary,
            scaffoldBackgroundColor: AppColor.primary,
            fontFamily: 'Poppins',
            iconTheme: const IconThemeData(color: AppColor.secondary),
            appBarTheme: const AppBarTheme(
              systemOverlayStyle: SystemUiOverlayStyle(
                statusBarIconBrightness: Brightness.light,
                statusBarColor: AppColor.black,
                systemNavigationBarColor: AppColor.primary,
                systemNavigationBarIconBrightness: Brightness.dark,
              ),
            ),
          ),
          getPages: AppRoutes.appRoute(),
          initialRoute: RouteName.bottomNavigationScreen,

        );
      },
    );
  }
}
