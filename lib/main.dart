import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:untitled1/src/models/user.dart';
import 'package:untitled1/src/pages/home/home_page.dart';
import 'package:untitled1/src/pages/login/login_page.dart';
import 'package:untitled1/src/pages/register/register_page.dart';  //usu funcionalidades de getx

User userSession = User.fromJson(GetStorage().read('user') ?? {});

void main() async{
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override



  Widget build(BuildContext context) {
    print('Usuario id: ${userSession.id} ');
    return GetMaterialApp(
      title: 'Delivery sp',
      debugShowCheckedModeBanner: false,
      initialRoute: userSession.id !=null ? '/home' : '/',
      getPages: [
        GetPage(name: '/', page: () => LoginPage()),
        GetPage(name: '/register', page: () => RegisterPage()),
        GetPage(name: '/home', page: () => HomePage()),

      ],
      theme: ThemeData(
        primaryColor: Colors.amber,
        colorScheme: const ColorScheme(
          primary: Colors.amber,
          onPrimary: Colors.amberAccent,
          brightness: Brightness.light,
          onBackground: Colors.grey,
          secondary: Colors.grey,
          surface: Colors.grey,
          onSurface: Colors.grey,
          error: Colors.grey,
          onError: Colors.grey,
          background: Colors.grey,
          onSecondary: Colors.grey

        )
      ),
      navigatorKey: Get.key,
    );
  }
}
