import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kullanicikayit/girisekrani.dart';

class Anasayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Anasayfa"),
        actions: [IconButton(onPressed: () {
          
          FirebaseAuth.instance.signOut().then((user){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>GirisEkrani()  ), (route) => false);
          });
          
        },
            icon: Icon(Icons.exit_to_app))],
      ),
    );
  }
}
