import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:thesisgisproject/constants.dart';

class TermAndConditions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Term & Conditions"),
        elevation: 0,
        backgroundColor: kPrimaryColor,
        centerTitle: true,
      ),
      body: new Container(
        margin: const EdgeInsets.all(8.0),
        child: new Markdown(
            data: markdownDataTermAndConditions
        ),
      ),
    );
  }
}
