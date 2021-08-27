import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_rater/trendingmoviesdesc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'sidemenu.dart';
import 'dart:io';
import 'dart:async';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

var response;
List trendingmovies = [];

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  final String api = "7efb42dbdb5674187eb5d689ad8de159";
  TextEditingController search = TextEditingController();
  loadmovies() async {
    String url1 = SERVER_URL() + "trending/all/day?api_key=${api}";
    var res = await http.get(Uri.parse(url1));
    var json1 = json.decode(res.body);
    setState(() {
      trendingmovies = json1["results"];
    });
  }

  searchmovies() async {
    String url2 = SERVER_URL() +
        "search/multi?api_key=${api}&language=en-US&query=${search.text}&page=1&include_adult=false";
    var res2 = await http.get(Uri.parse(url2));
    var json2 = json.decode(res2.body);
    setState(() {
      response = json2["results"];
    });
  }

  @override
  void initState() {
    loadmovies();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: Icon(
                Icons.search,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () {
                searchmovies();
              },
            ),
          )
        ],
        backgroundColor: Colors.black,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            color: Colors.white,
          ),
          // color: Colors.white,
          width: MediaQuery.of(context).size.width / 1.24,
          child: TextFormField(
            controller: search,
            decoration: InputDecoration(
                hintText: "Search",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10))),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.height / 1.184,
                child: search_result(context)),
          ],
        ),
      ),
    );
  }
}

Widget search_result(context) {
  if (response == null) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height / 20,
          child: Text("Suggestions",
              style: GoogleFonts.playfairDisplay(
                  textStyle: TextStyle(fontSize: 30, color: Colors.white))),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height / 1.27,
          child: ListView.builder(
              itemCount: trendingmovies.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                      height: MediaQuery.of(context).size.height / 3.5,
                      width: MediaQuery.of(context).size.width / 1,
                      child: Column(
                        children: [
                          Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Description(
                                            trendingmovies, index)));
                              },
                              child: Container(
                                  height:
                                      MediaQuery.of(context).size.height / 3.92,
                                  width: MediaQuery.of(context).size.width / 1,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.0),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "https://image.tmdb.org/t/p/w500" +
                                              trendingmovies[index]
                                                  ["poster_path"]),
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ),
                                  child: Text("")),
                            ),
                          ),
                          Text(
                            "${trendingmovies[index]["original_title"]}",
                            style: TextStyle(color: Colors.white),
                          )
                        ],
                      )),
                );
              }),
        ),
      ],
    );
  } else {
    if (response.length == 0) {
      return Center(
        child: Text("hello"),
      );
    } else {
      return Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 20,
            child: Text("Search Results",
                style: GoogleFonts.playfairDisplay(
                    textStyle: TextStyle(fontSize: 30, color: Colors.white))),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 1.27,
            child: ListView.builder(
                itemCount: response.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        height: MediaQuery.of(context).size.height / 3.3,
                        width: MediaQuery.of(context).size.width / 1,
                        child: Column(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Description(response, index)));
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.92,
                                    width:
                                        MediaQuery.of(context).size.width / 1,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                response[index]["poster_path"]),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    child: Text("")),
                              ),
                            ),
                            Text(
                              "${response[index]["original_title"]}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        )),
                  );
                }),
          ),
        ],
      );
    }
  }
}
