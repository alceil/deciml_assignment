import 'package:deciml_assignment/cubit/auth/auth_cubit.dart';
import 'package:deciml_assignment/presentation/Dashboard/dashboard.dart';
import 'package:deciml_assignment/presentation/Home.dart';
import 'package:deciml_assignment/presentation/SignIn/sign_in.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _form = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
bool passwordVisible=true; 
  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    return Scaffold(
      body: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is Authenticated) {
                        ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("Authentication Succesfull")));
            // Navigating to the dashboard screen if the user is authenticated
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Home(),
              ),
            );
          }
          if (state is AuthError) {
            // Displaying the error message if the user is not authenticated
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          if (state is Loading) {
            // Displaying the loading indicator while the user is signing up
            return const Center(child: CircularProgressIndicator());
          }
          if (state is UnAuthenticated) {
            // Displaying the sign up form if the user is not authenticated

            return SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: const Text(
                        "Hello! Register to get started",
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  Form(
                    key: _form,
                    child:Column(
                    children: [
                       Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8F9),
                        border: Border.all(
                          color: const Color(0xFFE8ECF4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Name',
                            hintStyle: TextStyle(
                              color: Color(0xFF8391A1),
                            ),
                          ),
                          validator: (value)=>value!.isEmpty
                                  ? "Enter valid Name"
                                  : null,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //email
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8F9),
                        border: Border.all(
                          color: const Color(0xFFE8ECF4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                            hintStyle: TextStyle(
                              color: Color(0xFF8391A1),
                            ),
                          ),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            return value != null &&
                                    !EmailValidator.validate(value)
                                ? 'Enter a valid email'
                                : null;
                          },
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  //password
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFFF7F8F9),
                        border: Border.all(
                          color: const Color(0xFFE8ECF4),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: TextFormField(
                          obscureText: passwordVisible,
                            controller: _passwordController,
                            decoration:  InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Password',
                              hintStyle: TextStyle(
                                color: Color(0xFF8391A1),
                              ),
                                suffixIcon:  IconButton(
      icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
      onPressed: () {
        setState(() {
          passwordVisible = !passwordVisible;
        });
      },
    )
                            ),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              return value != null && value.length < 6
                                  ? "Enter min. 6 characters"
                                  : null;
                            }),
                      ),
                    ),
                  ),

                    ],
                  )),
                                   const SizedBox(height: 15),
                  //register button
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 5,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: MaterialButton(
                            color: const Color(0xFF1E232C),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            onPressed: () {
                                        final isValid = _form.currentState!.validate();
                        if (!isValid) {
                          return;
                        }
                              authCubit.signUp(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  name: _nameController.text);
                            },
                            child: const Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                "Register",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignIn()));
                        },
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            color: Color(0xFF35C2C1),
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );

            // return Center(
            //   child: Padding(
            //     padding: const EdgeInsets.all(18.0),
            //     child: SingleChildScrollView(
            //       reverse: true,
            //       child: Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         children: [
            //           const Text(
            //             "Sign Up",
            //             style: TextStyle(
            //               fontSize: 38,
            //               fontWeight: FontWeight.bold,
            //             ),
            //           ),
            //           const SizedBox(
            //             height: 18,
            //           ),
            //           Center(
            //             child: Form(
            //               key: _formKey,
            //               child: Column(
            //                 children: [
            //                   TextFormField(
            //                     controller: _emailController,
            //                     decoration: const InputDecoration(
            //                       hintText: "Email",
            //                       border: OutlineInputBorder(),
            //                     ),
            //                     autovalidateMode:
            //                         AutovalidateMode.onUserInteraction,
            //                     validator: (value) {
            //                       return value != null &&
            //                               !EmailValidator.validate(value)
            //                           ? 'Enter a valid email'
            //                           : null;
            //                     },
            //                   ),
            //                   const SizedBox(
            //                     height: 10,
            //                   ),
            //                   TextFormField(
            //                     controller: _passwordController,
            //                     decoration: const InputDecoration(
            //                       hintText: "Password",
            //                       border: OutlineInputBorder(),
            //                     ),
            //                     autovalidateMode:
            //                         AutovalidateMode.onUserInteraction,
            //                     validator: (value) {
            //                       return value != null && value.length < 6
            //                           ? "Enter min. 6 characters"
            //                           : null;
            //                     },
            //                   ),
            //                   const SizedBox(
            //                     height: 12,
            //                   ),
            //                   SizedBox(
            //                     width: MediaQuery.of(context).size.width * 0.7,
            //                     child: ElevatedButton(
            //                       onPressed: () {
            //                       authCubit.signUp(email:_emailController.text ,password:_passwordController.text );
            //                       },
            //                       child: const Text('Sign Up'),
            //                     ),
            //                   )
            //                 ],
            //               ),
            //             ),
            //           ),
            //           const Text("Already have an account?"),
            //           OutlinedButton(
            //             onPressed: () {
            //               Navigator.pushReplacement(
            //                 context,
            //                 MaterialPageRoute(
            //                     builder: (context) => const SignIn()),
            //               );
            //             },
            //             child: const Text("Sign In"),
            //           ),
            //           const Text("Or"),
            //           IconButton(
            //             onPressed: () {
            //                authCubit.googleSignIn();
            //             },
            //             icon: Image.network(
            //               "https://upload.wikimedia.org/wikipedia/commons/thumb/5/53/Google_%22G%22_Logo.svg/1200px-Google_%22G%22_Logo.svg.png",
            //               height: 30,
            //               width: 30,
            //             ),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            // );
          }
          return Container();
        },
      ),
    );
  }
}
