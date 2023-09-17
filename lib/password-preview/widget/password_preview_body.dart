import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/common/widgets/custom_dropdown.dart';
import 'package:password_manager/common/widgets/custom_text_field.dart';
import 'package:password_manager/home/bloc/home_bloc.dart';
import 'package:password_manager/password-preview/bloc/password_preview_bloc.dart';
import 'package:password_manager/password-preview/model/categories_model.dart';
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
  final TextEditingController urlController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late PasswordComplete passwordInfo;
  late PasswordComplete passwordInfoInitialCache;
  late PasswordPreviewBloc passwordPreviewBloc;
  late ToastContext toastContext;
  late bool editable;
  late List<Categories> categorias;
  late List<String> tags;
  late int categoriaSeleccionada;

  @override
  void initState() {
    super.initState();
    passwordInfo = PasswordComplete(
        site: "", username: "", id: "", categoryId: 0, tags: [], password: "");
    passwordInfoInitialCache = PasswordComplete(
        site: "", username: "", id: "", categoryId: 0, tags: [], password: "");
    toastContext = ToastContext();
    toastContext.init(context);
    editable = false;
    categorias = [];
    tags = [];
    categoriaSeleccionada = 0;
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
        if (state is PasswordSuccess) {
          setState(() {
            categorias = state.categories;
            passwordInfo = state.passwordInfo;
            urlController.text = passwordInfo.site;
            userController.text = passwordInfo.username;
            passwordController.text = passwordInfo.password;
            categoriaSeleccionada = passwordInfo.categoryId;
            tags = passwordInfo.tags;
            passwordInfoInitialCache = passwordInfo;
          });
        } else if (state is DeletePasswordSuccess) {
          Navigator.pop(context);
          Navigator.pop(context);
          Toast.show('se ha eliminado la contraseña con exito',
              duration: Toast.lengthShort, gravity: Toast.bottom);
        } else if (state is GetPasswordInfoError) {
          Toast.show(state.message,
              duration: Toast.lengthShort, gravity: Toast.bottom);
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
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Align(
                      alignment: Alignment.topLeft,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 40.0,
                            height: 40.0,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(
                              Icons.arrow_back,
                              color: darkPink,
                              size: 25,
                            ),
                          ),
                        ],
                      )),
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
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: Row(
                      children: [
                        const Text(
                          'Credencial',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            setState(() {
                              editable = !editable;
                              if (editable) {
                                Toast.show('ahora esta en modo edición',
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom);
                              } else if (!editable) {
                                Toast.show('ahora esta en modo solo lectura',
                                    duration: Toast.lengthShort,
                                    gravity: Toast.bottom);
                              }
                            });
                          },
                          icon: Icon(
                            Icons.edit,
                            color: editable ? darkPink : Colors.grey,
                            size: 25,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            showDeleteDialog(context);
                          },
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.grey,
                            size: 25,
                          ),
                        ),
                      ],
                    )),
                CustomDropdown(
                  label: 'Categoría',
                  value: categoriaSeleccionada,
                  items: categorias,
                  onChanged: (newValue) {
                    setState(() {
                      categoriaSeleccionada = newValue!;
                    });
                  },
                  isEditable: editable,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: 'Dirección del Sitio',
                  controller: urlController,
                  icon: Icons.public,
                  editable: editable,
                ),
                CustomTextField(
                  label: 'Nombre de Usuario',
                  controller: userController,
                  icon: Icons.person,
                  editable: editable,
                ),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  controller: passwordController,
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
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    passwordInfo.tags.isNotEmpty
                        ? 'Tags'
                        : 'No tiene tags asignadas',
                    style: const TextStyle(
                      fontFamily: 'DM Sans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (String tag in tags)
                      Container(
                        decoration: BoxDecoration(
                          color: pink,
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 12.0),
                        margin: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          tag,
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
                        onPressed: () {
                          _mostrarDialogoAgregarTag();
                        },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          passwordInfo.categoryId = categoriaSeleccionada;
                          passwordInfo.username = userController.text;
                          passwordInfo.site = urlController.text;
                          passwordInfo.password = passwordController.text;
                          passwordInfo.tags = tags;
                          passwordPreviewBloc.add(EditPassword(passwordInfo));
                          Toast.show('Contraseña editada con exito',
                              duration: 5, gravity: Toast.bottom);
                          editable = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.zero,
                        maximumSize: Size(150, 100),
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
                          vertical: 12.0,
                          horizontal: 10.0,
                        ),
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
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          passwordInfo = passwordInfoInitialCache;
                          urlController.text = passwordInfo.site;
                          passwordController.text = passwordInfo.site;
                          userController.text = passwordInfo.site;
                          tags = passwordInfo.tags;
                          categoriaSeleccionada = passwordInfo.categoryId;
                          editable = false;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: EdgeInsets.zero,
                        maximumSize: Size(150, 100),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.grey, Colors.white60],
                          ),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 12.0,
                          horizontal: 40.0,
                        ),
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            color: Colors.white,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
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

  void _mostrarDialogoAgregarTag() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nuevoTag = "";

        return AlertDialog(
          title: const Text('Agregar Tag'),
          content: TextField(
            onChanged: (value) {
              nuevoTag = value;
            },
            decoration: const InputDecoration(
              hintText: 'Ingrese un nuevo tag',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  tags.add(nuevoTag);
                });
                Navigator.of(context).pop();
              },
              child: Text('Crear'),
            ),
          ],
        );
      },
    );
  }
}
