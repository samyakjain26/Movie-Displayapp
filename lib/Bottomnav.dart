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
import 'home.dart';

class MyBottomBarDemo extends StatefulWidget {
  @override
  _MyBottomBarDemoState createState() => new _MyBottomBarDemoState();
}

class _MyBottomBarDemoState extends State<MyBottomBarDemo> {
  int _pageIndex = 0;
  PageController _pageController = PageController();

  List<Widget> tabPages = [
    HomeScreen(),
    search(),
    HomeScreen(),
    HomeScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _pageIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.white70,
        onTap: onTabTapped,
        // backgroundColor: Colors.white,
        items: [
          Icon(Icons.home),
          Icon(Icons.search),
          Icon(Icons.add_box),
          Icon(Icons.favorite),
        ],
      ),
      body: PageView(
        children: tabPages,
        onPageChanged: onPageChanged,
        controller: _pageController,
      ),
    );
  }

  void onPageChanged(int page) {
    setState(() {
      this._pageIndex = page;
    });
  }

  void onTabTapped(int index) {
    this._pageController.jumpToPage(index);
  }
}
