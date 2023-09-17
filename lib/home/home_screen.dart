import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';
import 'package:password_manager/home/widget/home_body.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:password_manager/routes/landing_routes_constants.dart';

class HomeScreen extends StatelessWidget {

   HomeScreen({Key? key}) : super(key: key);

   Function() reloadPasswords = (){};


   void setReloadFunction(Function() reloadBodyFunction){
     reloadPasswords = reloadBodyFunction;
   }


   @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child:  Scaffold(
        backgroundColor: Colors.white,
        body: HomeBody(setReloadFunction: setReloadFunction),
        appBar: AppBar(backgroundColor: pink, toolbarHeight: 0,automaticallyImplyLeading: false),
        floatingActionButton: FloatingActionButton(
          backgroundColor: darkPink,
          onPressed: (){
            Navigator.pushNamed(context, createRoute).then((value) => reloadPasswords());
          },
          child: const Icon(Icons.add),
        ),
      ),
    );

  }
}
