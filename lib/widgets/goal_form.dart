// lib/widgets/goal_form.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class GoalForm extends StatefulWidget {
  @override
  _GoalFormState createState() => _GoalFormState();
}

class _GoalFormState extends State<GoalForm> {
  TextEditingController _titleController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TextEditingController _descriptionController = TextEditingController();

  void _saveGoal() {
    String title = _titleController.text;
    DateTime deadline = _selectedDate;
    String description = _descriptionController.text;
    // Here you would typically save the goal to a database or storage
    print('New Goal: Title - $title, Deadline - $deadline, Description - $description');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            controller: _titleController,
            decoration: InputDecoration(labelText: 'Goal Title'),
          ),
          SizedBox(height: 16.0),
          Text('Deadline: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
          ElevatedButton(
            onPressed: () async {
              final DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime(2100),
              );
              if (pickedDate != null && pickedDate != _selectedDate) {
                setState(() {
                  _selectedDate = pickedDate;
                });
              }
            },
            child: Text('Select Deadline'),
          ),
          SizedBox(height: 16.0),
          TextField(
            controller: _descriptionController,
            maxLines: 3,
            decoration: InputDecoration(labelText: 'Description'),
          ),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _saveGoal,
            child: Text('Set Goal'),
          ),
        ],
      ),
    );
  }
}
