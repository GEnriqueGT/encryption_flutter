import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/common/widgets/custom_dropdown.dart';
import 'package:password_manager/common/widgets/custom_text_field.dart';
import 'package:password_manager/password-preview/bloc/password_preview_bloc.dart';
import 'package:password_manager/password-preview/model/password_complete_model.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:password_manager/resources/constants.dart';
import 'package:toast/toast.dart';

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
  late ToastContext toastContext;
  late bool editable;

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
    passwordPreviewBloc = context.read<PasswordPreviewBloc>();
    passwordPreviewBloc.add(RequestPassword(widget.passwordId));
    toastContext = ToastContext();
    toastContext.init(context);
    editable = false;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordPreviewBloc, BaseState>(
      listener: (context, state) {
        if (state is PasswordSuccess) {
          setState(() {
            passwordInfo = state.passwordInfo;
          });
        } else if (state is DeletePasswordSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
        }
      },
      child: ListView(
        children: <Widget>[
          Container(
            height: 150.0,
            color: pink.withOpacity(0.4),
            alignment: Alignment.center,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.centerRight,
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
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
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
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Credencial',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                CustomDropdown(
                  label: 'Categoría',
                  value: 'Categoría 1',
                  items: ['Categoría 1', 'Categoría 2', 'Categoría 3'],
                  onChanged: (newValue) {},
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: 'Dirección del Sitio',
                  controller: TextEditingController(text: passwordInfo.site),
                  icon: Icons.public,
                  editable: editable,
                ),
                CustomTextField(
                  label: 'Nombre de Usuario',
                  controller:
                      TextEditingController(text: passwordInfo.username),
                  icon: Icons.person,
                  editable: editable,
                ),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  controller:
                      TextEditingController(text: passwordInfo.password),
                  icon: Icons.key,
                  editable: editable,
                ),
              ],
            ),
          ),
          const SizedBox(height: 30),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    'Tags',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (int tag in passwordInfo.tagsIds)
                      Container(
                        decoration: BoxDecoration(
                          color: pink,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        margin: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "test",
                          style: const TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    if (editable)
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: Text('Agregar'),
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          if (editable)
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [redPink, darkPink],
                      ),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 12.0, horizontal: 100.0),
                    child: const Text(
                      'Editar Contraseña',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
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
