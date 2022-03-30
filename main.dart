import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    loadCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test"),
      ),
      body: Center(
        child: Text('Counter: $counter', style: TextStyle(fontSize: 20),),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addPressed,
        child: Icon(Icons.add, color: Colors.white,),
      ),
    );
  }

  void addPressed() {
    setState(() {
      counter++;
    });
    saveCounter();
  }




  /// ----------- Shared Preferences Functions -----------

  /// load integer from persistent storage
  void loadCounter() async {
    // Obtain shared preferences
    prefs = await SharedPreferences.getInstance();
    // load counter
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
    });
  }
  /// save integer to persistent storage
  void saveCounter() async {
    await prefs.setInt('counter', counter);
  }

  /// all possibilities to save variables to persistent storage
  void setValues() async {
    // Save an integer value to 'counter' key.
    await prefs.setInt('counter', 10);
    // Save an boolean value to 'repeat' key.
    await prefs.setBool('repeat', true);
    // Save an double value to 'decimal' key.
    await prefs.setDouble('decimal', 1.5);
    // Save an String value to 'action' key.
    await prefs.setString('action', 'Start');
    // Save an list of strings to 'items' key.
    await prefs.setStringList('items', <String>['Earth', 'Moon', 'Sun']);
  }

  /// all possibilities to load variables from persistent storage
  void loadValues() async {
    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    final int counter = prefs.getInt('counter') ?? 1;
    // Try reading data from the 'repeat' key. If it doesn't exist, returns null.
    final bool? repeat = prefs.getBool('repeat');
    // Try reading data from the 'decimal' key. If it doesn't exist, returns null.
    final double? decimal = prefs.getDouble('decimal');
    // Try reading data from the 'action' key. If it doesn't exist, returns null.
    final String? action = prefs.getString('action');
    // Try reading data from the 'items' key. If it doesn't exist, returns null.
    final List<String> items = prefs.getStringList('items') ?? [];
  }

  /// removing a variable from persistent storage
  void removeValue() async {
    // Remove data for the 'counter' key.
    final success = await prefs.remove('counter');
  }

  /// saving & loading a list of integers to/from persistent storage
  void saveIntList() async {
    List<double> values = [0,1,2,3,4];
    /// convert list of integers to list of strings
    List<String> savableValues = values.map((i) => i.toString()).toList();

    /// store string list in shared prefs
    prefs.setStringList("stringList", savableValues);

    /// load list of integers
    /// first, fetch string list
    List<String> savedList = prefs.getStringList('stringList') ?? [];

    /// second, convert string list to original int list
    List<double> originalValues = savedList.map((i) => double.parse(i)).toList();
  }

}

