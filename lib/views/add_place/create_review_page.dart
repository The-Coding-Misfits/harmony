import 'package:flutter/material.dart';
import 'package:harmony/models/place.dart';

class CreateReviewPage extends StatefulWidget {
  final Place place;

  const CreateReviewPage(this.place, {Key? key}) : super(key: key);

  @override
  CreateReviewPageState createState() => CreateReviewPageState();
}

class CreateReviewPageState extends State<CreateReviewPage> {
  TextEditingController contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Create review", style: TextStyle(color: Colors.black)),
        backgroundColor: const Color(0x11000000),
        foregroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
            child: TextField(
              minLines: 2,
              maxLines: 2,
              textInputAction: TextInputAction.newline,
              keyboardType: TextInputType.multiline,
              controller: contentController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffececec)),
                  borderRadius: BorderRadius.zero,
                  gapPadding: 0,
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffececec)),
                  borderRadius: BorderRadius.zero,
                  gapPadding: 0,
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Color(0xffececec)),
                  borderRadius: BorderRadius.zero,
                  gapPadding: 0,
                ),
                hintText: "Write some content...",
                fillColor: Color(0xffececec),
                filled: true,
                hintStyle: TextStyle(
                    color: Colors.black
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}