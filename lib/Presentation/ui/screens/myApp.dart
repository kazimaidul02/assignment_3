import 'package:assignment_3/Presentation/ui/screens/API_CRUD_Project.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';


class myApp extends StatelessWidget {
  const myApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
        builder: (context,orientation,deviceType) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            useInheritedMediaQuery: true,
            locale: DevicePreview.locale(context),
            builder: DevicePreview.appBuilder,
            theme: ThemeData(
                brightness: Brightness.light,
                primaryColor: Colors.orangeAccent,
                appBarTheme: AppBarTheme(
                  centerTitle: true,
                  color: Colors.orangeAccent,
                ),
                //scaffoldBackgroundColor: Colors.white,
                elevatedButtonTheme: ElevatedButtonThemeData(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white))),
            title: "Flutter App",
            home:ApiCrudProject(),
          );
        }
    );
  }
}