//import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

final logger = Logger();

class Res extends StatefulWidget {
  final String value;
  Res({required this.value});
  @override
  _ResState createState() => _ResState(value);
}

class _ResState extends State<Res> {
  String value;
  _ResState(this.value);
  Map mapResponse = {};
  bool isLoading = false;
  fetchBook() async {
    String url0 =
        "https://openlibrary.org/search/inside.json?q=" + '"' + value + '"';
    var response = await http.get(Uri.parse(url0));
    var jsonData = jsonDecode(response.body);
    final body = jsonData as Map;

    logger.d(body['hits']['hits'][0]['fields']['meta_title'][0]);
    if (response.statusCode == 200) {
      setState(() {
        mapResponse = jsonDecode(response.body);
        isLoading = true;
      });
      return mapResponse;
    } else {}
    //print(mapResponse);
    // List<Book> books = [];
    //for (var u in body['hits']['hits']) {
    //Book book = Book(u['fields']['meta_title'][0], u['highlight']['text'][0]);
    //books.add(book);
    //}

    //for (var u in body['hits']['hits']) {
    // print(u['fields']['meta_title'][0].runtimeType);
    //print("\n");
    //print(u['highlight']['text'][0].toString());
    //print("\n");
    //}
    //print(books[0].toString());
    //debugPrint(jsonData);
    //print(books[1].bookTitle);
    /*for (var i = 0; i < books.length; i++) {
      print(i + 1);
      print("BOOK: " + books[i].bookTitle);
      print("\n");
      print("QUOTE: " + books[i].quote);
      print("\n");
    }*/
  }

  @override
  void initState() {
    fetchBook();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? getBook() : getCircle();
    /*Scaffold(
      appBar: AppBar(
        title: Text(
          value.toUpperCase(),
          style: GoogleFonts.abel(),
        ),
      ),
      /* body: ListView(
        children: [
          ListTile(
            title: Text(mapResponse['hits']['hits'][0]['fields']['meta_title']
                    [0]
                .toString()),
            subtitle: Text(mapResponse['hits']['hits'][0]['highlight']['text']
                    [0]
                .toString()),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(mapResponse['hits']['hits'][1]['fields']['meta_title']
                    [0]
                .toString()),
            subtitle: Text(mapResponse['hits']['hits'][1]['highlight']['text']
                .toString()
                .replaceAll(
                    RegExp(
                      '{',
                    ),
                    '')
                .replaceAll(RegExp('}'), '')),
          ),
        ],
      ),*/

      body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: mapResponse['hits']['hits'].length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
                height: 50,
                child: Center(
                  child: ListTile(
                    leading: Icon(Icons.book),
                    title: Text(
                        '${mapResponse['hits']['hits'][index]['fields']['meta_title'][0].toString()}'),

                  ),
                  //child: Text(
                ) //  'BOOK: ${mapResponse['hits']['hits'][index]['fields']['meta_title'][0].toString()}')),
                );
          }),
    );*/
  }

  getBook() {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          value.toUpperCase(),
          style: GoogleFonts.abel(),
        ),
      ),
      /* body: ListView(
        children: [
          ListTile(
            title: Text(mapResponse['hits']['hits'][0]['fields']['meta_title']
                    [0]
                .toString()),
            subtitle: Text(mapResponse['hits']['hits'][0]['highlight']['text']
                    [0]
                .toString()),
          ),
          SizedBox(height: 10),
          ListTile(
            title: Text(mapResponse['hits']['hits'][1]['fields']['meta_title']
                    [0]
                .toString()),
            subtitle: Text(mapResponse['hits']['hits'][1]['highlight']['text']
                .toString()
                .replaceAll(
                    RegExp(
                      '{',
                    ),
                    '')
                .replaceAll(RegExp('}'), '')),
          ),
        ],
      ),*/
      body: ListView.builder(
          padding: const EdgeInsets.all(15),
          itemCount: mapResponse['hits']['hits'].length,
          itemBuilder: (BuildContext context, int index) {
            return getCard(index);
          }),
    );
  }

  getCircle() {
    return Scaffold(
      body: Center(
        child: SpinKitFadingCube(
          color: Colors.white,
          size: 50.0,
        ),
      ),
    );
  }

  Widget getCard(item) {
    var bookName =
        mapResponse['hits']['hits'][item]['fields']['meta_title'][0].toString();
    var quote = mapResponse['hits']['hits'][item]['highlight']['text']
        .toString()
        .replaceAll(
            RegExp(
              '{',
            ),
            '')
        .replaceAll(RegExp('}'), '');
    var author;
    try {
      author = mapResponse['hits']['hits'][item]['edition']['authors'][0]
              ['name']
          .toString();
    } catch (e) {
      author = "No data available!";
    }
    var cover;
    try {
      cover =
          mapResponse['hits']['hits'][item]['edition']['cover_url'].toString();
    } catch (e) {
      cover = "http://i.imgur.com/J5LVHEL.jpg";
    }
    return Card(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: ListTile(
          title: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(0),
                      image: DecorationImage(
                        scale: 1,
                        image: NetworkImage(cover),
                        fit: BoxFit.fill,
                      )),
                ),
                SizedBox(
                  width: 25,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      bookName.toString(),
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      quote.toString(),
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      author.toString(),
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w200,
                        color: Colors.white70,
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Book {
  final String bookTitle, quote;

  Book(this.bookTitle, this.quote);
}
