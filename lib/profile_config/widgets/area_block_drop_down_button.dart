import 'package:flutter/material.dart';

DropdownButtonFormField<String> areaBlockDropdown(String dropdownValue) {
  return DropdownButtonFormField<String>(
    value: dropdownValue,
    onChanged: (String? newValue) {
      dropdownValue = newValue!;
    },
    items: <String>['Option 1', 'Option 2', 'Option 3', 'Option 4']
        .map<DropdownMenuItem<String>>((String value) {
      return DropdownMenuItem<String>(
        value: value,
        child: Text(
          value,
          style: TextStyle(fontSize: 15),
        ),
      );
    }).toList(),
    decoration: InputDecoration(
      hintText: 'Select an option',
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.grey, // Define border color here
          width: 2.0, // Define border width here
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: BorderSide(
          color: Colors.blue, // Define focused border color here
          width: 2.0, // Define focused border width here
        ),
      ),
    ),
  );
}
