import 'package:flutter/material.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({super.key});

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Padding(
            padding: EdgeInsets.only(left: 12),
            child: Icon(Icons.arrow_back_ios, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          'Update Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: const Color.fromRGBO(8, 10, 35, 1),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 52),
              const CircleAvatar(
                radius: 80,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/profile.png'),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: TextFormField(
                  style: const TextStyle(color: Color(0xFF080A23)),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: const Color.fromRGBO(38, 38, 66, 1),
                    labelText: 'Name',
                    labelStyle: const TextStyle(color: Colors.white),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: BorderSide.none,
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                      borderSide: const BorderSide(color: Color(0xFF080A23)),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 20),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: const EdgeInsets.all(8.0),
                height: 60,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 116, 177, 228),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Center(
                  child: Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
