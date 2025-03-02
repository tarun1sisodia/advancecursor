import 'package:flutter/material.dart';
import 'package:smart_attendance/core/widgets/custom_text_form_field.dart';
import 'package:smart_attendance/core/widgets/custom_snackbar.dart';

class StudentProfileScreen extends StatefulWidget {
  @override
  _StudentProfileScreenState createState() => _StudentProfileScreenState();
}

class _StudentProfileScreenState extends State<StudentProfileScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _courseController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Load user data here (mock data for now)
    _nameController.text = 'John Doe';
    _emailController.text = 'john.doe@example.com';
    _phoneController.text = '123-456-7890';
    _courseController.text = 'Computer Science';
  }

  void _saveProfile() {
    // Implement save functionality here
    showCustomSnackbar(context, 'Profile updated successfully!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Student Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                    'https://via.placeholder.com/150'), // Placeholder image
              ),
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _nameController,
              label: 'Name',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _emailController,
              label: 'Email',
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _phoneController,
              label: 'Phone Number',
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: _courseController,
              label: 'Course',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: _saveProfile,
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
