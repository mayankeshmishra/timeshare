import 'dart:io';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:timeshare/constants.dart';
import 'package:timeshare/login/skillAdd.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  File profilePic;
  final picker = ImagePicker();
  // final _auth = FirebaseAuth.instance;
  Map user = {
    'firstName': '',
    'lastName': '',
    'profilePic': '',
    'email': '',
    'mobile': [],
    'gender': '',
    'dob': '',
    'bloodGrp': '',
    'disease': '',
    'adhaar': '',
    'address': '',
    'locality': '',
    'city': '',
    'state': '',
    'pinCode': '',
    'highestQualification': '',
    'professionalCareer': '',
    'hobbies': '',
    'emergencyContact': '',
    'emergencyName': '',
    'emergencyRelation': '',
    'skillSet': [],
    'kyc': {'adhaar': '', 'voterId': '', 'drivingLicense': '', 'passport': ''},
    'myMeetings': [],
    'joinedMeetings': [],
    'notifications': [],
    'accValidated':false
  };
  String firstName,
      lastName,
      email,
      secmobile=' ',
      primarymobile,
      bloodGroup='Select',
      disease='Select',
      adhaar,
      address,
      locality,
      city,
      state,
      pincode,
      dob,
      gender='Select',
      highestQualification='Select',
      professionalCareer,
      hobbies,
      emergencyContact,
      emergencyName,
      emergencyRelationship='Select';
  List<String> qualifications = [
    'Select',
    'Doctorate',
    'Post-Graduate',
    'Graduate',
    'Non-Graduate'
  ];
  // String uid;
  List<String> skillSet = ['Skill 1', 'Skill 2', 'Skill 3'];

  initState() {
    super.initState();
    getUserId();
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        profilePic = File(pickedFile.path);
      }
    });
    uploadFile();
    Navigator.pop(context);
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera,imageQuality: 50);

    setState(() {
      if (pickedFile != null) {
        profilePic = File(pickedFile.path);
      }
    });
    uploadFile();
    Navigator.pop(context);
  }

  // snackBar Widget
  snackBar(String message) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: width,
        decoration: linerGradient,
        child: ListView(
          children: [
            SizedBox(height: height * 0.05),
            logo,
            SizedBox(
              height: height * 0.04,
            ),
            Stack(
              children: [
                Container(
                    width: width,
                    decoration: roundedBox,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.01),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(height: height * 0.05),
                            Text('REGISTER', style: kHeading2Style),
                            SizedBox(
                              height: height * 0.04,
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: width * 0.04),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      showMaterialModalBottomSheet(
                                        context: context,
                                        builder: (context) => Container(
                                            decoration: linerGradient,
                                            height: height * 0.2,
                                            child: Column(
                                              children: [
                                                SizedBox(height: height * 0.02),
                                                Text('Choose Image Source',
                                                    style: kHeading3Style),
                                                SizedBox(
                                                  height: height * 0.05,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    TextButton(
                                                      child: Container(
                                                        height: height * 0.035,
                                                        width: width * 0.4,
                                                        child: Center(
                                                          child: Text(
                                                            "GALLERY",
                                                            style: kButtonText,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed:
                                                          getImageGallery,
                                                      style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .black),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.02,
                                                    ),
                                                    TextButton(
                                                      child: Container(
                                                        height: height * 0.035,
                                                        width: width * 0.4,
                                                        child: Center(
                                                          child: Text(
                                                            "CAMERA",
                                                            style: kButtonText,
                                                          ),
                                                        ),
                                                      ),
                                                      onPressed: getImageCamera,
                                                      style: ButtonStyle(
                                                        foregroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    blue3),
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all<Color>(
                                                                    Colors
                                                                        .white),
                                                        shape:
                                                            MaterialStateProperty
                                                                .all(
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30.0),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            )),
                                      );
                                    },
                                    child: Container(
                                        decoration: inputFieldDecoration,
                                        width: width * 0.6,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical:height*0.015),
                                          child: Row(
                                            children: [
                                              SizedBox(
                                                width: height * 0.015,
                                              ),
                                              FaIcon(FontAwesomeIcons.camera,
                                                  size: height * 0.02,
                                                  color: Colors.black),
                                              SizedBox(
                                                width: height * 0.01,
                                              ),
                                              Text('Update Profile Pic',
                                                  style: TextStyle(
                                                      fontSize: height * 0.022,
                                                      fontWeight:
                                                          FontWeight.w500)),
                                            ],
                                          ),
                                        )),
                                  ),
                                  Spacer(),
                                  
                                  Container(
                                    height: height * 0.1,
                                    width: height * 0.1,
                                    child:Card(
                                    semanticContainer: true,
                                    clipBehavior: Clip.antiAliasWithSaveLayer,
                                    child: (profilePic != null)
                                        ? Image.file(profilePic,
                                            fit: BoxFit.cover)
                                        : Image.asset('assets/profile.jfif',
                                            fit: BoxFit.cover),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(height),
                                    ),
                                    elevation: 5,
                                  ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Card(
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.01),
                                  Text('Personal Details',
                                      style: kHeading3Style),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Name',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .userAlt,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter Name'),
                                                        onChanged: (input) {
                                                          firstName = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Surname',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .userAlt,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter Surname'),
                                                        onChanged: (input) {
                                                          lastName = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.015,
                                              vertical: height * 0.001),
                                          child: Text('E-mail',
                                              style: kInputLabelStyle),
                                        ),
                                        Container(
                                            decoration: inputFieldDecoration,
                                            // height: height * 0.05,
                                            width: width * 0.9,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: height * 0.015,
                                                ),
                                                FaIcon(
                                                    FontAwesomeIcons
                                                        .solidEnvelope,
                                                    size: height * 0.02,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: height * 0.01,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    keyboardType: TextInputType
                                                        .emailAddress,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Enter E-mail Id'),
                                                    onChanged: (input) {
                                                      email = input;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(height: height * 0.01),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.015,
                                              vertical: height * 0.001
                                              ),
                                          child: Text(
                                              'Secondry Mobile Number (Optional)',
                                              style: kInputLabelStyle),
                                        ),
                                        Container(
                                            decoration: inputFieldDecoration,
                                            // height: height * 0.05,
                                            width: width * 0.9,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: height * 0.015,
                                                ),
                                                FaIcon(
                                                    FontAwesomeIcons.phoneAlt,
                                                    size: height * 0.02,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: height * 0.01,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Enter secondry mobile number'),
                                                    onChanged: (input) {
                                                      secmobile = input;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Gender',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .transgender,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          hint: Text(gender),
                                                          isExpanded: true,
                                                          items: [
                                                            'Male',
                                                            'Female'
                                                          ].map((String value) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (input) {
                                                            setState(() {
                                                              gender = input;
                                                            });
                                                            
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Date of Birth',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Container(
                                                  decoration:
                                                      inputFieldDecoration,
                                                  width: width * 0.42,
                                                  child: SizedBox(
                                                    height: height * 0.05,
                                                    child: DateTimePicker(
                                                      decoration:
                                                          InputDecoration(
                                                              icon: Padding(
                                                                padding: EdgeInsets.only(
                                                                    left: width *
                                                                        0.032),
                                                                child: FaIcon(
                                                                  FontAwesomeIcons
                                                                      .calendarAlt,
                                                                  color: Colors
                                                                      .white,
                                                                ),
                                                              ),
                                                              border:
                                                                  InputBorder
                                                                      .none,
                                                              focusedBorder:
                                                                  InputBorder
                                                                      .none,
                                                              enabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              errorBorder:
                                                                  InputBorder
                                                                      .none,
                                                              disabledBorder:
                                                                  InputBorder
                                                                      .none,
                                                              hintText:
                                                                  "dd/mm/yyyy"),
                                                      initialValue: '',
                                                      firstDate: DateTime(1950),
                                                      lastDate: DateTime(2100),
                                                      onChanged: (val) {
                                                        dob = val;
                                                      },
                                                      validator: (val) {
                                                        print(val);
                                                        return null;
                                                      },
                                                      onSaved: (val) =>
                                                          print(val),
                                                    ),
                                                  ),
                                                ))
                                          ]),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Blood Group',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons.tint,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          hint: Text(bloodGroup),
                                                          isExpanded: true,
                                                          items: [
                                                            'A+',
                                                            'A-',
                                                            'B+',
                                                            'B-',
                                                            'O+',
                                                            'O-',
                                                            'AB+',
                                                            'AB-'
                                                          ].map((String value) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (input) {
                                                            setState(() {
                                                              bloodGroup = input;
                                                            });
                                                            
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Chronic Disease',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .disease,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child:
                                                          DropdownButtonHideUnderline(
                                                        child: DropdownButton<
                                                            String>(
                                                          hint: Text(disease),
                                                          isExpanded: true,
                                                          items: [
                                                            'None',
                                                            'Asthama',
                                                            'Blood Pressure',
                                                            'Cancer',
                                                            'Cholestrol',
                                                            'Chronic Obstructive Pulmonary Disease (COPD)'
                                                            'Diabetes',
                                                            'Heart Diseases',
                                                            'PCOD',
                                                            'TB'
                                                          ].map((String value) {
                                                            return new DropdownMenuItem<
                                                                String>(
                                                              value: value,
                                                              child:
                                                                  Text(value),
                                                            );
                                                          }).toList(),
                                                          onChanged: (input) {
                                                            setState(() {
                                                              disease = input;
                                                            });
                                                            
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.015,
                                              vertical: height * 0.001),
                                          child: Text('Adhaar Card Number',
                                              style: kInputLabelStyle),
                                        ),
                                        Container(
                                            decoration: inputFieldDecoration,
                                            // height: height * 0.05,
                                            width: width * 0.9,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: height * 0.015,
                                                ),
                                                FaIcon(
                                                    FontAwesomeIcons
                                                        .solidAddressCard,
                                                    size: height * 0.02,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: height * 0.01,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'XXXX-XXXX-XXXX'),
                                                    onChanged: (input) {
                                                      adhaar = input;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            )),
                                        SizedBox(height: height * 0.01),
                                      ]),
                                ],
                              ),
                              elevation: 1,
                            ),
                            SizedBox(height: height * 0.01),
                            Card(
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.01),
                                  Text('Address', style: kHeading3Style),
                                  SizedBox(height: height * 0.01),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.015,
                                              vertical: height * 0.001),
                                          child: Text(
                                              'Address - House Number / Street',
                                              style: kInputLabelStyle),
                                        ),
                                        Container(
                                            decoration: inputFieldDecoration,
                                            // height: height * 0.05,
                                            width: width * 0.9,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: height * 0.015,
                                                ),
                                                FaIcon(
                                                    FontAwesomeIcons
                                                        .solidBuilding,
                                                    size: height * 0.02,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: height * 0.01,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'House Number/ Street'),
                                                    onChanged: (input) {
                                                      address = input;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Locality',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .mapMarkerAlt,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter Locality'),
                                                        onChanged: (input) {
                                                          locality = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('District/City',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .mapMarkedAlt,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter City'),
                                                        onChanged: (input) {
                                                          city = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('State',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .mapMarkedAlt,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration:
                                                            InputDecoration(
                                                                border:
                                                                    InputBorder
                                                                        .none,
                                                                hintText:
                                                                    'Enter State'),
                                                        onChanged: (input) {
                                                          state = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Pin Code',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons.mapPin,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Enter Pincode'),
                                                        onChanged: (input) {
                                                          pincode = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Card(
                              elevation: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  SizedBox(height: height * 0.01),
                                  Center(
                                      child: Text('Qualifications',
                                          style: kHeading3Style)),
                                  SizedBox(height: height * 0.01),
                                  Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * 0.015,
                                                vertical: height * 0.001),
                                            child: Text('Highest Qualification',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                              decoration: inputFieldDecoration,
                                              // height: height * 0.05,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: height * 0.015,
                                                  ),
                                                  FaIcon(
                                                      FontAwesomeIcons
                                                          .userGraduate,
                                                      size: height * 0.02,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: height * 0.01,
                                                  ),
                                                  Expanded(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        hint: Text(highestQualification),
                                                        isExpanded: true,
                                                        items: qualifications
                                                            .map(
                                                                (String value) {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged: (input) {
                                                          setState(() {
                                                            highestQualification =input;
                                                          });
                                                          
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ]),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * 0.015,
                                                vertical: height * 0.001),
                                            child: Text(
                                                'Professional Career (Latest)',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                              decoration: inputFieldDecoration,
                                              // height: height * 0.05,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: height * 0.015,
                                                  ),
                                                  FaIcon(
                                                      FontAwesomeIcons
                                                          .briefcase,
                                                      size: height * 0.02,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: height * 0.01,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Enter Current or Last profession'),
                                                      onChanged: (input) {
                                                        professionalCareer =
                                                            input;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ]),
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Center(
                                    child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: height * 0.015,
                                                vertical: height * 0.001),
                                            child: Text(
                                                'Hobbies (Use , to seperate multiple Hobbies)',
                                                style: kInputLabelStyle),
                                          ),
                                          Container(
                                              decoration: inputFieldDecoration,
                                              // height: height * 0.05,
                                              width: width * 0.9,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: height * 0.015,
                                                  ),
                                                  FaIcon(FontAwesomeIcons.magic,
                                                      size: height * 0.02,
                                                      color: Colors.white),
                                                  SizedBox(
                                                    width: height * 0.01,
                                                  ),
                                                  Expanded(
                                                    child: TextField(
                                                      keyboardType:
                                                          TextInputType.text,
                                                      decoration: InputDecoration(
                                                          border:
                                                              InputBorder.none,
                                                          hintText:
                                                              'Enter Hobbies'),
                                                      onChanged: (input) {
                                                        hobbies = input;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              ))
                                        ]),
                                  ),
                                  SizedBox(height: height * 0.01),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Card(
                              child: Column(
                                children: [
                                  SizedBox(height: height * 0.01),
                                  Text('Emergency Contact',
                                      style: kHeading3Style),
                                  SizedBox(height: height * 0.01),
                                  Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: height * 0.015,
                                              vertical: height * 0.001),
                                          child: Text(
                                              'Emergency Contact Number',
                                              style: kInputLabelStyle),
                                        ),
                                        Container(
                                            decoration: inputFieldDecoration,
                                            // height: height * 0.05,
                                            width: width * 0.9,
                                            child: Row(
                                              children: [
                                                SizedBox(
                                                  width: height * 0.015,
                                                ),
                                                FaIcon(
                                                    FontAwesomeIcons.phoneAlt,
                                                    size: height * 0.02,
                                                    color: Colors.white),
                                                SizedBox(
                                                  width: height * 0.01,
                                                ),
                                                Expanded(
                                                  child: TextField(
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration(
                                                        border:
                                                            InputBorder.none,
                                                        hintText:
                                                            'Enter contact number'),
                                                    onChanged: (input) {
                                                      emergencyContact = input;
                                                    },
                                                  ),
                                                ),
                                              ],
                                            ))
                                      ]),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Full Name',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .userAlt,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                      child: TextField(
                                                        keyboardType:
                                                            TextInputType.text,
                                                        decoration: InputDecoration(
                                                            border: InputBorder
                                                                .none,
                                                            hintText:
                                                                'Name of person'),
                                                        onChanged: (input) {
                                                          emergencyName = input;
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ]),
                                      SizedBox(width: width * 0.05),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: height * 0.015,
                                                  vertical: height * 0.001),
                                              child: Text('Relationship',
                                                  style: kInputLabelStyle),
                                            ),
                                            Container(
                                                decoration:
                                                    inputFieldDecoration,
                                                // height: height * 0.05,
                                                width: width * 0.425,
                                                child: Row(
                                                  children: [
                                                    SizedBox(
                                                      width: height * 0.015,
                                                    ),
                                                    FaIcon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        size: height * 0.02,
                                                        color: Colors.white),
                                                    SizedBox(
                                                      width: height * 0.01,
                                                    ),
                                                    Expanded(
                                                    child:
                                                        DropdownButtonHideUnderline(
                                                      child: DropdownButton<
                                                          String>(
                                                        hint: Text(emergencyRelationship),
                                                        isExpanded: true,
                                                        items: ['Father','Mother','Brother','Sister','Spouse','Son','Daughter','Son-in-Law','Daughter-in-Law','Friend','Others']
                                                            .map(
                                                                (String value) {
                                                          return new DropdownMenuItem<
                                                              String>(
                                                            value: value,
                                                            child: Text(value),
                                                          );
                                                        }).toList(),
                                                        onChanged: (input) {
                                                          setState(() {
                                                            emergencyRelationship =input;
                                                          });
                                                          
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                    // Expanded(
                                                    //   child: TextField(
                                                    //     keyboardType:
                                                    //         TextInputType.text,
                                                    //     decoration: InputDecoration(
                                                    //         border: InputBorder
                                                    //             .none,
                                                    //         hintText:
                                                    //             'Enter relationship'),
                                                    //     onChanged: (input) {
                                                    //       emergencyRelationship =
                                                    //           input;
                                                    //     },
                                                    //   ),
                                                    // ),
                                                  ],
                                                ))
                                          ]),
                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                ],
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                            TextButton(
                              child: Container(
                                height: height * 0.035,
                                width: width * 0.9,
                                child: Center(
                                  child: Text(
                                    "CONTINUE",
                                    style: kButtonText,
                                  ),
                                ),
                              ),
                              onPressed: () {
                                saveUser();
                              },
                              style: ButtonStyle(
                                foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.white),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                shape: MaterialStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: height * 0.05),
                          ]),
                    )),
                getNavigationButton(context),
              ],
            )
          ],
        ),
      ),
    );
  }

  String uid;
  getUserId() {
    final _auth = FirebaseAuth.instance;
    final User user = _auth.currentUser;
    uid = user.uid;
    primarymobile = user.phoneNumber;
    if (uid != null) {
      print(uid);
    } else {
      snackBar('Something went wrong. Please sign in again!!');
      Navigator.pop(context);
    }
  }

  uploadFile() async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child("$uid/profilePic");
    ref.putFile(profilePic).then((data) => {
          data.ref.getDownloadURL().then((url) {
            user['profilePic'] = url.toString();
          }).catchError((onError) {
            snackBar('Unable to upload Profile Pic');
          })
        });
  }

  saveUser() {
    if (firstName == null) {
      snackBar('Please Enter First Name correctly');
    }else if(user['profilePic']==null || user['profilePic']==''){
      snackBar('Please upload a profile Pic');
    }else if (lastName == null) {
      snackBar('Please Enter Surname correctly');
    } else if (email == null) {
      snackBar('Please Enter E-mail correctly');
    } else if (gender == null) {
      snackBar('Please Enter gender correctly');
    } else if (dob == null) {
      snackBar('Please Enter Date of Birth correctly');
    }else if (bloodGroup == null) {
      snackBar('Please Enter Blood Group correctly');
    } else if (disease == null) {
      snackBar('Please Enter Disease correctly');
    } else if (adhaar == null || adhaar.length!=12) {
      snackBar('Please Enter Adhaar Number correctly');
    } else if (address == null) {
      snackBar('Please Enter Address correctly');
    } else if (locality == null) {
      snackBar('Please Enter Locality correctly');
    } else if (city == null) {
      snackBar('Please Enter City correctly');
    } else if (state == null) {
      snackBar('Please Enter State correctly');
    } else if (pincode == null) {
      snackBar('Please Enter Pincode correctly');
    } else if (highestQualification == null) {
      snackBar('Please Enter Highest Qualification correctly');
    } else if (professionalCareer == null) {
      snackBar('Please Enter Professional Career correctly');
    } else if (hobbies == null) {
      snackBar('Please Enter Hobbies correctly');
    } else if (emergencyContact == null) {
      snackBar('Please Enter Emergency Contact correctly');
    } else if (emergencyName == null) {
      snackBar('Please Enter Emargency Contact Name correctly');
    } else if (emergencyRelationship == null) {
      snackBar('Please Enter Emergency Contact Relationship correctly');
    } else {
      if(gender=='Male'){
        user['firstName'] = 'Mr. '+firstName;
      }
      else if(gender=='Female'){
        user['firstName'] = 'Ms. '+firstName;
      }
      user['lastName'] = lastName;
      user['email'] = email;
      user['mobile'] = [primarymobile, '+91'+secmobile];
      user['gender'] = gender;
      user['dob'] = dob;
      user['bloodGrp'] = bloodGroup;
      user['disease'] = disease;
      user['adhaar'] = adhaar;
      user['address'] = address;
      user['locality'] = locality;
      user['city'] = city;
      user['state'] = state;
      user['pinCode'] = pincode;
      user['highestQualification'] = highestQualification;
      user['professionalCareer'] = professionalCareer;
      user['hobbies'] = hobbies;
      user['emergencyContact'] = emergencyContact;
      user['emergencyName'] = emergencyName;
      user['emergencyRelation'] = emergencyRelationship;
      print(user);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  SkillAddPage(termsAndConditions: false, userData: user)));
    }
  }
}
