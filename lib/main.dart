import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: "Simple JSON",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _Add = [];

  // Fetch content from the json file
  // ขั้นตอนการอ่านไฟล์Json
  Future<void> readJson() async {
    final String response = await rootBundle.loadString('assets/sample.json');
    final data = await jsonDecode(response.toString());
    setState(() {
      _Add = data["Add"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "User Json",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            ElevatedButton(
              child: const Text('Load JSON Data'),
              onPressed: readJson,
            ),

            // Display the data loaded from sample.json
            _Add.isNotEmpty
                ? Expanded(
                    child: ListView.builder(
                      itemCount: _Add.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                            title: Text(_Add[index]["username"]),
                            subtitle: Text(_Add[index]["email"]),
                            leading: CircleAvatar(
                              backgroundImage: NetworkImage(
                                (_Add[index]["urlAvatar"]),
                              ),
                            ),
                          ),
                        );

                        return Container(
                          child: Column(
                            children: [
                              ListTile(
                                leading: Text(_Add[index]["username"]),
                                title: Text(_Add[index]["email"]),
                                subtitle: Text(_Add[index]["urlAvatar"]),
                              ),
                              Divider(),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
