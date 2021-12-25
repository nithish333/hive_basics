import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginList extends StatefulWidget {
  const LoginList({Key? key}) : super(key: key);

  @override
  State<LoginList> createState() => _LoginListState();
}

class _LoginListState extends State<LoginList> {
  late final Box box;
  @override
  void initState() {
    super.initState();
    box = Hive.box('loginInfo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: ValueListenableBuilder(
            valueListenable: box.listenable(),
            builder: (context, Box box, child) {
              if (box.isEmpty) {
                return const Center(
                  child: Card(
                    child: Text('Empty login details'),
                  ),
                );
              }
              return ListView.builder(
                shrinkWrap: true,
                itemBuilder: (ctx, index) {
                  var currentLoginDetail = box.getAt(index);
                  return Dismissible(
                    key: ValueKey(index),
                    direction: DismissDirection.endToStart,
                    onDismissed: (direction) {
                      currentLoginDetail.delete();
                    },
                    background: Container(
                      color: Colors.red[800],
                      child: IconButton(
                        alignment: Alignment.centerRight,
                        padding: const EdgeInsets.only(right: 20),
                        onPressed: () {},
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    child: Card(
                      child: ListTile(
                        title: Text(currentLoginDetail.name),
                        subtitle: Text(currentLoginDetail.password),
                      ),
                    ),
                  );
                },
                itemCount: box.length,
              );
            },
          )),
    );
  }
}
