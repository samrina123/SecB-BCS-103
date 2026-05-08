import 'package:flutter/material.dart';
import '../models/submission.dart';
import '../services/submission_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SubmissionFormScreen extends StatefulWidget {
  const SubmissionFormScreen({super.key, this.submission});

  final Submission? submission;

  @override
  State<SubmissionFormScreen> createState() => _SubmissionFormScreenState();
}

class _SubmissionFormScreenState extends State<SubmissionFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String _gender = 'Male';
  bool _isLoading = false;

  late final SubmissionService _submissionService;

  @override
  void initState() {
    super.initState();
    _submissionService = SubmissionService(Supabase.instance.client);
    
    if (widget.submission != null) {
      _fullNameController.text = widget.submission!.fullName;
      _emailController.text = widget.submission!.email;
      _phoneController.text = widget.submission!.phoneNumber;
      _addressController.text = widget.submission!.address;
      _gender = widget.submission!.gender;
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final submission = Submission(
      id: widget.submission?.id,
      fullName: _fullNameController.text,
      email: _emailController.text,
      phoneNumber: _phoneController.text,
      address: _addressController.text,
      gender: _gender,
    );

    try {
      if (widget.submission == null) {
        await _submissionService.createSubmission(submission);
      } else {
        await _submissionService.updateSubmission(submission);
      }
      if (mounted) {
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.submission == null ? 'Submission Created' : 'Submission Updated')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.submission == null ? 'New Submission' : 'Edit Submission'),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _fullNameController,
                      decoration: const InputDecoration(labelText: 'Full Name', border: OutlineInputBorder()),
                      validator: (value) => value == null || value.isEmpty ? 'Please enter full name' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: 'Email', border: OutlineInputBorder()),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Please enter email';
                        if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) return 'Enter a valid email';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(labelText: 'Phone Number', border: OutlineInputBorder()),
                      keyboardType: TextInputType.phone,
                      validator: (value) => value == null || value.isEmpty ? 'Please enter phone number' : null,
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _addressController,
                      decoration: const InputDecoration(labelText: 'Address', border: OutlineInputBorder()),
                      maxLines: 3,
                      validator: (value) => value == null || value.isEmpty ? 'Please enter address' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: _gender,
                      decoration: const InputDecoration(labelText: 'Gender', border: OutlineInputBorder()),
                      items: ['Male', 'Female', 'Other']
                          .map((g) => DropdownMenuItem(value: g, child: Text(g)))
                          .toList(),
                      onChanged: (value) => setState(() => _gender = value!),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: _submitForm,
                        child: Text(widget.submission == null ? 'Submit' : 'Update'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
