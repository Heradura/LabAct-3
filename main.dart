import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Sign-Up Form',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 49, 87, 118)),
        useMaterial3: true,
      ),
      home: const SignUpPage(),
    );
  }
}

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String? _selectedCourse;
  String? _selectedGender;

  double _notificationVolume = 50;

  DateTime? _birthdate;

  bool _agreedToTerms = false;

  Color _gestureBoxColor = Colors.green;
  String _gestureMessage = 'Tap the button';

  final List<String> _courses = [
    'BS Information Technology',
    'BS Computer Science',
    'BS Computer Engineering',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _selectBirthdate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
      helpText: 'Select your birthdate',
    );

    if (pickedDate != null) {
      setState(() {
        _birthdate = pickedDate;
      });
    }
  }

  String? _validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please fill up youre email address.';
    }

    final emailRegex = RegExp(
      r'^[\w\.-]+@[\w\.-]+\.\w+$',
    );
    if (!emailRegex.hasMatch(value.trim())) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  void _handleSignUp() {
    final isFormValid = _formKey.currentState!.validate();

    if (!_agreedToTerms) {
      setState(() {});
    }

    if (isFormValid && _agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('You are successfully Sign-Up!'),
          backgroundColor: Colors.blue,
        ),
      );
    } else if (!_agreedToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please agree to the Terms and Conditions.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _singleTap() {
    setState(() {
      _gestureBoxColor = Colors.green;
      _gestureMessage = ' Single Tap Detected!';
    });

    _handleSignUp();
  }

  void _doubleTap() {
    setState(() {
      _gestureBoxColor = Colors.orange;
      _gestureMessage = ' Double Tap Detected!';
    });
  }

  void _longPress() {
    setState(() {
      _gestureBoxColor = Colors.red;
      _gestureMessage = ' Long Press Detected!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign-Up Form'),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Create Your Account',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 8),

              const Text(
                'Please fill out all required information.',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey),
              ),

              const SizedBox(height: 25),

              // FULL NAME
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Full Name',
                  hintText: 'Enter your full name',
                  prefixIcon: Icon(Icons.person),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Full name cannot be empty.';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 16),

              // EMAIL
              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email Address',
                  hintText: 'example@email.com',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                validator: _validateEmail,
              ),

              const SizedBox(height: 16),

              // PASSWORD
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  hintText: 'At least 6 characters',
                  prefixIcon: Icon(Icons.lock),
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Password cannot be empty.';
                  }

                  if (value.length < 6) {
                    return 'Password must be at least 6 characters.';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 16),

              // DROPDOWN
              DropdownButtonFormField<String>(
                value: _selectedCourse,
                decoration: const InputDecoration(
                  labelText: 'Course',
                  prefixIcon: Icon(Icons.school),
                  border: OutlineInputBorder(),
                ),
                items: _courses.map((course) {
                  return DropdownMenuItem(
                    value: course,
                    child: Text(course),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value;
                  });
                },
              ),

              const SizedBox(height: 20),

              // RADIO
              const Text(
                'Gender',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              RadioListTile<String>(
                title: const Text('Male'),
                value: 'Male',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Female'),
                value: 'Female',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),

              RadioListTile<String>(
                title: const Text('Prefer not to say'),
                value: 'Prefer not to say',
                groupValue: _selectedGender,
                onChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),

              const SizedBox(height: 10),

              // SLIDER
              const Text(
                'Volume Notification',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              Row(
                children: [
                  const Icon(Icons.volume_down),
                  Expanded(
                    child: Slider(
                      value: _notificationVolume,
                      min: 0,
                      max: 100,
                      divisions: 10,
                      label: '${_notificationVolume.round()}%',
                      onChanged: (value) {
                        setState(() {
                          _notificationVolume = value;
                        });
                      },
                    ),
                  ),
                  const Icon(Icons.volume_up),
                ],
              ),

              Text(
                'Volume: ${_notificationVolume.round()}%',
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 20),

              // DATE PICKER
              OutlinedButton.icon(
                onPressed: _selectBirthdate,
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  _birthdate == null
                      ? 'Select Birthdate'
                      : 'Birthdate: '
                          '${_birthdate!.month}/'
                          '${_birthdate!.day}/'
                          '${_birthdate!.year}',
                ),
              ),

              const SizedBox(height: 15),

              // CHECKBOX
              CheckboxListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text(
                  'I agree to the Terms and Conditions.',
                ),
                value: _agreedToTerms,
                onChanged: (value) {
                  setState(() {
                    _agreedToTerms = value ?? false;
                  });
                },
                controlAffinity: ListTileControlAffinity.leading,
              ),

              if (!_agreedToTerms)
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'You must agree to the Terms and Conditions.',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12,
                    ),
                  ),
                ),

              const SizedBox(height: 25),

              // GESTURE DETECTOR
              GestureDetector(
                onTap: _singleTap,
                onDoubleTap: _doubleTap,
                onLongPress: _longPress,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 10,
                  ),
                  decoration: BoxDecoration(
                    color: _gestureBoxColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const Text(
                        'SIGN UP',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        _gestureMessage,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 15),

              const Text(
                'Tap once: Green • Double tap: Orange • Long press: Red',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
