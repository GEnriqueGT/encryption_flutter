import 'package:flutter/material.dart';
import 'package:password_manager/home/widget/home_body.dart';
import 'package:password_manager/resources/colours.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: const HomeBody(),
      appBar: AppBar(backgroundColor: pink, toolbarHeight: 0,automaticallyImplyLeading: false),
      floatingActionButton: FloatingActionButton(
        backgroundColor: darkPink,
        onPressed: (){},
        child: const Icon(Icons.add),
      ),
    );
  }
}
