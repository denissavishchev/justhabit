import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:justhabit/pages/main_page.dart';
import 'package:justhabit/providers/main_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MainProvider>(create: (_) => MainProvider()),
      ],
      builder: (context, child){
        return ScreenUtilInit(
          designSize: const Size(360, 780),
          builder: (_, child){
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: MainPage(),
            );
          },
        );
      },
    );
  }
}

