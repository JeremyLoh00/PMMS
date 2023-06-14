import 'package:flutter/material.dart';

class MultiSelectPatient extends StatefulWidget {
  final List<String> patientList;
  const MultiSelectPatient({super.key, required this.patientList});

  @override
  State<MultiSelectPatient> createState() => _MultiSelectPatientState();
}

class _MultiSelectPatientState extends State<MultiSelectPatient> {
  final List<String> _selectedPatient = [];

  void _patientChange(String patientValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedPatient.add(patientValue);
      } else {
        _selectedPatient.remove(patientValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedPatient);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Topics"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.patientList
              .map(
                (patient) => CheckboxListTile(
                  value: _selectedPatient.contains(patient),
                  title: Text(patient),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) => _patientChange(patient, isChecked!),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}

class MultiSelectMedical extends StatefulWidget {
  final List<String> medicalList;
  const MultiSelectMedical({super.key, required this.medicalList});

  @override
  State<MultiSelectMedical> createState() => _MultiSelectMedicalState();
}

class _MultiSelectMedicalState extends State<MultiSelectMedical> {
  final List<String> _selectedMedical = [];

  void _medicalChange(String medicalValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedMedical.add(medicalValue);
      } else {
        _selectedMedical.remove(medicalValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedMedical);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Topics"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.medicalList
              .map(
                (medical) => CheckboxListTile(
                  value: _selectedMedical.contains(medical),
                  title: Text(medical),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) => _medicalChange(medical, isChecked!),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}

class MultiSelectCondition extends StatefulWidget {
  final List<String> conditionList;
  const MultiSelectCondition({super.key, required this.conditionList});

  @override
  State<MultiSelectCondition> createState() => _MultiSelectConditionState();
}

class _MultiSelectConditionState extends State<MultiSelectCondition> {
  final List<String> _selectedCondition = [];

  void _conditionChange(String conditionValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedCondition.add(conditionValue);
      } else {
        _selectedCondition.remove(conditionValue);
      }
    });
  }

  void _cancel() {
    Navigator.pop(context);
  }

  void _submit() {
    Navigator.pop(context, _selectedCondition);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Select Topics"),
      content: SingleChildScrollView(
        child: ListBody(
          children: widget.conditionList
              .map(
                (condition) => CheckboxListTile(
                  value: _selectedCondition.contains(condition),
                  title: Text(condition),
                  controlAffinity: ListTileControlAffinity.leading,
                  onChanged: (isChecked) =>
                      _conditionChange(condition, isChecked!),
                ),
              )
              .toList(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _cancel,
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submit,
          child: Text('Confirm'),
        ),
      ],
    );
  }
}
