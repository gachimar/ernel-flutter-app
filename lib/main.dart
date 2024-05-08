import 'package:ernel/app/escalas.dart';
import 'package:ernel/app/song_types.dart';
import 'package:ernel/new_elements/GridSongWidget.dart';
import 'package:ernel/state/songs/gridsong_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/notes.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // TRY THIS: Try running your application with "flutter run". You'll see
            // the application has a blue toolbar. Then, without quitting the app,
            // try changing the seedColor in the colorScheme below to Colors.green
            // and then invoke "hot reload" (save your changes or press the "hot
            // reload" button in a Flutter-supported IDE, or press "r" if you used
            // the command line to start the app).
            //
            // Notice that the counter didn't reset back to zero; the application
            // state is not lost during the reload. To reset the state, use hot
            // restart instead.
            //
            // This works for code too, not just values: Most code changes can be
            // tested with just a hot reload.
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
            useMaterial3: true,
            fontFamily: 'Roboto'),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<MainGridSongProvider>(
              create: (context) => MainGridSongProvider(),
            ),
          ],
          child: const MyHomePage(title: 'ERNEL'),
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class NuevoPayload {
  NuevoPayload({
    required this.seccion,
    required this.compas,
    required this.tono,
  });
  int seccion;
  int compas;
  int tono;
}

class _MyHomePageState extends State<MyHomePage> {
  // List<SeccionTono> arreglo = [
  //   SeccionTono(tono: "C Mayor", compases: [
  //     [
  //       Tono(tono: "1o"),
  //       Tono(tono: "1"),
  //       Tono(tono: "2"),
  //       Tono(tono: ""),
  //       Tono(tono: "7o"),
  //       Tono(tono: "5"),
  //       Tono(tono: ""),
  //       Tono(tono: "5"),
  //     ],
  //     [
  //       Tono(tono: "1o"),
  //       Tono(tono: "1"),
  //       Tono(tono: "2"),
  //       Tono(tono: ""),
  //       Tono(tono: "7o"),
  //       Tono(tono: "5"),
  //       Tono(tono: ""),
  //       Tono(tono: "5"),
  //     ],
  //   ]),
  // ];

  // Posición del acorde
  double _selectedPosition = 0;

  // Nota del acorde seleccionada
  Nivel _selectedNivel = indexedNiveles[0];

  // Modalidad seleccionada
  Alteracion _selectedAlteracion = indexedAlteraciones[0];

  /**
   * Obtener acordes del nivel y alteración.
   */
  String _getAcorde(String seccion, String tono) {
    String? stringAcorde = acordes[seccion]?[tono];
    print('$seccion $tono');
    stringAcorde ??= '';
    return stringAcorde;
  }

