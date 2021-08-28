import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'config.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Description extends StatefulWidget {
  final List jsonRespose;
  final int index;
  Description(this.jsonRespose, this.index);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  List cast = [];
  List similar = [];
  Map detail = {};

  final String api = "7efb42dbdb5674187eb5d689ad8de159";
  final token =
      "eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3ZWZiNDJkYmRiNTY3NDE4N2ViNWQ2ODlhZDhkZTE1OSIsInN1YiI6IjYxMjEzOGIyMzg3NjUxMDA3MzE4MTM3MCIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.w9NaPqE5L2uf_TKdXPhmQq7QOS5lRYA4QJK_QW65uC8";

  getcredits() async {
    final String movie_id = "${widget.jsonRespose[widget.index]["id"]}";

    String url1 = SERVER_URL() +
        "movie/${movie_id}/credits?api_key=${api}&language=en-US";
    var res1 = await http.get(Uri.parse(url1));
    var json1 = json.decode(res1.body);

    String url2 = SERVER_URL() +
        "movie/${movie_id}/recommendations?api_key=${api}&language=en-US&page=1";
    var res2 = await http.get(Uri.parse(url2));
    var json2 = json.decode(res2.body);

    String url3 =
        SERVER_URL() + "movie/${movie_id}?api_key=${api}&language=en-US";
    var res3 = await http.get(Uri.parse(url3));
    var json3 = json.decode(res3.body);

    setState(() {
      cast = json1["cast"];
      print(json1);
      detail.addAll(json3);
      // print(detail);
      similar = json2["results"];
    });
  }

  @override
  void initState() {
    getcredits();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "${widget.jsonRespose[widget.index]["original_title"]}",
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.star,
                        color: Colors.yellow,
                      ),
                      onPressed: () {
                        getcredits();
                      },
                    ),
                    Text(
                      "${widget.jsonRespose[widget.index]["vote_average"] != null ? "${widget.jsonRespose[widget.index]["vote_average"]}" : "NA"}",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )
            ],
          ),
          body: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 3.4,
                width: MediaQuery.of(context).size.width / 1.1,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0),
                        image: DecorationImage(
                          image: NetworkImage(
                              "https://image.tmdb.org/t/p/w500" +
                                  widget.jsonRespose[widget.index]
                                      ["backdrop_path"]),
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: IconButton(
                          icon: Icon(
                            Icons.favorite,
                            color: Colors.white,
                          ),
                          onPressed: () {},
                        ),
                      )),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 7,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: Text(
                              " Status: ${detail["status"] != null ? "${detail["status"]}" : " "}",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20)),
                        ),
                        Spacer(),
                        // Padding(
                        //   padding: const EdgeInsets.only(right: 5.0),
                        //   child: Text(
                        //       " Genre: ${detail["genres"][0]["name"] != null ? "${detail["genres"][0]["name"]}" : " "}",
                        //       style:
                        //           TextStyle(color: Colors.white, fontSize: 20)),
                        // ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: Text(
                                " Runtime: ${detail["runtime"] != null ? "${detail["runtime"]}" : " "} mins",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                          Spacer(),
                          Padding(
                            padding: const EdgeInsets.only(right: 5.0),
                            child: Text(
                                " Release Date: ${detail["release_date"] != null ? "${DateTime.parse(detail["release_date"]).day}- ${DateTime.parse(detail["release_date"]).month}-${DateTime.parse(detail["release_date"]).year}" : " "}",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 17)),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 50,
                child: Text("Overview",
                    style: GoogleFonts.playfairDisplay(
                        textStyle:
                            TextStyle(fontSize: 30, color: Colors.white))),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 6,
                  child: ListView(
                    children: [
                      Text(
                          "${detail["overview"] != null ? "${detail["overview"]}" : " "}",
                          style: TextStyle(color: Colors.white, fontSize: 20))
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 50,
                child: Text("Cast",
                    style: GoogleFonts.playfairDisplay(
                        textStyle:
                            TextStyle(fontSize: 30, color: Colors.white))),
              ),
              SizedBox(
                  height: MediaQuery.of(context).size.height / 4.5,
                  child: ListView.builder(
                      itemCount: cast.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                  width: 110,
                                  height: 110,
                                  decoration: new BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: new DecorationImage(
                                          fit: BoxFit.fill,
                                          image: new NetworkImage(
                                              "https://image.tmdb.org/t/p/w500" +
                                                  "${cast[index]["profile_path"] != null ? "${cast[index]["profile_path"]}" : "${cast[0]["profile_path"]}"}")))),
                            ),
                            Text(
                              "${cast[index]["name"]}",
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        );
                      })),
              SizedBox(
                height: 50,
                child: Text("Movies You May Like",
                    style: GoogleFonts.playfairDisplay(
                        textStyle:
                            TextStyle(fontSize: 30, color: Colors.white))),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 3,
                child: ListView.builder(
                    itemCount: similar.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: MediaQuery.of(context).size.height / 3.5,
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
                                                Description(similar, index)));
                                  },
                                  child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              3.92,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              "https://image.tmdb.org/t/p/w500" +
                                                  similar[index]
                                                      ["poster_path"]),
                                          fit: BoxFit.cover,
                                          alignment: Alignment.center,
                                        ),
                                      ),
                                      child: Text("")),
                                ),
                              ),
                              Text("${similar[index]["original_title"]}",
                                  style: TextStyle(color: Colors.white))
                            ],
                          ));
                    }),
              ),
            ],
          )),
    );
  }
}
