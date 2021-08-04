import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:bookhive/res.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BOOK-HIVE',
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String value;
  final String title = "BOOK-HIVE";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text(
          title,
          style: GoogleFonts.abel(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 180.0),
                child: TextField(
                  onChanged: (text) {
                    value = text;
                  },
                  decoration: InputDecoration(
                    hintText: "Enter a quote to find the relevant book(s)",
                    hintStyle: GoogleFonts.ubuntu(),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(35)),
                      borderSide: BorderSide(color: Colors.white70),
                    ),
                    suffixIcon: Icon(
                      Icons.clear,
                    ),
                    filled: true,
                    fillColor: Colors.black87,
                  ),
                  style: GoogleFonts.ubuntu(),
                  maxLength: 100,
                  maxLines: 1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 0),
                child: ElevatedButton(
                  child: Text(
                    "Search",
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                  onPressed: () {
                    return res();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: Colors.black))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  res() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Res(
                value: value,
              )),
    );
  }
}