  Widget yesNoDialog(Function callback) {
    Widget dialogo = SizedBox(
      child: Center(
        heightFactor: 0.5,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  callback();

                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Si',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(4, 16, 0, 16),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'No',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return dialogo;
  }

  void crearCancionDialog() {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    String name = "";
    Widget dialogo = SizedBox(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Nombre...',
              ),
              validator: (String? value) {
                if (value == null || value.isEmpty) {
                  return 'Ingresa un nombre válido.';
                }
                name = value;
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPressed: () {
                  // Validate will return true if the form is valid, or false if
                  // the form is invalid.
                  if (formKey.currentState!.validate()) {
                    bool currentSongExist = Provider.of<MainGridSongProvider>(
                            context,
                            listen: false)
                        .currentSongExists();
                    print(currentSongExist);

                    Navigator.of(context).pop();
                    if (currentSongExist) {
                      showFormDialog(
                          yesNoDialog(() => {
                                Provider.of<MainGridSongProvider>(context,
                                        listen: false)
                                    .createNewSong(name)
                              }),
                          '¿Deseas sobreescribir la canción actual?');
                    } else {
                      Provider.of<MainGridSongProvider>(context, listen: false)
                          .createNewSong(name);
                    }
                  }
                },
                child: const Text(
                  'Crear canción',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    showFormDialog(dialogo, 'Nombre de la canción');
  }

  void mostrarAcordes(Function(String acorde) callback) {
    Widget dialogo = SizedBox(
      width: double.maxFinite,
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,

          // Verificar en que paso del dialogo está
          // para mostrar notas o modalidades.
          children: List.generate(notes.length, (index) {
            return MaterialButton(
              color: Colors.white,
              child: Text(
                notes[index],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                callback(notes[index]);
              },
            );
          })),
    );

    showSolidDialog(dialogo, 'Selecciona un Acorde');
  }

  void mostrarModos(Function(String acorde) callback) {
    Widget dialogo = SizedBox(
      width: double.maxFinite,
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,

          // Verificar en que paso del dialogo está
          // para mostrar notas o modalidades.
          children: List.generate(modes.length, (index) {
            return MaterialButton(
              color: Colors.white,
              child: Text(
                modes[index],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                callback(modes[index]);
              },
            );
          })),
    );

    showSolidDialog(dialogo, 'Selecciona un Acorde');
  }

  void mostrarNiveles(Function(Nivel nivel) callback) {
    Widget dialogo = SizedBox(
      width: double.maxFinite,
      child: GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,

          // Verificar en que paso del dialogo está
          // para mostrar notas o modalidades.
          children: List.generate(niveles.length, (index) {
            return MaterialButton(
              color: Colors.white,
              child: Text(
                niveles[index],
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                callback(Nivel(index: (index)));
              },
            );
          })),
    );

    showSolidDialog(dialogo, 'Selecciona un Acorde');
  }

  void mostrarAlteraciones(Function(Tono tono) callback) {
    Widget dialogo = SizedBox(
      width: double.maxFinite,
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 3,

        // Verificar en que paso del dialogo está
        // para mostrar notas o modalidades.
        children: List.generate(alteraciones.length, (index) {
          return MaterialButton(
            color: Colors.white,
            child: Text(
              alteraciones[index],
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
            onPressed: () {
              setState(() {
                _selectedAlteracion = Alteracion(index: (index));
                // GridSong cancion =
                //     Provider.of<MainGridSongProvider>(context, listen: false)
                //         .getCurrentSong();
                // Provider.of<MainGridSongProvider>(context, listen: false)
                //     .setTono(
                //   payload.seccion,
                //   payload.compas,
                //   payload.tono,
                //   Tono(
                //     tono:
                //         '${niveles[_selectedNivel.index]}${alteraciones[_selectedAlteracion.index]}',
                //   ),
                // );
                // print(cancion.toJson());
                // mainGridSongModel.setTono(
                //   payload.seccion,
                //   payload.compas,
                //   payload.tono,
                //   Tono(
                //     tono:
                //         '${niveles[_selectedNivel.index]}${alteraciones[_selectedAlteracion.index]}',
                //   ),
                // );
                // arreglo[payload.seccion]
                //         .compases[payload.compas][payload.tono]
                //         .tono =
                //     ;

                callback(Tono(
                  tono:
                      '${niveles[_selectedNivel.index]}${alteraciones[_selectedAlteracion.index]}',
                ));
              });
              Navigator.of(context).pop();
            },
          );
        }),
      ),
    );

    showSolidDialog(dialogo, 'Selecciona la modalidad');
  }

  void showSolidDialog(
    Widget contenido,
    String titulo,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.green,
            title: Center(
                child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
            )),
            content: contenido);
      },
    );
  }

  void showFormDialog(Widget contenido, String titulo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
            backgroundColor: Colors.white,
            title: Center(
                child: Text(
              titulo,
              style: const TextStyle(
                color: Colors.black54,
                fontSize: 20,
              ),
            )),
            content: contenido);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.primary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(
          widget.title,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Consumer<MainGridSongProvider>(
        builder: (builder, mainGridSongProvider, child) => Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: () {
                      crearCancionDialog();
                    },
                    child: const Text(
                      'Nueva Canción',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                if (mainGridSongProvider.getCurrentSong() != null)
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[500],
                      ),
                      onPressed: () {
                        print('Crear sección');
                        mostrarAcordes((tono) {
                          print(tono);
                          mostrarModos((modo) {
                            print(modo);
                            mainGridSongProvider.addSeccion('$tono $modo');
                          });
                        });
                      },
                      child: const Text(
                        'Añadir sección',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
            ...[
              mainGridSongProvider.getCurrentSong() != null
                  ? Text(mainGridSongProvider.getCurrentSong()!.name)
                  : const Text(
                      'Seleccione una canción',
                    ),
            ],
            SizedBox(
              height: 15,
            ),
            ...mainGridSongProvider.getCurrentSong() != null
                ? mainGridSongProvider
                    .getCurrentSong()!
                    .secciones
                    .asMap()
                    .entries
                    .map((seccion) {
                    return GridSongWidget(
                      seccion: seccion.value,
                    );
                  }).toList()
                : []
          ],
        ),
      )),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }
}
