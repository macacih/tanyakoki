import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tanyakokii/utils/colors.dart';
import 'package:tanyakokii/utils/global_variable.dart';
import 'package:tanyakokii/widgets/bahan_bahan.dart';
import 'package:tanyakokii/widgets/bahan_card.dart';
import 'package:tanyakokii/widgets/step_card.dart';

class StepScreen extends StatefulWidget {
  final postId;
  const StepScreen({Key? key, required this.postId}) : super(key: key);

  @override
  State<StepScreen> createState() => _StepScreenState();
}

class _StepScreenState extends State<StepScreen> {
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
                'Langkah-langkah',
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
                  child: StepStep(
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
