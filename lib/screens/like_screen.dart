import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tanyakokii/utils/colors.dart';
import 'package:tanyakokii/utils/global_variable.dart';

class LikedPostsScreen extends StatefulWidget {
  const LikedPostsScreen({Key? key}) : super(key: key);
  @override
  _LikedPostsScreenState createState() => _LikedPostsScreenState();
}

class _LikedPostsScreenState extends State<LikedPostsScreen> {
  late Future<QuerySnapshot<Map<String, dynamic>>> likedPostsFuture;
  void initState() {
    super.initState();
    likedPostsFuture = getLikedPosts();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getLikedPosts() async {
    String currentUserId = FirebaseAuth.instance.currentUser!.uid;

    return FirebaseFirestore.instance
        .collection('posts')
        .where('likes', isEqualTo: currentUserId)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor:
          width > webScreenSize ? webBackgroundColor : mobileBackgroundColor,
      appBar: width > webScreenSize
          ? null
          : AppBar(
              backgroundColor: mobileBackgroundColor,
              centerTitle: false,
              title: Text(
                'Resep Yang Disukai',
                style: TextStyle(color: treeColor),
              ),
            ),
      body: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: likedPostsFuture,
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No liked posts found'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              QueryDocumentSnapshot<Map<String, dynamic>> likeSnapshot =
                  snapshot.data!.docs[index];
              String postId = likeSnapshot['postId'];

              return FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(postId)
                    .get(),
                builder: (context, postSnapshot) {
                  if (postSnapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(); // Or a loading placeholder widget if needed
                  }

                  if (!postSnapshot.hasData || !postSnapshot.data!.exists) {
                    return SizedBox(); // Or a placeholder widget if the post isn't found
                  }

                  // Display information about the post liked by the user
                  Map<String, dynamic> postData = postSnapshot.data!.data()!;

                  return ListTile(
                    title: Text(postData['title']),
                    subtitle: Text(postData['description']),
                    // Add other UI logics as needed
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
