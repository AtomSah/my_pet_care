import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pet_care/features/auth/presentation/view/register_view.dart';
import 'package:pet_care/features/auth/presentation/view_model/login/login_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final _loginFormKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _loginFormKey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Column(
            children: [
              // Header Section with Title
              const SizedBox(height: 30),
              const Text(
                "PET ME NOW",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Image.asset(
                  'assets/image/welcome-removebg.png',
                  height: 150,
                ),
              ),
              const SizedBox(height: 89),

              // Added Padding above Login Form Section
              Padding(
                padding:
                    const EdgeInsets.only(top: 40.0), // Adjusted padding here
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.blue[300]!, Colors.blue[700]!],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      const Text(
                        'Login',
                        style: TextStyle(
                          fontSize: 28.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 30),
                      // Email Field
                      TextFormField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: 'Email',
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          prefixIcon:
                              const Icon(Icons.email, color: Colors.white),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Email is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: const TextStyle(color: Colors.white70),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          prefixIcon:
                              const Icon(Icons.lock, color: Colors.white),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Password is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 15),

                      // Remember Me and Forgot Password Section
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  _rememberMe = value ?? false;
                                },
                                activeColor: Colors.white,
                              ),
                              const Text(
                                "Remember Me",
                                style: TextStyle(color: Colors.white70),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed("/forget-password");
                            },
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      // Login Button
                      ElevatedButton(
                        onPressed: () {
                          if (_loginFormKey.currentState!.validate()) {
                            context.read<LoginBloc>().add(
                                  LoginUserEvent(
                                    context: context,
                                    email: _usernameController.text,
                                    password: _passwordController.text,
                                  ),
                                );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 18.0),
                          backgroundColor: Colors.blue[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Sign-up Section
                      const Align(
                        alignment: Alignment.center,
                        child: Text(
                          "Don't have an account?",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white70),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            context.read<LoginBloc>().add(
                                  NavigateRegisterScreenEvent(
                                    context: context,
                                    destination: const RegistrationScreen(),
                                  ),
                                );
                          },
                          child: const Text(
                            "Sign up",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
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
