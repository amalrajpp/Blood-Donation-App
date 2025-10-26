// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:blood/fitness_app_home_screen.dart';
import 'package:choice/choice.dart';
import 'package:blood/ui_view/title_view.dart';
import 'package:blood/fitness_app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../api/create_request.dart';
import '../models/city.dart';
import 'custom_textfield.dart';
import 'dateField.dart';
import 'package:intl/intl.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({super.key});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  final nameController = TextEditingController();
  final dobController = TextEditingController();
  final lastDateController = TextEditingController();
  final weightController = TextEditingController();
  final numberController = TextEditingController();
  List<Widget> listViews = <Widget>[];

  double topBarOpacity = 0.0;
  List<String> districtList = [
    'Select donor district',
    'Malappuram',
    'Kozhikode',
    'Wayanad',
    'Kannur',
    'Kasaragod',
  ];
  List<String> cityList = ['Select donor city'];

  List<String> choices = ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-'];
  List<String> genders = ['Select gender', 'Male', 'Female', 'Others'];
  List<String> last = [
    'Last donation',
    'Lesser than 3 months',
    'Greater than 3 months',
  ];
  List<String> types = ['Plasma', 'Platelet'];
  String? lastDonation;
  String? selectedValue;
  String? gender;
  String? district;
  String? city;
  String? type;
  bool _switchValue = true;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  Widget addAllListData() {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: 50),
          TitleView(titleTxt: ' Donor Registration'),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: CustomTextField(
              controller: nameController,
              name: "Name",
              prefixIcon: Icons.person_outline,
              inputType: TextInputType.name,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30,
              top: 5,
              bottom: 5,
            ),
            child: CustomDropdown<String>.search(
              items: districtList,
              initialItem: districtList[0],
              onChanged: (value) {
                district = value;
                if (district == "Select donor district")
                  cityList = ["Select donor city"];
                else if (district == "Kannur")
                  cityList = Kannur;
                else if (district == "Kasaragod")
                  cityList = Kasaragod;
                else if (district == "Kozhikode")
                  cityList = Kozhikode;
                else if (district == "Malappuram")
                  cityList = Malappuram;
                else if (district == "Wayanad")
                  cityList = Wayanad;
                setState(() {
                  city = "Select donor city";
                });
                print('changing value to: $value');
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(
              left: 30.0,
              right: 30,
              top: 5,
              bottom: 5,
            ),
            child: CustomDropdown<String>.search(
              items: cityList,
              initialItem: cityList[0],
              onChanged: (value) {
                city = value;
                print('changing value to: $value');
              },
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
            child: Container(
              decoration: BoxDecoration(
                color: FitnessAppTheme.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topRight: Radius.circular(60.0),
                ),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: FitnessAppTheme.grey.withOpacity(0.2),
                    offset: const Offset(1.1, 1.1),
                    blurRadius: 10.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, left: 15),
                    child: Text(
                      'Blood group',
                      style: TextStyle(
                        fontFamily: FitnessAppTheme.fontName,
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: FitnessAppTheme.grey.withOpacity(0.5),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: InlineChoice<String>.single(
                      clearable: true,
                      value: selectedValue,
                      onChanged: setSelectedValue,
                      itemCount: choices.length,
                      itemBuilder: (state, i) {
                        return ChoiceChip(
                          selectedColor: Colors.red[100],
                          backgroundColor: Colors.red[50],
                          checkmarkColor: const Color.fromARGB(
                            255,
                            133,
                            16,
                            16,
                          ),
                          selected: state.selected(choices[i]),
                          onSelected: state.onSelected(choices[i]),
                          label: Text(choices[i]),
                        );
                      },
                      listBuilder: ChoiceList.createWrapped(
                        spacing: 10,
                        runSpacing: 10,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 25,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: CustomDropdown<String>(
              hintText: 'Select gender',
              items: genders,
              initialItem: genders[0],
              onChanged: (value) {
                gender = value!;
                print('changing value to: $value');
              },
            ),
          ),
          SizedBox(height: 23),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 5,
                child: GestureDetector(
                  onTap: () async {
                    await showCupertinoModalPopup<void>(
                      context: context,
                      builder: (_) {
                        final size = MediaQuery.of(context).size;
                        return Container(
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                          ),
                          height: size.height * 0.27,
                          child: CupertinoDatePicker(
                            mode: CupertinoDatePickerMode.date,
                            onDateTimeChanged: (value) {
                              setState(() {
                                dobController.text = DateFormat(
                                  'dd-MM-yyyy',
                                ).format(value).toString();
                              });
                            },
                          ),
                        );
                      },
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 8.0),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 15),
                      child: TextField(
                        controller: dobController,
                        enabled: false,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefixIcon: Icon(Icons.calendar_month),
                          isDense: true,
                          labelText: "Date of birth",
                          counterText: "",
                          labelStyle: const TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Flexible(
                flex: 4,
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 30),
                  child: CustomTextField(
                    controller: weightController,
                    name: "Weight",
                    prefixIcon: Icons.width_full_rounded,
                    inputType: TextInputType.number,
                    textCapitalization: TextCapitalization.words,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: CustomTextField(
              controller: numberController,
              name: "Phone number",
              prefixIcon: Icons.contact_page,
              inputType: TextInputType.number,
              textCapitalization: TextCapitalization.words,
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: CustomDropdown<String>(
              hintText: 'Last donation',
              items: last,
              initialItem: last[0],
              onChanged: (value) {
                setState(() {});
                lastDonation = value!;
                print('changing value to: $value');
              },
            ),
          ),
          SizedBox(height: 20),
          lastDonation == 'Lesser than 3 months'
              ? Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          flex: 5,
                          child: GestureDetector(
                            onTap: () async {
                              await showCupertinoModalPopup<void>(
                                context: context,
                                builder: (_) {
                                  final size = MediaQuery.of(context).size;
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(12),
                                        topRight: Radius.circular(12),
                                      ),
                                    ),
                                    height: size.height * 0.27,
                                    child: CupertinoDatePicker(
                                      mode: CupertinoDatePickerMode.date,
                                      onDateTimeChanged: (value) {
                                        setState(() {
                                          lastDateController.text = DateFormat(
                                            'dd-MM-yyyy',
                                          ).format(value).toString();
                                        });
                                      },
                                    ),
                                  );
                                },
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                left: 30,
                                right: 8.0,
                              ),
                              child: Container(
                                margin: const EdgeInsets.only(bottom: 15),
                                child: TextField(
                                  controller: lastDateController,
                                  enabled: false,
                                  textAlign: TextAlign.start,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    prefixIcon: Icon(Icons.calendar_month),
                                    isDense: true,
                                    labelText: "Donation date",
                                    counterText: "",
                                    labelStyle: const TextStyle(
                                      color: Colors.grey,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: const BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsets.only(
                              left: 8.0,
                              right: 30,
                            ),
                            child: Container(
                              height: 50,
                              margin: const EdgeInsets.only(bottom: 15),
                              child: CustomDropdown<String>(
                                //hintText: 'Type',
                                items: types,
                                initialItem: types[0],
                                onChanged: (value) {
                                  type = value!;
                                  print('changing value to: $value');
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                  ],
                )
              : SizedBox(height: 15),
          Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: GestureDetector(
              onTap: () async {
                String msg = "";
                if (nameController.text == "")
                  msg = "Please enter name";
                else if (district == null ||
                    district == 'Select donor district')
                  msg = "Please select district";
                else if (city == null || city == 'Select donor city')
                  msg = "Please select city";
                else if (selectedValue == null)
                  msg = "Please select blood group";
                else if (gender == null || gender == 'Select gender')
                  msg = "Please select gender";
                else if (dobController.text == "")
                  msg = "Please enter date of birth";
                else if (weightController.text == "" ||
                    int.parse(weightController.text) == 0)
                  msg = "Please enter weight";
                else if (numberController.text == "")
                  msg = "Please enter phone number";
                else if (numberController.text.length != 10)
                  msg = "Please enter valid phone number";
                else if (lastDonation == null ||
                    lastDonation == 'Last donation')
                  msg = "Please select last donation";
                else if (lastDonation == 'Lesser than 3 months') {
                  if (lastDateController.text == "")
                    msg = "Please select last donation date";
                }
                if (msg != "") {
                  showTopSnackBar(
                    Overlay.of(context),
                    CustomSnackBar.error(
                      backgroundColor: Colors.red[800]!,
                      message: msg,
                    ),
                  );
                  return;
                }
                msg = "";
                await registerUser(
                  nameController.text,
                  district!,
                  city!,
                  selectedValue!,
                  gender!,
                  dobController.text,
                  weightController.text,
                  numberController.text,
                  lastDonation!,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const FitnessAppHomeScreen(),
                  ),
                );
              },
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.red[900],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                    topRight: Radius.circular(8.0),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: FitnessAppTheme.grey.withOpacity(0.2),
                      offset: const Offset(1.1, 1.1),
                      blurRadius: 10.0,
                    ),
                  ],
                ),
                child: const Center(
                  child: Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 25),
        ],
      ),
    );
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: FitnessAppTheme.background.withOpacity(0.6),
            offset: const Offset(1.1, 4.0),
            blurRadius: 8.0,
          ),
        ],
        gradient: const LinearGradient(
          colors: [FitnessAppTheme.background, FitnessAppTheme.background],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      //color: FitnessAppTheme.background,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: <Widget>[
            addAllListData(),
            SizedBox(height: MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}
