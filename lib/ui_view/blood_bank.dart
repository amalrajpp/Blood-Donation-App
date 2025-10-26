import 'package:flutter/material.dart';

class BloodBanksNearMeScreen extends StatelessWidget {
  final List<Map<String, String>> bloodBanks = [
    {
      'name': 'IMA Blood Bank',
      'address': 'Near Maharaja\'s Ground, Kochi, Kerala 682011',
      'phone': '0484 235 0522',
    },
    {
      'name': 'HDFC Bank Blood Bank',
      'address': 'MG Road, Kochi, Kerala 682016',
      'phone': '0484 238 1234',
    },
    {
      'name': 'Amrita Institute of Medical Sciences Blood Bank',
      'address': 'Ponekkara, Kochi, Kerala 682041',
      'phone': '0484 285 1234',
    },
    // Add more blood banks here
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: bloodBanks.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(bloodBanks[index]['name']!),
            subtitle: Text(bloodBanks[index]['address']!),
            trailing: IconButton(
              icon: Icon(Icons.phone),
              onPressed: () {
                // Add functionality to call the blood bank
              },
            ),
            onTap: () {
              // Add functionality to show more details
            },
          ),
        );
      },
    );
  }
}
