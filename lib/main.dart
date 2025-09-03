import 'package:contacts_app_api_flutter/model/contact.dart';
import 'package:contacts_app_api_flutter/view/add_contact.dart';
import 'package:contacts_app_api_flutter/view/home.dart';
import 'package:contacts_app_api_flutter/view/update_contact.dart';
import 'package:contacts_app_api_flutter/viewmodel/api_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => ApiProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  void navigateUpdate(BuildContext context) {
    Navigator.pushNamed(context, '/update');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.dark(
          primary: Colors.grey,
          onPrimary: Colors.black,
          secondary: Colors.black,
          onSecondary: Colors.white,
          surface: Colors.black,
          onSurface: Colors.white,
        ),
      ),

      initialRoute: '/home',

      routes: {'/add': (context) => AddContact()},

      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/update':
            {
              Contact contact = settings.arguments as Contact;
              return MaterialPageRoute(
                builder: (context) => UpdateContact(contact: contact),
              );
            }

          case '/home':
            {
              return MaterialPageRoute(builder: (context) => Home());
            }
        }
        return null;
      },
    );
  }
}
