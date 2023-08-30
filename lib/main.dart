import 'package:ernel/elements/app_config/scale_slider.dart';
import 'package:ernel/elements/list/notelist.dart';
import 'package:ernel/elements/mainpanel/phrase.dart';
import 'package:ernel/elements/mainpanel/phrase_form.dart';
import 'package:ernel/state/notes/notes_states.dart';
import 'package:ernel/state/songs/songs_state.dart';
import 'package:ernel/state/ui/ui_state.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/notes.dart';

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
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
            useMaterial3: true,
            fontFamily: 'Roboto'),
        home: MultiProvider(
          providers: [
            ChangeNotifierProvider<MainNotesModel>(
              create: (context) => MainNotesModel(Note(index: 0)),
            ),
            ChangeNotifierProvider<UiModel>(
              create: (context) => UiModel(1),
            ),
            ChangeNotifierProvider<MainSongModel>(
              create: (context) => MainSongModel(exampleSong),
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

class _MyHomePageState extends State<MyHomePage> {
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
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            // Column is also a layout widget. It takes a list of children and
            // arranges them vertically. By default, it sizes itself to fit its
            // children horizontally, and tries to be as tall as its parent.
            //
            // Column has various properties to control how it sizes itself and
            // how it positions its children. Here we use mainAxisAlignment to
            // center the children vertically; the main axis here is the vertical
            // axis because Columns are vertical (the cross axis would be
            // horizontal).
            //
            // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
            // action in the IDE, or press "p" in the console), to see the
            // wireframe for each widget.
            // mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Consumer2<MainNotesModel, MainSongModel>(
                builder:
                    (builder, mainNotesProvider, mainSongProvider, child) =>
                        Text(
                  '${mainSongProvider.getCurrentSong().name} - ${mainSongProvider.getCurrentSong().author} in ${mainSongProvider.getCurrentSong().mainNote}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const NotesDropdown(),
              const SliderExample(),
              Expanded(
                child: Consumer<MainSongModel>(
                  builder: (builder, mainSongProvider, child) => ListView(
                    shrinkWrap: true,
                    children: [
                      ...mainSongProvider
                          .getCurrentSong()
                          .phrases
                          .map((Phrase phrase) {
                        return PhraseWidget(phrase: phrase);
                      }).toList(),
                      ...[
                        PhraseForm(),
                      ]
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ) // This trailing comma makes auto-formatting nicer for build methods.
        ;
  }
}
