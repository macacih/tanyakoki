import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanyakokii/models/user.dart' as model;
import 'package:tanyakokii/providers/user_provider.dart';
import 'package:tanyakokii/resources/firestore_methods.dart';
import 'package:tanyakokii/screens/bahan_screen.dart';
import 'package:tanyakokii/screens/comments_screen.dart';
import 'package:tanyakokii/utils/colors.dart';
import 'package:tanyakokii/utils/global_variable.dart';
import 'package:tanyakokii/utils/utils.dart';
import 'package:tanyakokii/widgets/like_animation.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class StepStep extends StatefulWidget {
  final snap;
  const StepStep({
    Key? key,
    required this.snap,
  }) : super(key: key);

  @override
  State<StepStep> createState() => _StepCardState();
}

class _StepCardState extends State<StepStep> {
  int commentLen = 0;
  bool isLikeAnimating = false;

  @override
  void initState() {
    super.initState();
    fetchCommentLen();
  }

  fetchCommentLen() async {
    try {
      QuerySnapshot snap = await FirebaseFirestore.instance
          .collection('posts')
          .doc(widget.snap['postId'])
          .collection('postUrl')
          .get();
      commentLen = snap.docs.length;
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
    setState(() {});
  }

  deletePost(String postId) async {
    try {
      await FireStoreMethods().deletePost(postId);
    } catch (err) {
      showSnackBar(
        context,
        err.toString(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final model.User user = Provider.of<UserProvider>(context).getUser;
    final width = MediaQuery.of(context).size.width;

    return Container(
        // boundary needed for web
        decoration: BoxDecoration(
          border: Border.all(
            color:
                width > webScreenSize ? secondaryColor : mobileBackgroundColor,
          ),
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 1,
        ),
        child: Column(children: [
          // HEADER SECTION OF THE POST
          Container(
            padding: const EdgeInsets.symmetric(
              vertical: 4,
              horizontal: 16,
            ).copyWith(right: 0),
            child: Row(children: <Widget>[]),
          ),
          // IMAGE SECTION OF THE POST

          // LIKE, COMMENT SECTION OF THE POST

          //description AND NUMBER OF COMMENTS
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(padding: EdgeInsets.only(top: 10)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BahanScreen(
                                postId: widget.snap['postId'].toString(),
                              ),
                            ));
                        // Implementas
                        // Implementasi aksi ketika button 'Bahan' ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.blue, // Warna latar belakang saat normal
                        onPrimary: Colors.white, // Warna teks saat normal
                        padding:
                            EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                      ),
                      child: Text('Bahan'),
                    ),
                    SizedBox(width: 85), // Jarak antara kedua tombol
                    ElevatedButton(
                      onPressed: () {
                        // Implementasi aksi ketika button 'Step' ditekan
                      },
                      style: ElevatedButton.styleFrom(
                        primary:
                            Colors.blue, // Warna latar belakang saat normal
                        onPrimary: Colors.white, // Warna teks saat normal
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      child: Text('Langkah-Langkah'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(
                        top: 20,
                        bottom: 10,
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: treeColor,
                              fontSize: 20),
                          children: [
                            TextSpan(
                              text: ('Langkah-Langkah :'),
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: treeColor),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(
                              top: 1,
                              bottom: 10,
                            ),
                            child: RichText(
                              text: TextSpan(
                                style: const TextStyle(
                                    color: treeColor, fontSize: 20),
                                children: [
                                  TextSpan(
                                    text: widget.snap['bahan'].toString(),
                                    style: const TextStyle(color: treeColor),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ]))
        ]));
  }
}
