import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movie_rater/Search.dart';
import 'package:movie_rater/trendingmoviesdesc.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'sidemenu.dart';
import 'dart:io';
import 'dart:async';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final String api = "7efb42dbdb5674187eb5d689ad8de159";
  List trendingmovies = [];
  List toprated = [];
  List tvseries = [];
  List Upcoming = [];
  List recommended = [];

  final token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZWZiNDJkYmRiNTY3NDE4N2ViNWQ2ODlhZDhkZTE1OSIsInN1YiI6IjYxMjEzOGIyMzg3NjUxMDA3MzE4MTM3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w9NaPqE5L2uf_TKdXPhmQq7QOS5lRYA4QJK_QW65uC8";
  loadmovies() async {
    https: //api.themoviedb.org/3/movie/550?api_key={api_key}&callback=test
    String url1 = SERVER_URL() + "trending/all/day?api_key=${api}";
    var res = await http.get(Uri.parse(url1));
    var json1 = json.decode(res.body);

    String url2 =
        SERVER_URL() + "tv/top_rated?api_key=${api}&language=en-US&page=1";
    var res1 = await http.get(Uri.parse(url2));
    var json2 = json.decode(res1.body);

    String url3 =
        SERVER_URL() + "movie/top_rated?api_key=${api}&language=en-US&page=1";
    var res2 = await http.get(Uri.parse(url3));
    var json3 = json.decode(res2.body);

    String url4 =
        SERVER_URL() + "movie/upcoming?api_key=${api}&language=en-US&page=1";
    var res3 = await http.get(Uri.parse(url4));
    var json4 = json.decode(res3.body);

    String url5 =
        SERVER_URL() + "movie/now_playing?api_key=${api}&language=en-US&page=1";
    var res4 = await http.get(Uri.parse(url5));
    var json5 = json.decode(res4.body);

    setState(() {
      print("hello  $json1");
      trendingmovies = json1["results"];
      tvseries = json2["results"];
      toprated = json3["results"];
      Upcoming = json4["results"];
      recommended = json5["results"];
      // print(trendingmovies);
    });
  }

  @override
  void initState() {
    loadmovies();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(scaffoldBackgroundColor: Colors.black),
      home: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: Text(
            "What's New",
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.notification_add,
                color: Colors.white,
              ),
              onPressed: () {
                loadmovies();
              },
            )
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 50,
              child: Text("Trending Movies",
                  style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(fontSize: 30, color: Colors.white))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.2,
              child: ListView.builder(
                  itemCount: trendingmovies.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 3.6,
                        width: 160,
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
                                    height: MediaQuery.of(context).size.height /
                                        3.92,
                                    width: 150,
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
                        ));
                  }),
            ),
            SizedBox(
              height: 50,
              child: Text("Top Rated Movies",
                  style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(fontSize: 30, color: Colors.white))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  itemCount: toprated.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 3.6,
                        width: 160,
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
                                              Description(toprated, index)));
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.92,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                toprated[index]["poster_path"]),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    child: Text("")),
                              ),
                            ),
                            Text("${toprated[index]["original_title"]}",
                                style: TextStyle(color: Colors.white))
                          ],
                        ));
                  }),
            ),
            SizedBox(
              height: 50,
              child: Text("Now Playing",
                  style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(fontSize: 30, color: Colors.white))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3.2,
              child: ListView.builder(
                  itemCount: recommended.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 3.6,
                        width: 160,
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
                                              Description(recommended, index)));
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.92,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                recommended[index]
                                                    ["poster_path"]),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    child: Text("")),
                              ),
                            ),
                            Text("${recommended[index]["original_title"]}",
                                style: TextStyle(color: Colors.white))
                          ],
                        ));
                  }),
            ),
            SizedBox(
              height: 50,
              child: Text("TV Series",
                  style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(fontSize: 30, color: Colors.white))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  itemCount: tvseries.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 3.6,
                        width: 160,
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
                                              Description(tvseries, index)));
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.92,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                tvseries[index]["poster_path"]),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    child: Text("")),
                              ),
                            ),
                            Text("${tvseries[index]["original_name"]}",
                                style: TextStyle(color: Colors.white))
                          ],
                        ));
                  }),
            ),
            SizedBox(
              height: 50,
              child: Text("Upcoming Movies",
                  style: GoogleFonts.playfairDisplay(
                      textStyle: TextStyle(fontSize: 30, color: Colors.white))),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.builder(
                  itemCount: Upcoming.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                        height: MediaQuery.of(context).size.height / 3.6,
                        width: 160,
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
                                              Description(Upcoming, index)));
                                },
                                child: Container(
                                    height: MediaQuery.of(context).size.height /
                                        3.92,
                                    width: 150,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15.0),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            "https://image.tmdb.org/t/p/w500" +
                                                Upcoming[index]["poster_path"]),
                                        fit: BoxFit.cover,
                                        alignment: Alignment.center,
                                      ),
                                    ),
                                    child: Text("")),
                              ),
                            ),
                            Text("${Upcoming[index]["original_title"]}",
                                style: TextStyle(color: Colors.white))
                          ],
                        ));
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
