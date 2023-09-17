import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';
import 'package:password_manager/home/model/password_model.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:password_manager/resources/constants.dart';
import 'package:password_manager/routes/landing_routes_constants.dart';

class HomeBody extends StatefulWidget {
  final Function(Function()) setReloadFunction;
  const HomeBody({Key? key, required this.setReloadFunction}) : super(key: key);

  @override
  State<HomeBody> createState() => _HomeBodyState();
}

class _HomeBodyState extends State<HomeBody> {
  final TextEditingController searchControllar = TextEditingController();
  late HomeBloc homeBloc;
  late List<Password> passwords;
  late List<Password> passwordsInitialCache;
  @override
  void initState() {
    super.initState();
    passwords = [];
    passwordsInitialCache = [];
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    homeBloc = context.read<HomeBloc>();
    homeBloc.add(const GetPasswordsSaved());
    widget.setReloadFunction( (){
      homeBloc.add(const GetPasswordsSaved());
    });

  }



  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeBloc, BaseState>(
      listener: (context, state) {
        if (state is LogOutSuccess) {
          Navigator.pushReplacementNamed(context, rootRoute);
        } else if (state is PasswordsSuccess){
          setState(() {
            passwords = state.passwordsSaved;

           if(passwordsInitialCache.isEmpty) passwordsInitialCache = passwords;
          });
        } else if (state is PasswordsSuccess){
          setState(() {
           passwords = passwordsInitialCache;
          });
        }
      },
      child: SafeArea(
          child: Column(
        children: [
          Container(
            height: 150.0,
            color: pink.withOpacity(0.4),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    onPressed: () {
                      showLogoutDialog(context);
                    },
                    icon: const Icon(
                      Icons.exit_to_app,
                      color: darkPink,
                      size: 25,
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Contraseñas guardadas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          width: 60.0,
                          height: 60.0,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                          ),
                        ),
                        SvgPicture.asset(
                          '${imagePath}save-logo.svg',
                          width: 30,
                          height: 30,
                          color: darkPink,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
                color: Colors.white,
              ),
              child:  TextField(
                controller: searchControllar,
                onChanged: (value){
                  homeBloc.add(SearchPassword(searchWord: value, passwordsSaved: passwordsInitialCache));
                },
                decoration: const InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.grey,
                  ),
                  hintText: 'Buscar contraseñas',
                  border: InputBorder.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: passwords.length,
              itemBuilder: (context, index) {
                final password = passwords[index];
                return Container(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 4,
                        offset: const Offset(0, 3),
                      ),
                    ],
                    color: Colors.white,
                  ),
                  child: ListTile(
                    leading: Container(
                      width: 30.0,
                      height: 40.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: redPink,
                      ),
                      child: const Icon(
                        Icons.public,
                        size: 24,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(password.site),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        SizedBox(height: 5,),
                        Text(password.username, style: TextStyle(fontSize: 15)),
                       SizedBox(height: 5,),
                       if(password.tags.isNotEmpty) Text("Tags: ${password.tags.join(', ')}", style: TextStyle(fontSize: 14, color: darkPink)),
                        SizedBox(height: 5,),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward,
                      color: darkPink,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, passwordPreviewRoute, arguments: password.id).then((value) => homeBloc.add(const GetPasswordsSaved()));
                    },
                  ),

                );
              },
            ),
          ),
        ],
      )),
    );
  }

  Future<void> showLogoutDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Cerrar sesión"),
          content: const Text("¿Está seguro de que desea cerrar sesión?"),
          actions: [
            TextButton(
              onPressed: () {
                homeBloc.add(const LogOut());
              },
              child: const Text("Sí"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("No"),
            ),
          ],
        );
      },
    );
  }
}
