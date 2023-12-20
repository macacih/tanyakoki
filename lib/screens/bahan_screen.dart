import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanyakokii/utils/colors.dart';
import 'package:tanyakokii/utils/global_variable.dart';
import 'package:tanyakokii/widgets/bahan_card.dart';
import 'package:tanyakokii/widgets/bahan_bahan.dart';

class BahanScreen extends StatefulWidget {
  final postId;
  const BahanScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<BahanScreen> createState() => _BahanScreenState();
}

class _BahanScreenState extends State<BahanScreen> {
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
                'Bahan',
                style: TextStyle(color: treeColor),
              ),
            ),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection('posts').limit(1).snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (ctx, index) => Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 15 : 0,
                  ),
                  child: BahanCard(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: width > webScreenSize ? width * 0.3 : 0,
                    vertical: width > webScreenSize ? 15 : 0,
                  ),
                  child: BahanBahan(
                    snap: snapshot.data!.docs[index].data(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
