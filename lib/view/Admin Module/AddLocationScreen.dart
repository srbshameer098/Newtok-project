import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:newtok/view/Authentication/Login/Login.dart';


import '../BottomNavBar.dart';

class Addlocationscreen extends StatefulWidget {
  const Addlocationscreen({super.key});

  @override
  State<Addlocationscreen> createState() => _AddlocationscreenState();
}

class _AddlocationscreenState extends State<Addlocationscreen> {
  final TextEditingController _countryController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
  final TextEditingController _districtController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Location')),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Country',
                  style: TextStyle(
                    color: Color(0xFF0C141C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: 358,
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE8EDF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _countryController,
                        decoration: InputDecoration(border: InputBorder.none),
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                      ),
                    )),
              ),
              const Text('State',
                  style: TextStyle(
                    color: Color(0xFF0C141C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: 358,
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE8EDF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _stateController,
                        decoration: InputDecoration(border: InputBorder.none),
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                      ),
                    )),
              ),
              const Text('District',
                  style: TextStyle(
                    color: Color(0xFF0C141C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: 358,
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE8EDF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _districtController,
                        decoration: InputDecoration(border: InputBorder.none),
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                      ),
                    )),
              ),
              const Text('City',
                  style: TextStyle(
                    color: Color(0xFF0C141C),
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w500,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                    width: 358,
                    height: 56,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFFE8EDF2),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: _cityController,
                        decoration: InputDecoration(border: InputBorder.none),
                        textCapitalization: TextCapitalization.characters,
                        keyboardType: TextInputType.text,
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 250),
                child: GestureDetector(
                  onTap: _addLocation,
                  child: Container(
                    width: 358,
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    clipBehavior: Clip.antiAlias,
                    decoration: ShapeDecoration(
                      color: Color(0xFF197FE5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Add Location',
                        style: TextStyle(
                          color: Color(0xFFFFFFFF),
                          fontSize: 16,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: FooterWidget(userRole: comment),
    );
  }

  Future<void> _addLocation() async {
    final String country = _countryController.text.trim();
    final String state = _stateController.text.trim();
    final String district = _districtController.text.trim();
    final String city = _cityController.text.trim();


    if (country.isEmpty || state.isEmpty || district.isEmpty || city.isEmpty) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }


    final Map<String, String> locationData = {
      'country': country,
      'state': state,
      'district': district,
      'city': city,
    };


    try {
      await FirebaseFirestore.instance.collection('data').add(locationData);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Location added successfully')),
      );
      // Optionally, clear the text fields
      _countryController.clear();
      _stateController.clear();
      _districtController.clear();
      _cityController.clear();
    } catch (e) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add location: $e')),
      );
    }
  }
}
