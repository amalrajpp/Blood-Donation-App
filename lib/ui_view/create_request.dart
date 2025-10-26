import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:choice/inline.dart';
import 'package:blood/fitness_app_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../api/create_request.dart';
import '../models/request_model.dart';
import 'custom_textfield.dart';
import 'dateField.dart';
import 'my_request_card.dart';
import 'shimmer.dart';
import 'tab_item.dart';
import 'package:intl/intl.dart';

class CreateRequestScreen extends StatefulWidget {
  const CreateRequestScreen({super.key, this.animationController});

  final AnimationController? animationController;
  @override
  _CreateRequestScreenState createState() => _CreateRequestScreenState();
}

class _CreateRequestScreenState extends State<CreateRequestScreen>
    with TickerProviderStateMixin {
  Animation<double>? topBarAnimation;
  List<Widget> listViews = <Widget>[];
  double topBarOpacity = 0.0;
  final pnameController = TextEditingController();
  final hnameController = TextEditingController();
  final numberController = TextEditingController();
  final dateController = TextEditingController();
  final unitController = TextEditingController();

  List<String> choices = ['A+', 'B+', 'O+', 'AB+', 'A-', 'B-', 'O-', 'AB-'];
  String? selectedValue;
  int tabIndex = 0;
  final ScrollController scrollController = ScrollController();
  final List<String> sectionItems = [
    'Malapuram',
    'Wayanad',
    'Kannur',
    'Kasaragod',
    'Kozhikode'
  ];
  final GlobalKey<FormFieldState> _key = GlobalKey<FormFieldState>();
  String? sectionValue;

  void setSelectedValue(String? value) {
    setState(() => selectedValue = value);
  }

  @override
  void initState() {
    super.initState();
  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 50));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: FitnessAppTheme.background,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Stack(
            children: <Widget>[
              getAppBarUI(),
              Column(
                children: [
                  const SizedBox(height: 155),
                  Expanded(
                    child: Container(
                        decoration: const BoxDecoration(
                          color: FitnessAppTheme.background,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: tabIndex == 0
                            ? SingleChildScrollView(
                                child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, right: 30, top: 18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    CustomTextField(
                                      controller: pnameController,
                                      name: "Patient name",
                                      prefixIcon: Icons.person_outline,
                                      inputType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                    const SizedBox(height: 6),
                                    CustomTextField(
                                      controller: hnameController,
                                      name: "Hospital name",
                                      prefixIcon: Icons.place_outlined,
                                      inputType: TextInputType.name,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: FitnessAppTheme.white,
                                        borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(10.0),
                                            bottomLeft: Radius.circular(10.0),
                                            bottomRight: Radius.circular(10.0),
                                            topRight: Radius.circular(60.0)),
                                        boxShadow: <BoxShadow>[
                                          BoxShadow(
                                              color: FitnessAppTheme.grey
                                                  .withOpacity(0.2),
                                              offset: const Offset(1.1, 1.1),
                                              blurRadius: 10.0),
                                        ],
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 15, left: 15),
                                            child: Text(
                                              'Blood group',
                                              style: TextStyle(
                                                fontFamily:
                                                    FitnessAppTheme.fontName,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.5),
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 5, right: 5),
                                            child: InlineChoice<String>.single(
                                              clearable: true,
                                              value: selectedValue,
                                              onChanged: setSelectedValue,
                                              itemCount: choices.length,
                                              itemBuilder: (state, i) {
                                                return ChoiceChip(
                                                  selectedColor:
                                                      Colors.red[100],
                                                  backgroundColor:
                                                      Colors.red[50],
                                                  checkmarkColor:
                                                      const Color.fromARGB(
                                                          255, 133, 16, 16),
                                                  selected: state
                                                      .selected(choices[i]),
                                                  onSelected: state
                                                      .onSelected(choices[i]),
                                                  label: Text(choices[i]),
                                                );
                                              },
                                              listBuilder:
                                                  ChoiceList.createWrapped(
                                                spacing: 10,
                                                runSpacing: 10,
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                  horizontal: 20,
                                                  vertical: 25,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(height: 18),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          flex: 5,
                                          child: DateField(
                                            controller: dateController,
                                            name: DateFormat('dd-MM-yyyy')
                                                .format(DateTime.now()),
                                            prefixIcon: Icons.calendar_month,
                                            inputType: TextInputType.datetime,
                                            textCapitalization:
                                                TextCapitalization.words,
                                          ),
                                        ),
                                        Flexible(
                                          flex: 4,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0, right: 8.0),
                                            child: CustomTextField(
                                              controller: unitController,
                                              name: "Unit",
                                              prefixIcon: Icons
                                                  .format_list_numbered_rounded,
                                              inputType: TextInputType.number,
                                              textCapitalization:
                                                  TextCapitalization.words,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 6),
                                    CustomTextField(
                                      controller: numberController,
                                      name: "Contact number",
                                      prefixIcon: Icons.contact_page,
                                      inputType: TextInputType.number,
                                      textCapitalization:
                                          TextCapitalization.words,
                                    ),
                                    DropdownButtonFormField2<String>(
                                      key: _key,
                                      isExpanded: true,
                                      barrierColor: Colors.transparent,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                            EdgeInsets.symmetric(vertical: 16),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: FitnessAppTheme.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        focusedBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: FitnessAppTheme.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: FitnessAppTheme.white),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      hint: const Text(
                                        'Select your region',
                                        style: TextStyle(
                                            color: Colors.grey, fontSize: 15),
                                      ),
                                      items: sectionItems
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                      onChanged: (value) {
                                        sectionValue = value.toString();
                                      },
                                      buttonStyleData: const ButtonStyleData(
                                        padding: EdgeInsets.only(right: 8),
                                      ),
                                      iconStyleData: const IconStyleData(
                                        icon: Icon(
                                          Icons.arrow_drop_down,
                                          color: Colors.grey,
                                        ),
                                        iconSize: 24,
                                      ),
                                      dropdownStyleData: DropdownStyleData(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                      ),
                                      menuItemStyleData:
                                          const MenuItemStyleData(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 16),
                                      ),
                                    ),
                                    const SizedBox(height: 20),
                                    GestureDetector(
                                      onTap: () async {
                                        String msg = "";
                                        if (pnameController.text == "")
                                          msg = "Please enter name";
                                        else if (hnameController.text == "")
                                          msg = "Please enter hospital name";
                                        else if (selectedValue == null)
                                          msg = "Please select blood group";
                                        else if (unitController.text == "" ||
                                            int.parse(unitController.text) == 0)
                                          msg = "Please enter number of units";
                                        else if (numberController.text == "")
                                          msg = "Please enter phone number";
                                        else if (sectionValue == null)
                                          msg = "Please select region";
                                        if (msg != "") {
                                          showTopSnackBar(
                                            Overlay.of(context),
                                            CustomSnackBar.error(
                                                backgroundColor:
                                                    Colors.red[800]!,
                                                message: msg),
                                          );
                                          return;
                                        }
                                        msg = "";

                                        await createRequest(
                                            pnameController.text,
                                            hnameController.text,
                                            unitController.text,
                                            numberController.text,
                                            selectedValue!,
                                            sectionValue!,
                                            DateTime.now());
                                        final snackBar = SnackBar(
                                          /// need to set following properties for best effect of awesome_snackbar_content
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          backgroundColor: Colors.transparent,
                                          content: AwesomeSnackbarContent(
                                            color: Colors.red[900],
                                            title: 'Requested',
                                            message:
                                                'Request created successfully .',
                                            contentType: ContentType.success,
                                          ),
                                        );

                                        ScaffoldMessenger.of(context)
                                          ..hideCurrentSnackBar()
                                          ..showSnackBar(snackBar);

                                        setState(() {
                                          pnameController.clear();
                                          hnameController.clear();
                                          unitController.clear();
                                          numberController.clear();
                                          selectedValue = null;
                                          sectionValue = null;
                                          _key.currentState!.reset();
                                          FocusManager.instance.primaryFocus
                                              ?.unfocus();
                                        });
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
                                              topRight: Radius.circular(8.0)),
                                          boxShadow: <BoxShadow>[
                                            BoxShadow(
                                                color: FitnessAppTheme.grey
                                                    .withOpacity(0.2),
                                                offset: const Offset(1.1, 1.1),
                                                blurRadius: 10.0),
                                          ],
                                        ),
                                        child: const Center(
                                          child: Text(
                                            "Request",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 17,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 85,
                                    )
                                  ],
                                ),
                              ))
                            : const GetMainListViewUI2()),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).padding.bottom,
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getAppBarUI() {
    return SizedBox(
      height: double.infinity,
      width: double.infinity,
      child: Align(
        alignment: Alignment.topLeft,
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/fitness_app/blood1.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          height: 170,
          child: Column(
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: const Text(
                  "Create Requests",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                automaticallyImplyLeading: false,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20.0, right: 20, top: 7),
                child: Container(
                  height: 40,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                    color: Colors.red.shade100,
                  ),
                  child: TabBar(
                    onTap: (value) {
                      setState(() {
                        tabIndex = value;
                      });
                    },
                    indicatorSize: TabBarIndicatorSize.tab,
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: Color(0xFFB71C1C),
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.black54,
                    tabs: const [
                      TabItem(title: 'Create Request', count: 0),
                      TabItem(title: 'My Requests', count: 0),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GetMainListViewUI2 extends StatefulWidget {
  const GetMainListViewUI2({super.key});

  @override
  State<GetMainListViewUI2> createState() => _GetMainListViewUI2State();
}

class _GetMainListViewUI2State extends State<GetMainListViewUI2> {
  final requestQuery = FirebaseFirestore.instance
      .collection('request')
      .where("uid", isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .orderBy("date", descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => Request.fromMap(snapshot.data()!),
        toFirestore: (request, _) => request.toMap(),
      );

  @override
  Widget build(BuildContext context) {
    return FirestoreListView<Request>(
      query: requestQuery,
      pageSize: 10,
      emptyBuilder: (context) => const Center(child: Text("No request")),
      errorBuilder: (context, error, stackTrace) => Text(error.toString()),
      loadingBuilder: (context) => ShimmerCard(),
      itemBuilder: (context, doc) {
        final request = doc.data();
        return MyRequestCard(
            pname: request.pname,
            hname: request.hname,
            date: request.date,
            contact: request.contact,
            group: request.group,
            unit: request.unit,
            requestId: request.requestId,
            status: request.status,
            acceptedId: request.acceptedUid,
            approval: request.approval);
      },
    );
  }
}
