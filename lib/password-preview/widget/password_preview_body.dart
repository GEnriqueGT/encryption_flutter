import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/password-preview/bloc/password_preview_bloc.dart';
import 'package:password_manager/password-preview/model/password_complete_model.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:password_manager/resources/constants.dart';

class PasswordPreviewBody extends StatefulWidget {
  final String passwordId;
  const PasswordPreviewBody({Key? key, required this.passwordId})
      : super(key: key);

  @override
  State<PasswordPreviewBody> createState() => _PasswordPreviewBodyState();
}

class _PasswordPreviewBodyState extends State<PasswordPreviewBody> {
  late PasswordComplete passwordInfo;
  late PasswordPreviewBloc passwordPreviewBloc;

  @override
  void initState() {
    super.initState();
    passwordInfo = PasswordComplete(
        site: "",
        username: "",
        id: "",
        categoryId: 0,
        tagsIds: [],
        password: "");
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    passwordPreviewBloc = context.read<PasswordPreviewBloc>();
    passwordPreviewBloc.add(RequestPassword(widget.passwordId));
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordPreviewBloc, BaseState>(
        listener: (context, state) {
          if (state is PasswordSucces) {
            setState(() {
              passwordInfo = state.passwordInfo;
            });
          } else if(state is DeletePasswordSuccess){
            Navigator.pop(context);
            Navigator.pop(context);
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 150.0,
              color: pink.withOpacity(0.4),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      onPressed: () {
                        showDeleteDialog(context);
                      },
                      icon: const Icon(
                        Icons.delete,
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
                        'Tu Contraseña',
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
                            '${imagePath}password-logo.svg',
                            width: 40,
                            height: 40,
                            color: darkPink,
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Dirección del Sitio: ${passwordInfo.site}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Nombre de Usuario:  ${passwordInfo.username}'),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text('Contraseña:  ${passwordInfo.password}'),
            ),
          ],
        ));
  }

  Future<void> showDeleteDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Eliminar Contraseña"),
          content: const Text(
              "¿Está seguro de que desea eliminar definitivamente esta contraseña?"),
          actions: [
            TextButton(
              onPressed: () {
                passwordPreviewBloc.add(DeletePassword(widget.passwordId));
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
