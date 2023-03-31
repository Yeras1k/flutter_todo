import 'package:flutter/material.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Список дел'),
        centerTitle: true,
      ),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 30)),
              ElevatedButton(
                onPressed: () {
                Navigator.pushNamed(context, '/todo');},
                child: const Text('Перейти далее', style: TextStyle(color: Colors.white, fontSize: 40),)
              )
            ],
          ),
        ]
      )
    );
  }
}
