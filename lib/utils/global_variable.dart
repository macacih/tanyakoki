import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanyakokii/screens/add_post_screen.dart';
import 'package:tanyakokii/screens/feed_screen.dart';
import 'package:tanyakokii/screens/profile_screen.dart';
import 'package:tanyakokii/screens/search_screen.dart';
import 'package:tanyakokii/screens/like_screen.dart';

const webScreenSize = 600;

List<Widget> homeScreenItems = [
  const FeedScreen(),
  const SearchScreen(),
  const AddPostScreen(),
  const LikedPostsScreen(),
  ProfileScreen(
    uid: FirebaseAuth.instance.currentUser!.uid,
  ),
];
