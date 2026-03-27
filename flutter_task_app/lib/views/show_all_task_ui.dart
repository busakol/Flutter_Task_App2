import 'package:flutter/material.dart';

class ShowAllTaskUi extends StatefulWidget {
  const ShowAllTaskUi({super.key});

  @override
  State<ShowAllTaskUi> createState() => _ShowAllTaskUiState();
}

class _ShowAllTaskUiState extends State<ShowAllTaskUi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[800],
        title: Text(
          'TASK ME',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      //Floating Action Button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[800],
      ),
      //ตำแหน่งของ Floating Action Button
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
