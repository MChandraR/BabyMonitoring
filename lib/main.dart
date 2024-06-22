// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, unused_import

import 'package:babymonitoring/baby.dart';
import 'package:babymonitoring/parent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: MyWidget(),
      ),
    );
  }
}

// class Mymiapp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // ignore: unused_local_variable
//     String appTitle = AppLocalizations.of(context)!.appTitle;
//     return MaterialApp(
//       localizationsDelegates: [
//         AppLocalizations.delegate,
//         GlobalMaterialLocalizations.delegate,
//         GlobalWidgetsLocalizations.delegate,
//         GlobalCupertinoLocalizations.delegate,
//       ],
//       supportedLocales: const [Locale('en', ''), Locale('id', '')],
//     );
//   }
// }

// mixin appTitle {}

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 273,
          decoration: BoxDecoration(
            color: const Color(0xFF817C83),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: const Align(
            alignment: Alignment.center,
            child: Image(
              width: 192,
              height: 162,
              image: AssetImage('assets/bayi.png'),
            ),
          ),
        ),
        const SizedBox(height: 100),
        CustomCardView(
          title: 'Baby',
          subtitle: 'Camera',
          color: const Color(0xFF311B92),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const BabyView(
                        token: '',
                      )),
            );
          },
        ),
        CustomCardView(
          title: 'Parent view',
          subtitle: 'watch your baby',
          color: const Color(0xFF311B92),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ParentView(
                        token: '',
                      )),
            );
            print('Parent button pressed!');
          },
        ),
      ],
    );
  }
}

class NextPage extends StatelessWidget {
  const NextPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Next Page'),
      ),
      body: const Center(
        child: Text('Ini adalah halaman selanjutnya!'),
      ),
    );
  }
}

class CustomCardView extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color color;
  final VoidCallback? onTap;

  const CustomCardView({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.color,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: color,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF4DB6AC),
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                subtitle,
                style: const TextStyle(
                  color: Color(0xFFC5CAE9),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
