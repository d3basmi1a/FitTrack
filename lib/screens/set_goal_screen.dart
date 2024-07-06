import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/goal.dart'; // Replace with your Goal model import
// Import for goal service or repository for fetching and saving goals

class SetGoalScreen extends StatefulWidget {
  final Goal? existingGoal; // Optionally pass existing goal for editing

  SetGoalScreen({this.existingGoal});

  @override
  _SetGoalScreenState createState() => _SetGoalScreenState();
}

class _SetGoalScreenState extends State<SetGoalScreen> {
  late TextEditingController _titleController;
  late DateTime _selectedDate;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    if (widget.existingGoal != null) {
      // If there's an existing goal, populate the fields with its data
      _titleController = TextEditingController(text: widget.existingGoal!.title);
      _selectedDate = widget.existingGoal!.deadline;
      _descriptionController = TextEditingController(text: widget.existingGoal!.description);
    } else {
      // If no existing goal, initialize fields with default values
      _titleController = TextEditingController();
      _selectedDate = DateTime.now();
      _descriptionController = TextEditingController();
    }
  }

  void _saveGoal() {
    String title = _titleController.text;
    DateTime deadline = _selectedDate;
    String description = _descriptionController.text;
    Goal updatedGoal = Goal(title: title, deadline: deadline, description: description);

    // Here you would typically save 'updatedGoal' to a database or storage
    // For static example, you can print or display it
    print('Updated Goal: $updatedGoal');
    
    // Example of navigating back to previous screen
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.existingGoal == null ? 'Set Goal' : 'Edit Goal'),
      ),
      body: Padding(
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
              child: Text(widget.existingGoal == null ? 'Set Goal' : 'Update Goal'),
            ),
          ],
        ),
      ),
    );
  }
}
