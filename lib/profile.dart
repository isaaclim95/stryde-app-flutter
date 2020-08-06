import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

String height, weight, age, sex;

class AgeDropdown extends StatefulWidget {
  AgeDropdown({Key key}) : super(key: key);

  @override
  AgeDropdownState createState() => AgeDropdownState();
}

class AgeDropdownState extends State<AgeDropdown> {
  @override
  Widget build(BuildContext context) {
    List<String> items = <String>[];
    for (int i = 12; i <= 100; i++) {
      items.add(i.toString());
    }

    return Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Color(0xFF409ded),
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF409ded),
                    ),
                    child: DropdownButton<String>(
                      value: age,
                      hint: Text(
                        "Age",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          age = newValue;
                        });
                      },
                      items:
                          items.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )))));
  }
}

class GenderDropdown extends StatefulWidget {
  GenderDropdown({Key key}) : super(key: key);

  @override
  GenderDropdownState createState() => GenderDropdownState();
}

class GenderDropdownState extends State<GenderDropdown> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: 110,
        decoration: BoxDecoration(
          borderRadius: new BorderRadius.circular(10.0),
          color: Color(0xFF409ded),
        ),
        child: DropdownButtonHideUnderline(
            child: ButtonTheme(
                alignedDropdown: true,
                child: new Theme(
                    data: Theme.of(context).copyWith(
                      canvasColor: Color(0xFF409ded),
                    ),
                    child: DropdownButton<String>(
                      value: sex,
                      hint: Text(
                        "Sex",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextStyle(color: Colors.white, fontSize: 16),
                      onChanged: (String newValue) {
                        setState(() {
                          sex = newValue;
                        });
                      },
                      items: <String>['Male', 'Female', 'Other']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    )))));
  }
}

class Profile extends StatefulWidget {
  @override
  ProfileState createState() => ProfileState();
}

class ProfileState extends State<Profile> {

  final GlobalKey<FormState> _formHealthKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formUserKey = GlobalKey<FormState>();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _historyController = TextEditingController();

  @override
  void initState() {
    _heightController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _heightController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {

    ////////////////////////////////////////////////////////////////////////////
    // set values for forms


    String uid;

    Future fetchUid() async {
      uid = (await FirebaseAuth.instance.currentUser()).uid;
    }

    // Methods here
    Future getValueFromUser(String k) async {
      String userId = (await FirebaseAuth.instance.currentUser()).uid;
      final usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
//        print(values[k]);
      });
    }



    getValueFromUser("Height");
    fetchUid();

    Future setTextControllers() async {
      String userId = (await FirebaseAuth.instance.currentUser()).uid;
      final usersReference = FirebaseDatabase.instance.reference().child("users").child(userId);
      usersReference.once().then((DataSnapshot snapshot){
        Map<dynamic, dynamic> values = snapshot.value;
        _heightController.text = values['Height'].toString();
        _weightController.text= values['Weight'].toString();
        _nameController.text = values['Name'].toString();
        _emailController.text = values['Email'].toString();
        _historyController.text = values['History of Injury'].toString();
      });
    }

    setTextControllers();

    ////////////////////////////////////////////////////////////////////////////

    return Material(
      child: Center(
        child: SingleChildScrollView(
            child: Column(
          children: [
            const SizedBox(height: 60),

            // Heading
            Text(
              "Profile",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xFF409ded),
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),

            // Margin
            const SizedBox(height: 10),

            // Profile icon and name
            Container(
                width: 300,
                child: Row(children: [
                  Icon(Icons.account_circle, size: 50),
                  const SizedBox(width: 10),
                  Text(
                    "Daniel",
                    style: TextStyle(fontSize: 18),
                  )
                ])),

            // margin
            const SizedBox(height: 10),

            // Health statistics heading
            Container(
              width: 275,
              child: Text(
                "Health Statistics:",
                style: TextStyle(
                  color: Color(0xFF409ded),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // margin
            const SizedBox(height: 10),

            Form(
                key: _formHealthKey,
                child: Column(children: [
                  Container(
                      width: 300,
                      child: Row(
                        children: [
                          // height textfield
                          Container(
                            width: 90,
                            child: TextFormField(
                              controller: _heightController,
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFf0f0f0),
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      10.0, 5.0, 10.0, 5.0),
                                  border: OutlineInputBorder(),
                                  labelText: 'Height',
                                  hintText: "cm",),
                            ),
                          ),

                          // margin
                          const SizedBox(width: 20),

                          // width textfield
                          Container(
                            width: 90,
                            child: TextFormField(
                              controller: _weightController,
                              decoration: InputDecoration(
                                  fillColor: Color(0xFFf0f0f0),
                                  filled: true,
                                  contentPadding: const EdgeInsets.fromLTRB(
                                      10.0, 5.0, 10.0, 5.0),
                                  border: OutlineInputBorder(),
                                  labelText: 'Weight',
                                  hintText: "kg"),
                            ),
                          ),

                          //margin
                          const SizedBox(width: 20),

                          // BMI Text
                          Text(
                            "BMI: 90",
                            style: TextStyle(fontSize: 16),
                          )
                        ],
                      )),

                  // margin
                  const SizedBox(height: 10),

                  // Health index text
                  Container(
                      width: 300,
                      child: Text(
                        "Health Index: 7",
                        style: TextStyle(fontSize: 16),
                      )),

                  // margin
                  const SizedBox(height: 10),

                  // History of injury Text field
                  Container(
                    width: 300,
                    child: TextFormField(
                      controller: _historyController,
                      maxLines: 4,
                      decoration: InputDecoration(
                        fillColor: Color(0xFFf0f0f0),
                        filled: true,
                        contentPadding:
                            const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                        border: OutlineInputBorder(),
                        labelText: 'History of Injury',
                      ),
                    ),
                  ),
                ])),

            // margin
            const SizedBox(height: 10),

            // Graph
            Image(
              image: AssetImage('images/graph.png'),
              width: 300,
            ),

            // margin
            const SizedBox(height: 10),

            // Save health stats Button
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                // Save
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Color(0xFF409ded),
                ),
                width: 180,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                child: const Text('Save', style: TextStyle(fontSize: 20)),
              ),
            ),

            // margin
            const SizedBox(height: 30),

            // User Information heading
            Container(
              width: 275,
              child: Text(
                "User Information:",
                style: TextStyle(
                  color: Color(0xFF409ded),
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // margin
            const SizedBox(height: 10),

            // Name textfield
            Form(
              key: _formUserKey,
                child: Column(children: [
              Container(
                width: 300,
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFf0f0f0),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                ),
              ),

              // margin
              const SizedBox(height: 10),

              // Email TextField
              Container(
                width: 300,
                child: TextFormField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    fillColor: Color(0xFFf0f0f0),
                    filled: true,
                    contentPadding:
                        const EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                ),
              ),

              // DropDownBoxes Age and Gender
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AgeDropdown(),
                  const SizedBox(width: 30),
                  GenderDropdown(),
                ],
              ),
            ])),

            // margin
            const SizedBox(height: 10),

            // save user information button
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(10.0)),
              onPressed: () {
                // Save
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: new BorderRadius.circular(10.0),
                  color: Color(0xFF409ded),
                ),
                width: 180,
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 10.0, 0, 10.0),
                child: const Text('Save', style: TextStyle(fontSize: 20)),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
