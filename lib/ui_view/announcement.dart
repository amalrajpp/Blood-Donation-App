import 'package:flutter/material.dart';

class AnnouncementsScreen extends StatefulWidget {
  @override
  _AnnouncementsScreenState createState() => _AnnouncementsScreenState();
}

class _AnnouncementsScreenState extends State<AnnouncementsScreen> {
  final List<Map<String, String>> announcements = [
    {
      'title': 'Blood Donation Camp',
      'date': '2024-10-20',
      'description':
          'Join us for a blood donation camp at XYZ location. Your donation can save lives!'
    },
    {
      'title': 'New Donor Guidelines',
      'date': '2024-10-15',
      'description':
          'We have updated our donor guidelines. Please read the new guidelines before donating.'
    },
    // Add more announcements here
  ];

  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: announcements.length,
      itemBuilder: (context, index) {
        return Card(
          child: ExpansionTile(
            title: Text(announcements[index]['title']!),
            subtitle: Text(announcements[index]['date']!),
            onExpansionChanged: (expanded) {
              setState(() {
                _expandedIndex = expanded ? index : null;
              });
            },
            initiallyExpanded: _expandedIndex == index,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(announcements[index]['description']!),
              ),
            ],
          ),
        );
      },
    );
  }
}
