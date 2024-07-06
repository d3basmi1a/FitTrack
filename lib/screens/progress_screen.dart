import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/progress.dart';

class ProgressScreen extends StatefulWidget {
  final List<Progress> progressData = [
    Progress(date: DateTime(2024, 6, 1), value: 0.5),
    Progress(date: DateTime(2024, 6, 15), value: 0.7),
    Progress(date: DateTime(2024, 6, 30), value: 0.9),
  ];

  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  void _deleteProgress(int index) {
    setState(() {
      widget.progressData.removeAt(index);
    });
    // Here you would typically delete the progress from a database or storage
    // Replace with actual database or storage integration
    print('Deleted Progress at index $index');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress'),
      ),
      body: ListView.builder(
        itemCount: widget.progressData.length,
        itemBuilder: (context, index) {
          Progress progress = widget.progressData[index];
          return Card(
            elevation: 3,
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            child: ListTile(
              contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              title: Text(
                'Date: ${DateFormat('yyyy-MM-dd').format(progress.date)}',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Progress Value: ${progress.value.toStringAsFixed(2)}'),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // Show confirmation dialog (optional)
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Confirm Delete'),
                        content: Text('Are you sure you want to delete this progress entry?'),
                        actions: <Widget>[
                          TextButton(
                            child: Text('Cancel'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                          TextButton(
                            child: Text('Delete'),
                            onPressed: () {
                              _deleteProgress(index);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              onTap: () {
                // Add navigation or detailed view functionality here
                // Example: Navigator.push(...);
              },
            ),
          );
        },
      ),
    );
  }
}
