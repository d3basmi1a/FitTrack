// lib/widgets/exercise_input_widget.dart

import 'package:flutter/material.dart';

class ExerciseInputWidget extends StatefulWidget {
  final Function(String name, int sets, int reps) onAddExercise;

  ExerciseInputWidget({required this.onAddExercise});

  @override
  _ExerciseInputWidgetState createState() => _ExerciseInputWidgetState();
}

class _ExerciseInputWidgetState extends State<ExerciseInputWidget> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _setsController = TextEditingController();
  TextEditingController _repsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Exercise Name'),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: _setsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Sets'),
        ),
        SizedBox(height: 8.0),
        TextField(
          controller: _repsController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(labelText: 'Reps'),
        ),
        SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            String name = _nameController.text;
            int sets = int.parse(_setsController.text);
            int reps = int.parse(_repsController.text);
            widget.onAddExercise(name, sets, reps);
            _nameController.clear();
            _setsController.clear();
            _repsController.clear();
          },
          child: Text('Add Exercise'),
        ),
      ],
    );
  }
}
