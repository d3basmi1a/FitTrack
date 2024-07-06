import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/exercise.dart';
import '../models/workout.dart';
import '../widgets/exercise_input_widget.dart';

class AddWorkoutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Workout'),
      ),
      body: SingleChildScrollView(
        child: AddWorkoutForm(),
      ),
    );
  }
}

class AddWorkoutForm extends StatefulWidget {
  @override
  _AddWorkoutFormState createState() => _AddWorkoutFormState();
}

class _AddWorkoutFormState extends State<AddWorkoutForm> {
  TextEditingController _nameController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  List<Exercise> _exercises = [];

  void _addExercise(String name, int sets, int reps) {
    Exercise exercise = Exercise(name: name, sets: sets, reps: reps);
    setState(() {
      _exercises.add(exercise);
    });
  }

  void _saveWorkout() {
    String workoutName = _nameController.text;
    Workout newWorkout =
        Workout(name: workoutName, date: _selectedDate, exercises: _exercises);
    // Placeholder for saving workout to database or storage
    // Replace with actual database or storage integration
    print('New Workout: $newWorkout');
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            controller: _nameController,
            decoration: InputDecoration(labelText: 'Workout Name'),
          ),
          SizedBox(height: 16.0),
          Text('Date: ${DateFormat('yyyy-MM-dd').format(_selectedDate)}'),
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
            child: Text('Select Date'),
          ),
          SizedBox(height: 16.0),
          Text('Exercises:'),
          SizedBox(height: 8.0),
          ExerciseInputWidget(onAddExercise: _addExercise),
          SizedBox(height: 16.0),
          ElevatedButton(
            onPressed: _saveWorkout,
            child: Text('Save Workout'),
          ),
        ],
      ),
    );
  }
}
