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

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Hello", style: TextStyle(color: Colors.white)),
    );
  }
}
