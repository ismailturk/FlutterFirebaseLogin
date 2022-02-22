import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:kullanicikayit/anasayfa.dart';
import 'package:kullanicikayit/girisekrani.dart';

class KayitEkrani extends StatefulWidget {


  @override
  _KayitEkraniState createState() => _KayitEkraniState();
}

class _KayitEkraniState extends State<KayitEkrani> {
  //----------------KAYIT PARAMETRELERİ


  var _formAnahtari =GlobalKey<FormState>();

 late String email,sifre;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Firebase Kayıt"),
        centerTitle: true,
      ),
      body: Form(
        key: _formAnahtari,

        child: Container(
          padding: EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  onChanged: (alinanMail) {
                    setState(() {
                      email = alinanMail;
                    });
                  },
                  validator: (alinanMail){
                    return alinanMail!.contains("@") ? null : "Mail geçersiz";
                  },
                  keyboardType: TextInputType.emailAddress,
                  // girdinin email oldugunu anlar ve ona göre öneri verir
                  decoration: InputDecoration(
                      labelText: "E-mail", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 30,
                ),
                TextFormField(
                  onChanged: (alinanSifre) {
                    sifre = alinanSifre;
                  },
                  validator: (alinanSifre){
                    return alinanSifre!.length >=6 ? null : "En az6 karakterden oluşmalı";

                  },
                  obscureText: true, //şifreyi gizleyerek gider
                  decoration: InputDecoration(
                      labelText: "Şifre", border: OutlineInputBorder()),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      kayitEkle();
                    },
                    child: Text("Kaydol"),
                    style: ElevatedButton.styleFrom(
                        primary: Colors.indigoAccent,
                        textStyle: GoogleFonts.cabin(fontSize: 24)),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        //HESABI VARSA GİRİŞ SAYFASIAN ATSIN

                        Navigator.push(context, MaterialPageRoute(builder:  (_)=>GirisEkrani()   ));
                      },
                        child: Text(
                      "Zaten bir hesaba sahibim..",
                      style: TextStyle(color: Colors.black45),
                    ))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void kayitEkle() {

    if(_formAnahtari.currentState!.validate()){
      FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: sifre).then((user) {

        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=> GirisEkrani()), // geri dönüş olmasın diye .push yerine pushandremoveuntil kullandık
                (Route<dynamic> route) => false
        );

      }).catchError((hata){
        Fluttertoast.showToast(msg: "bilgilerinizi kontrol edin!!!!!");
      });

    }

    }
  }

