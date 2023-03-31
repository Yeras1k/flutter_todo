import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  late String _userToDo;

  @override
  void initState() {
    super.initState();
  }

  void _menuOpen(){
    Navigator.of(context).push(
      MaterialPageRoute(builder: (BuildContext context){
        return Scaffold(
          appBar: AppBar(title: const Text('Menu'),),
          body: Row(
            children: [
              ElevatedButton( onPressed: () {
                Navigator.pop(context);
                Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
              }, 
              child: const Text('На Главную') ),
              const Padding(padding: EdgeInsets.only(left: 20)),
              const Text('Наше простое меню'),
            ],
          ),
        );
      })
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text('Список дел'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            onPressed: _menuOpen,
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('items').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text('Нет записей', style: TextStyle(
                color: Colors.red, fontSize: 50, fontFamily: 'Oswald'),)
              ],
            );
          }
          return ListView.builder(
              itemCount: snapshot.data?.docs.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: UniqueKey(),
                    child: Card(
                      child: ListTile(
                        title: Text(snapshot.data?.docs[index].get('item')),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete_forever_rounded,
                            color: Colors.deepOrange,
                          ),
                          onPressed: () {
                            FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                          },
                        ),
                      ),
                    ),
                    onDismissed: (direction) {
                      FirebaseFirestore.instance.collection('items').doc(snapshot.data?.docs[index].id).delete();
                    }
                );
              }
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        child: const Icon(
          Icons.add_box,
          color: Colors.white,
        ),
        onPressed: () {
          showDialog(context: context, builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Добавить элемент'),
              content: TextField(
                onChanged: (String value){
                  _userToDo = value;
                },
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    FirebaseFirestore.instance.collection('items').add({'item': _userToDo});
                    Navigator.of(context).pop();
                  },
                  child: const Text('Добавить'))
              ],
            );
          });
        },
      ),
    );
  }
}
