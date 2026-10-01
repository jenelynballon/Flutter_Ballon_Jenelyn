import 'package:flutter/material.dart';

void main() {
  runApp(const StudentProfileApp());
}

class StudentProfileApp extends StatelessWidget {
  const StudentProfileApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student Profile Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const StudentProfilePage(),
    );
  }
}

class StudentProfilePage extends StatefulWidget {
  const StudentProfilePage({super.key});

  @override
  State<StudentProfilePage> createState() => _StudentProfilePageState();
}

class _StudentProfilePageState extends State<StudentProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController fullNameController =
      TextEditingController();

  final TextEditingController ageController =
      TextEditingController();

  final TextEditingController addressController =
      TextEditingController();

  final TextEditingController contactController =
      TextEditingController();

  final TextEditingController emailController =
      TextEditingController();

  String? selectedGender;
  bool isSubmitted = false;

  void submitForm() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isSubmitted = true;
      });
    }
  }

  void clearForm() {
    fullNameController.clear();
    ageController.clear();
    addressController.clear();
    contactController.clear();
    emailController.clear();

    setState(() {
      selectedGender = null;
      isSubmitted = false;
    });
  }

  @override
  void dispose() {
    fullNameController.dispose();
    ageController.dispose();
    addressController.dispose();
    contactController.dispose();
    emailController.dispose();

    super.dispose();
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return '$label is required';
          }

          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student Profile Form'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Student Information',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // Full Name
              buildTextField(
                label: 'Full Name',
                controller: fullNameController,
              ),

              // Age
              buildTextField(
                label: 'Age',
                controller: ageController,
                keyboardType: TextInputType.number,
              ),

              // Gender
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: DropdownButtonFormField<String>(
                  initialValue: selectedGender,
                  decoration: const InputDecoration(
                    labelText: 'Gender',
                    border: OutlineInputBorder(),
                  ),
                  items: const [
                    DropdownMenuItem(
                      value: 'Male',
                      child: Text('Male'),
                    ),
                    DropdownMenuItem(
                      value: 'Female',
                      child: Text('Female'),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedGender = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Gender is required';
                    }

                    return null;
                  },
                ),
              ),

              // Address
              buildTextField(
                label: 'Address',
                controller: addressController,
              ),

              // Contact Number
              buildTextField(
                label: 'Contact Number',
                controller: contactController,
                keyboardType: TextInputType.phone,
              ),

              // Email
              buildTextField(
                label: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 5),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: submitForm,
                      child: const Text('Submit'),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: clearForm,
                      child: const Text('Clear'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              // Submitted information
              if (isSubmitted)
                Card(
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment:
                          CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Submitted Student Information',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          'Full Name: ${fullNameController.text}',
                        ),
                        Text(
                          'Age: ${ageController.text}',
                        ),
                        Text(
                          'Gender: $selectedGender',
                        ),
                        Text(
                          'Address: ${addressController.text}',
                        ),
                        Text(
                          'Contact Number: ${contactController.text}',
                        ),
                        Text(
                          'Email: ${emailController.text}',
                        ),
                      ],
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