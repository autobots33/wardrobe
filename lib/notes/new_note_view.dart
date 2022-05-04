// ignore_for_file: camel_case_types

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class newNoteView extends StatefulWidget {
  const newNoteView({Key? key}) : super(key: key);

  @override
  State<newNoteView> createState() => _newNoteViewState();
}

class _newNoteViewState extends State<newNoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title:const Text('New Notes')),
        body:const Text('Write your new notes'),

      );

  }
}
