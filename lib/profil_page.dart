
import 'package:flutter/material.dart';
import 'package:wisgets_interactif/profil.dart';

class ProfilPage extends StatefulWidget {
  @override
  ProfilPageSate createState() => ProfilPageSate();
}

class ProfilPageSate extends State<ProfilPage> {

  Profil myProfil = Profil(surname: "Exaucé", name: "Yanga");
  late TextEditingController surname;
  late TextEditingController name;
  late TextEditingController secret;
  late TextEditingController age;
  bool showSecret = false;
  Map<String, bool> hobbies = {
    "Pétanque": false,
    "Football": false,
    "Codage": false,
    "Lecture": false,
    "Voyage": false
  };

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    surname = TextEditingController();
    name = TextEditingController();
    secret = TextEditingController();
    age = TextEditingController();
    surname.text = myProfil.surname;
    name.text = myProfil.name;
    secret.text = myProfil.secret;
    age.text = myProfil.age.toString();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    surname.dispose();
    name.dispose();
    secret.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mon profil"),),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Card(
              color: Colors.white38,
              elevation: 0.5,
              child: Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(5),
                child: Column(
                  children: [
                    Text(myProfil.setName()),
                    Text("Age: ${myProfil.setAge()}"),
                    Text("Taille :  ${myProfil.setHeight()}"),
                    Text("Genre: ${myProfil.genderString()}"),
                    Text("Hobbies : ${myProfil.setHobbies()}"),
                    Text("Langage de programmation favori : ${myProfil.favoriteLang}"),
                    ElevatedButton(
                        onPressed: updateSecret,
                        child: Text((showSecret) ? "Cacher secret" : "Montrer secret")
                    ),
                    (showSecret) ? Text(myProfil.secret) : Container(height: 0, width: 0,),
                  ],
                ),
              )
            ),

            const Divider(color: Colors.blueGrey, thickness: 1),

            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                   myTitle("Modifier les infos de mon profil"),
                    myTextField(controller: surname, hint: "Entrer votre prénom"),
                    myTextField(controller: name, hint: "Entrer votre nom"),
                    myTextField(controller: secret, hint: "Dite votre secret", isSecret: true),
                    myTextField(controller: age, hint: "Entrer votre age", type: TextInputType.number),
                  ],
                ),
              ),
            ),

            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Genre : ${myProfil.genderString()}"),
                        Switch(value: myProfil.gender, onChanged: ((newBool){
                          setState(() {
                            myProfil.gender = newBool;
                          });
                        }))
                      ],
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Genre : ${myProfil.setHeight()}"),
                        Slider(
                           value: myProfil.height,
                           min: 0,
                           max: 250,
                           onChanged: ((newHeight) {
                             setState(() {
                               myProfil.height = newHeight;
                            });
                          })
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),

            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    myHobbies(),
                  ],
                ),
              ),
            ),

            Card(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  children: [
                    myRadios(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextField myTextField(
      { required TextEditingController controller,
        required String hint, bool isSecret = false,
        TextInputType type: TextInputType.text
      }){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      keyboardType: type,
      obscureText: isSecret,
      onChanged: ((newValue){
        updateUser();
      }),
    );
  }

  updateUser() {
    setState(() {
      myProfil = Profil(
        surname: surname.text,
        name : name.text,
        secret: secret.text,
        favoriteLang: myProfil.favoriteLang,
        hobbies: myProfil.hobbies,
        height: myProfil.height,
        age: int.parse(age.text),
        gender: myProfil.gender
      );
    });
  }

  updateSecret() {
    setState(() {
      showSecret = !showSecret;
    });
  }
  
  Column myHobbies(){
    List<Widget>  widgets = [myTitle("Mes Hobbies")];
    hobbies.forEach((hobby, like) {
      Row r = Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(hobby),
            Checkbox(value: like, onChanged: (newBool){
              setState(() {
                hobbies[hobby] = newBool ?? false;
                List<String> str = [];
                hobbies.forEach((key, value) {
                  if(value == true) {
                    str.add(key);
                  }
                });
                myProfil.hobbies = str;
              });
            })
          ]
      );
      widgets.add(r);
    });
    return Column(children: widgets,);
  }

  Column myRadios() {
    List<Widget> w = [myTitle("Langage préféré")];
    List<String> langs = ["Dart", "Swift", "Kotlin", "Java", "Python"];
    int index = langs.indexWhere((lang) => lang.startsWith(myProfil.favoriteLang));
    for(var x = 0; x  < langs.length; x++){
      Row r = Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(langs[x]),
          Radio(value: x, groupValue: index, onChanged: (newValue){
            setState(() {
              myProfil.favoriteLang = langs[newValue  as int];
            });
          })
        ],
      );
      w.add(r);
    }
    return Column(
      children: w,
    );
  }

  Text myTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
        fontSize: 18,
      ));
  }
}
