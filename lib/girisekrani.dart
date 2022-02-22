import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicikayit/anasayfa.dart';
import 'package:kullanicikayit/kayitekrani.dart';

class GirisEkrani extends StatefulWidget {
  const GirisEkrani({Key? key}) : super(key: key);

  @override
  _GirisEkraniState createState() => _GirisEkraniState();
}

class _GirisEkraniState extends State<GirisEkrani> {
  late String email, sifre;

  var _forAnahtari = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Giris Ekranı"),
      ),
      body: Form(
        key: _forAnahtari,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (alinanMail) {
                    email = alinanMail;
                  },
                  validator:(alinanMail){
                    return alinanMail!.contains("@") ? null : "geçersiz mail";

                  } ,

                  decoration: InputDecoration(
                    labelText: "E-mail",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  obscureText: true,
                  onChanged: (alinanSifre) {
                    sifre = alinanSifre;
                  },
                  validator: (alinanSifre){
                    return alinanSifre!.length >=6 ? null : "Şifre en az 6 karakterden olusmalı";

                  },


                  decoration: InputDecoration(
                    labelText: "Sifre",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Container(
                  padding: EdgeInsets.all(8),
                  height: 70,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      girisYap();
                    },
                    child: Text("Giriş Yap"),
                    style: ElevatedButton.styleFrom(primary: Colors.teal),
                  )),
              GestureDetector(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => KayitEkrani()));
                },
                child: Container(
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.centerRight,
                    child: Text(
                      "Hesabım yok..",
                      style: TextStyle(color: Colors.black54),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }

  void girisYap() {
    if(_forAnahtari.currentState!.validate()){

     FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: sifre).then((user)   {

       //eger basarılıysa anasayfaya git

       Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>Anasayfa()   ), (route) => false);

       
     }).catchError((hata){


       Fluttertoast.showToast(msg: "Bilgilerinizi tekrar kontrol ediniz");


     });


    }

  }
}
