import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:excel/excel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../bloc/weather_bloc.dart';
import '../BottomNavBar.dart';


class Uploadexcelscreen extends StatefulWidget {
  const Uploadexcelscreen({super.key});

  @override
  State<Uploadexcelscreen> createState() => _UploadexcelscreenState();
}

class _UploadexcelscreenState extends State<Uploadexcelscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Excel File')),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherblocLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is WeatherblocError) {
            return const Center(child: Text("ERROR"));
          }
          return ExcelUploadPage();
        },
      ),
      bottomNavigationBar: FooterWidget(userRole: 'user'), // Set the correct role
    );
  }
}

class ExcelUploadPage extends StatefulWidget {
  @override
  _ExcelUploadPageState createState() => _ExcelUploadPageState();
}

class _ExcelUploadPageState extends State<ExcelUploadPage> {
  String? fileName;
  String? filePath;
  List<List<String>> parsedData = [];

  Future<void> pickExcelFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );

    if (result != null) {
      setState(() {
        fileName = result.files.single.name;
        filePath = result.files.single.path;
      });
    }
  }

  Future<void> parseExcelFile(String path) async {
    try {
      var bytes = await File(path).readAsBytes();
      var excel = Excel.decodeBytes(bytes);
      Sheet sheet = excel.tables[excel.tables.keys.first]!;

      List<List<String>> tempData = [];

      for (var row in sheet.rows) {
        tempData.add([
          row[0]?.value.toString() ?? '',
          row[1]?.value.toString() ?? '',
          row[2]?.value.toString() ?? '',
          row[3]?.value.toString() ?? '',
        ]);
      }

      setState(() {
        parsedData = tempData;
      });

      final preferences = await SharedPreferences.getInstance();
      for (var row in tempData) {
        await preferences.setString('location_${row[3]}', row[3] ?? '');
      }
    } catch (e) {
      print("Failed to parse the Excel file: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Excel File',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.upload_file, size: 40, color: Colors.blue),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    fileName ?? 'No file selected',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
                ElevatedButton(
                  onPressed: pickExcelFile,
                  child: Text('Choose File'),
                ),
              ],
            ),
          ),
          SizedBox(height: 32),
          if (filePath != null)
            ElevatedButton(
              onPressed: () {
                parseExcelFile(filePath!);
              },
              child: Text('Upload File'),
            ),
          SizedBox(height: 32),
          Expanded(
            child: ListView.builder(
              itemCount: parsedData.length,
              itemBuilder: (context, index) {
                final row = parsedData[index];
                return ListTile(
                  title: Text(
                    '${row[0]}, ',
                    style: TextStyle(color: Colors.black),

                  ),
                  subtitle: Text('${row[1]}, ${row[2]}, ${row[3]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
