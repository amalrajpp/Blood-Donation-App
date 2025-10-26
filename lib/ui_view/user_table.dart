import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class FirestoreTable extends StatefulWidget {
  @override
  _FirestoreTableState createState() => _FirestoreTableState();
}

class _FirestoreTableState extends State<FirestoreTable> {
  String? searchQuery;
  String? selectedDistrict;
  String? selectedBloodGroup;
  RangeValues? weightRange = RangeValues(50, 100);

  void clearFilters() {
    setState(() {
      searchQuery = null;
      selectedDistrict = null;
      selectedBloodGroup = null;
      weightRange = RangeValues(50, 100); // Reset to default weight range
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('User Details'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Search field
                  TextField(
                    decoration: InputDecoration(
                      labelText: 'Search by Name',
                      hintText: 'Enter name...',
                      prefixIcon: Icon(Icons.search, color: Colors.red[900]),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    onChanged: (value) {
                      setState(() {
                        searchQuery = value.toLowerCase();
                      });
                    },
                  ),
                  SizedBox(height: 20),

                  // District filter
                  DropdownButtonFormField<String>(
                    value: selectedDistrict,
                    hint: Text('Filter by District'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    items: [
                      'Malapuram',
                      'Wayanad',
                      'Kannur',
                      'Kasaragod',
                      'Kozhikode'
                    ].map((district) {
                      return DropdownMenuItem(
                        value: district,
                        child: Text(district),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedDistrict = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),

                  // Blood group filter
                  DropdownButtonFormField<String>(
                    value: selectedBloodGroup,
                    hint: Text('Filter by Blood Group'),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor: Colors.grey.shade100,
                    ),
                    items: [
                      'A+',
                      'B+',
                      'O+',
                      'AB+',
                      'A-',
                      'B-',
                      'O-',
                      'AB-',
                    ].map((group) {
                      return DropdownMenuItem(
                        value: group,
                        child: Text(group),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedBloodGroup = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Weight Range:', style: TextStyle(fontSize: 16)),
                      SizedBox(height: 10),
                      SfRangeSlider(
                        min: 50.0,
                        max: 210.0,
                        values:
                            SfRangeValues(weightRange!.start, weightRange!.end),
                        interval: 20,
                        stepSize: 1,
                        showLabels: true,
                        showTicks: true,
                        activeColor: Colors.red[300],
                        inactiveColor: Colors.grey.shade300,
                        enableTooltip: true,
                        tooltipTextFormatterCallback:
                            (dynamic value, String formattedText) {
                          return '$formattedText kg';
                        },
                        onChanged: (SfRangeValues newValues) {
                          setState(() {
                            weightRange =
                                RangeValues(newValues.start, newValues.end);
                          });
                        },
                      ),
                      SizedBox(height: 10),
                    ],
                  ),

                  SizedBox(height: 20),

                  // Clear filters button
                  Align(
                    alignment: Alignment.centerRight,
                    child: OutlinedButton.icon(
                      onPressed: clearFilters,
                      icon: Icon(Icons.clear, color: Colors.black),
                      label: Text(
                        'Clear Filters',
                        style: TextStyle(color: Colors.black),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: Colors.black),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: StreamBuilder(
                  stream:
                      FirebaseFirestore.instance.collection('user').snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: CircularProgressIndicator());
                    }

                    var filteredDocs = snapshot.data!.docs.where((doc) {
                      final name = doc['name'].toString().toLowerCase();
                      final district = doc['district'].toString();
                      final bloodGroup = doc['group'].toString();
                      final weight =
                          double.tryParse(doc['weight'].toString()) ?? 0;

                      bool matchesSearchQuery =
                          searchQuery == null || name.contains(searchQuery!);
                      bool matchesDistrict = selectedDistrict == null ||
                          district == selectedDistrict;
                      bool matchesBloodGroup = selectedBloodGroup == null ||
                          bloodGroup == selectedBloodGroup;
                      bool matchesWeightRange = weightRange == null ||
                          (weight >= weightRange!.start &&
                              weight <= weightRange!.end);

                      return matchesSearchQuery &&
                          matchesDistrict &&
                          matchesBloodGroup &&
                          matchesWeightRange;
                    }).toList();

                    return DataTable(
                      sortColumnIndex: 0,
                      sortAscending: true,
                      border: TableBorder.all(
                        color: Colors.grey,
                        width: 1,
                      ),
                      headingRowColor:
                          MaterialStateProperty.all(Colors.red.shade600),
                      dataRowColor: MaterialStateProperty.resolveWith<Color?>(
                        (Set<MaterialState> states) {
                          if (states.contains(MaterialState.selected)) {
                            return Colors.blue.shade100;
                          }
                          return Colors.grey.shade50; // Alternating row color
                        },
                      ),
                      columns: const [
                        DataColumn(
                          label: Text(
                            'Name',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'District',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Gender',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Dob',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Weight',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Blood Group',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        DataColumn(
                          label: Text(
                            'Contact',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                      rows: filteredDocs.map((doc) {
                        return DataRow(
                          cells: [
                            DataCell(Text(doc['name'].toString())),
                            DataCell(Text(doc['district'].toString())),
                            DataCell(Text(doc['gender'].toString())),
                            DataCell(Text(doc['dob'].toString())),
                            DataCell(Text(doc['weight'].toString())),
                            DataCell(Text(doc['group'].toString())),
                            DataCell(Text(doc['phone'].toString())),
                          ],
                        );
                      }).toList(),
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
