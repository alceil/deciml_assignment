import 'package:deciml_assignment/cubit/auth/auth_cubit.dart';
import 'package:deciml_assignment/cubit/theme/theme_cubit.dart';
import 'package:deciml_assignment/models/currency_model.dart';
import 'package:deciml_assignment/presentation/Account/cubit/account_cubit.dart';
import 'package:deciml_assignment/presentation/SignIn/sign_in.dart';
import 'package:deciml_assignment/shared/global/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AccountCubit>().getAccountDetails();
    final authCubit = context.read<AuthCubit>();
    final themeCubit = context.read<ThemeCubit>();
    return BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is UnAuthenticated) {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignIn()));
          }
        },
        child: Scaffold(
              floatingActionButton: const SizedBox(height: 1),
    floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor:  Theme.of(context).textTheme.bodyLarge!.color,
            title: const Text("Account"),
            centerTitle: true,
            // actions: [
            //   IconButton(
            //     onPressed: () {},
            //     icon: const Icon(Icons.settings_rounded),
            //   )
            // ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(10),
            children: [
              // COLUMN THAT WILL CONTAIN THE PROFILE
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return Column(
                    children: [
                      CircleAvatar(
                        radius: 50.0, // Adjust the radius as needed
                        backgroundColor: Color(0xFF8E59FF), // Set the background color of the circle
                        child: Text(
                          Globals.getInitials(state.name!.trim()),
                          style: TextStyle(
                            fontSize: 24.0, // Adjust the font size as needed
                            color: Colors.white, // Set the text color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        state.name!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        state.email!,
                      )
                    ],
                  );
                },
              ),

              const SizedBox(height: 35),
              InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(25.0)),
                        ),
                        builder: (BuildContext context) {
                          return EditProfile();
                        });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 5),
                    child: Card(
                      elevation: 4,
                      color: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F6F9) // Light mode color
        : Colors.grey[800],
                      shadowColor: Colors.black12,
                      child: ListTile(
                        leading: Icon(Icons.person_2_outlined),
                        title: Text("Profile"),
                      ),
                    ),
                  )),
              BlocBuilder<ThemeCubit, ThemeState>(
                builder: (context, state) {
                  return InkWell(
                      onTap: () {
                        themeCubit.toggleTheme();
                        print("cubit called");
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          elevation: 4,
                          color:Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F6F9) // Light mode color
        : Colors.grey[800],
                                   shadowColor: Colors.black12,
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                state.themeMode == ThemeMode.light
                                    ? const Icon(Icons.light_mode)
                                    : const Icon(Icons.dark_mode),
                              ],
                            ),
                            title: Text(
                                "${state.themeMode == ThemeMode.light ? "Light" : "Dark"} mode"),
                            subtitle: const Text("Tap to switch theme"),
                          ),
                        ),
                      ));
                },
              ),
              BlocBuilder<AccountCubit, AccountState>(
                builder: (context, state) {
                  return InkWell(
                      onTap: () {
                        showModalBottomSheet(
                            context: context,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(25.0)),
                            ),
                            builder: (BuildContext context) {
                              return CurrencyList();
                            });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 5),
                        child: Card(
                          elevation: 4,
                          color:Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F6F9) // Light mode color
        : Colors.grey[800],
                          shadowColor: Colors.black12,
                          child: ListTile(
                            leading: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.attach_money),
                              ],
                            ),
                            title: Text("Currency"),
                            subtitle: Text(state.selectedCurrency!),
                          ),
                        ),
                      ));
                },
              ),
              InkWell(
                onTap: () {
                  authCubit.signOut();
                },
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 5),
                  child: Card(
                    elevation: 4,
                    color: Theme.of(context).brightness == Brightness.light
        ? Color(0xFFF5F6F9) // Light mode color
        : Colors.grey[800],
                    shadowColor: Colors.black12,
                    child: ListTile(
                      leading: Icon(Icons.logout_outlined),
                      title: Text("Logout"),
                    ),
                  ),
                ),
              )
            ],
          ),
        )
        );
  }
}

class EditProfile extends StatefulWidget {
  const EditProfile({
    super.key,
  });

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
    late String nameFieldVal;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.36,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "Profile",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                )),
           Form(
            key:_formKey ,
             child: Column(
              children: [
                     TextFormField(
                        cursorColor: Colors.black,
                    keyboardType: TextInputType.text,
                    initialValue: state.name??"",
                    decoration: const InputDecoration(
              labelText: "Name",
                    focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
                    ),
                    
                    onSaved: (val) {
                      nameFieldVal = val!;
                    },
                  ),
                  TextField(
                    cursorColor: Colors.black,
                    readOnly: true,
                    controller: TextEditingController()..text = state.email!,
                    decoration: InputDecoration(
                      labelText: 'Email',
                           focusedBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.black),
    ),
                    ),
                  ),
              ],
             ),
           ),
                Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFF8E59FF)),
                          onPressed: () async{
                               _formKey.currentState?.save();
                             await context.read<AccountCubit>().updateProfile(name:nameFieldVal);
                               Navigator.pop(context);
                                       ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Profile updated")));    
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(15.0),
                            child: Text(
                              "Edit Profile",
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
              ],
            ),
          ),
        );
      },
    );
  }
}

class CurrencyList extends StatefulWidget {
  const CurrencyList({
    super.key,
  });

  @override
  State<CurrencyList> createState() => _CurrencyListState();
}

class _CurrencyListState extends State<CurrencyList> {
  int? selectedCurrencyIndex;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AccountCubit, AccountState>(
      builder: (context, state) {
        return Container(
          child: Column(
            children: [
              ListTile(
                title: Text('Select Currency'),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: state.currencyList!.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                        state.currencyList![index].name!,
                        selectionColor: Colors.white,
                      ),
                      selectedColor: Color(0xFF8E59FF),
                      selected: index == selectedCurrencyIndex,
                      onTap: () {
                        // Save selected currency in Hive
                        // currencyBox.put('selectedCurrencyCode', currencies[index].code);

                        // Close the modal
                        setState(() {
                          selectedCurrencyIndex = index;
                        });
                      },
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF8E59FF)),
                        onPressed: () {
if(selectedCurrencyIndex!=null){
         context.read<AccountCubit>().changeCurrency(
                              state.currencyList![selectedCurrencyIndex!]);
                          Navigator.of(context).pop();
                                             ScaffoldMessenger.of(context)
                  .showSnackBar(SnackBar(content: Text("Currency changed")));    
}
                    
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            "Change Currency",
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
            ],
          ),
        );
      },
    );
  }
}
