import 'package:flutter/material.dart';

void main() {
  runApp(const ConversionApp());
}

class ConversionApp extends StatelessWidget {
  const ConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ConverterHomePage(),
    );
  }
}

class ConverterHomePage extends StatefulWidget {
  const ConverterHomePage({super.key});

  @override
  State<ConverterHomePage> createState() => _ConverterHomePageState();
}

class _ConverterHomePageState extends State<ConverterHomePage> {
  // Selected conversion type
  String _selectedConversion = 'Distance (km to miles)';

  // Controller for input field
  final TextEditingController _inputController = TextEditingController();

  // Result of conversion
  String _result = '';

  // Conversion factors
  final Map<String, double> _conversionFactors = {
    'Distance (km to miles)': 0.621371,  // Metric to Imperial
    'Distance (miles to km)': 1.60934,   // Imperial to Metric
    'Weight (kg to lbs)': 2.20462,       // Metric to Imperial
    'Weight (lbs to kg)': 0.453592,      // Imperial to Metric
  };

  // Function to perform conversion
  void _convert() {
    // Parse input value
    double input = double.tryParse(_inputController.text) ?? 0.0;
    // Get conversion factor
    double factor = _conversionFactors[_selectedConversion] ?? 1.0;
    // Calculate result
    double output = input * factor;
    // Update state
    setState(() {
      _result = output.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Unit Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Dropdown for selecting conversion type
            DropdownButton<String>(
              value: _selectedConversion,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedConversion = newValue!;
                });
              },
              items: _conversionFactors.keys.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            // Input field for value
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Enter value to convert',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            // Convert button
            ElevatedButton(
              onPressed: _convert,
              child: const Text('Convert'),
            ),
            const SizedBox(height: 20),
            // Display result
            Text(
              'Converted Value: $_result',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}