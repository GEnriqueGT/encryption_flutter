import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:password_manager/common/bloc/base_state.dart';
import 'package:password_manager/common/widgets/custom_dropdown.dart';
import 'package:password_manager/common/widgets/custom_text_field.dart';
import 'package:password_manager/password-create/bloc/password_create_bloc.dart';
import 'package:password_manager/password-preview/model/categories_model.dart';
import 'package:password_manager/password-preview/model/password_complete_model.dart';
import 'package:password_manager/resources/colours.dart';
import 'package:password_manager/resources/constants.dart';
import 'package:toast/toast.dart';

class PasswordCreateBody extends StatefulWidget {
  const PasswordCreateBody({Key? key}) : super(key: key);

  @override
  State<PasswordCreateBody> createState() => _PasswordCreateBodyState();
}

class _PasswordCreateBodyState extends State<PasswordCreateBody> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  List<String> tags = [];

  late PasswordComplete passwordCreateModel;
  late PasswordCreateBloc passwordCreateBloc;
  late ToastContext toastContext;
  late List<Categories> categorias;
  late int categoriaSeleccionada;


  @override
  void initState() {
    super.initState();
    passwordCreateModel = PasswordComplete(
        site: "", username: "", categoryId: 0, tagsIds: [], password: "");
    toastContext = ToastContext();
    toastContext.init(context);
    categorias = [];
    categoriaSeleccionada = 1;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    passwordCreateBloc = context.read<PasswordCreateBloc>();
    passwordCreateBloc.add(GetCategorias());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordCreateBloc, BaseState>(
      listener: (context, state) {
        if (state is CreatePasswordSuccess) {
          Navigator.pop(context);
          Toast.show('Contraseña creada con exito',
              duration: Toast.lengthShort, gravity: Toast.bottom);
        } else if (state is PasswordCreateError) {
          Toast.show(state.message,
              duration: Toast.lengthShort, gravity: Toast.bottom);
        } else if(state is CategoriesSuccess){
          setState(() {
            categorias = state.categories;
          });
        }
      },
      child: ListView(
        children: <Widget>[
          Container(
              height: 150.0,
              color: pink.withOpacity(0.8),
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 10),
                    child:  Align(
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
                          'Crear Contraseña',
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
                              '${imagePath}add-logo.svg',
                              width: 30,
                              height: 30,
                              color: darkPink,
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              )),
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
                  label: 'Selecciona una categoria',
                  value: categoriaSeleccionada,
                  items: categorias,
                  onChanged: (newValue) {
                    setState(() {
                      categoriaSeleccionada = newValue!;
                    });
                  },
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  label: 'Dirección del Sitio',
                  controller: urlController,
                  icon: Icons.public,
                ),
                CustomTextField(
                  label: 'Nombre de Usuario',
                  controller: userController,
                  icon: Icons.person,
                ),
                CustomTextField(
                  label: 'Contraseña',
                  obscureText: true,
                  controller: passwordController,
                  icon: Icons.key,
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
                    'Agregar Tag',
                    style: TextStyle(
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
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onPressed: () {
                  passwordCreateModel.categoryId = categoriaSeleccionada;
                  passwordCreateModel.site = urlController.text;
                  passwordCreateModel.username = userController.text;
                  passwordCreateModel.password = passwordController.text;
                  passwordCreateModel.tagsIds = [];

                  passwordCreateBloc
                      .add(CreatePassword(passwordCreateModel));
                },
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
                    'Guardar Contraseña',
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

  void _mostrarDialogoAgregarTag() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nuevoTag = "";

        return AlertDialog(
          title: Text('Agregar Tag'),
          content: TextField(
            onChanged: (value) {
              nuevoTag = value;
            },
            decoration: InputDecoration(
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
