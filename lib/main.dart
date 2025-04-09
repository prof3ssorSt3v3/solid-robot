import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sharedprefs/provider/names.provider.dart';

void main() {
  // runApp(const MyApp());
  runApp(
    ChangeNotifierProvider(
      create: (context) => People(),
      child: MyApp(),
    ),
  );
}

final ValueNotifier<String> name = ValueNotifier('Teddy');
//value notified is a ChangeNotifier with just a value, no functions

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
        ),
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    People ppl = context.read<People>(); //version 1
    People prov = Provider.of<People>(context); //version 2

    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            Theme.of(context).colorScheme.inversePrimary,
        title: Text('Shared_Preference'),
      ),
      body: Consumer<People>(
        builder: (context, value, child) {
          String name1 = ppl.names?[0] ?? 'one';
          //using context.read<>()
          String name2 = prov.names?[1] ?? 'two';
          //using Provider.of<>(context)
          String name3 = value.names?[2] ?? 'three';
          //using Consumer()
          String name4 = name.value;
          //using a ValueNotifier (similar to a React Native Ref)
          String name5 = ppl.complex?['name'] ?? 'four';
          //getting Map from context.read<>()
          String name6 = prov.complex?['name'] ?? 'five';
          //getting Map from Provider.of<>(context)
          String name7 = value.complex?['name'] ?? 'six';

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'ChangeNotifierProvider',
                  style: TextStyle(fontSize: 30),
                ),
                Text(name1),
                Text(name2),
                Text(name3),
                Text(name4),
                Text(name5),
                Text(name6),
                Text(name7),
              ],
            ),
          );
        },
      ),
    );
  }
}
