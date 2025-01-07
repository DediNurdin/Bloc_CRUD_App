import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';
import '../../../models/user_model.dart';
import '../../../utils/colors.dart';
import '../../../utils/text_form_field_widget.dart';
import '../../../utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(
      {super.key, required this.type, this.userId = '', this.userData});
  final String type;
  final String userId;
  final UserModel? userData;
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstnameController = TextEditingController();
  final TextEditingController lastnameController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController zipcodeController = TextEditingController();
  final TextEditingController latController = TextEditingController();
  final TextEditingController longController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    if (widget.type == 'Edit') {
      emailController.text = widget.userData!.email;
      usernameController.text = widget.userData!.username;
      passwordController.text = widget.userData!.password;
      firstnameController.text = widget.userData!.name.firstname;
      lastnameController.text = widget.userData!.name.lastname;
      cityController.text = widget.userData!.address.city;
      streetController.text = widget.userData!.address.street;
      numberController.text = widget.userData!.address.number.toString();
      zipcodeController.text = widget.userData!.address.zipcode;
      latController.text = widget.userData!.address.geolocation.lat;
      longController.text = widget.userData!.address.geolocation.long;
      phoneController.text = widget.userData!.phone;
    }
  }

  var isObsecure = true;

  @override
  Widget build(BuildContext context) {
    Utils.isDarkMode(context)
        ? ThemeUtils.darkTheme(false)
        : ThemeUtils.lightTheme(false);

    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.type} User'),
      ),
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {
          if (state is RegisterSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Registration Successful!')),
            );
            Navigator.pushReplacementNamed(context, '/bottomnav');
          } else if (state is RegisterFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }

          if (state is EditUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Edit User Successful!')),
            );
            Navigator.pushReplacementNamed(context, '/bottomnav');
          } else if (state is EditUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        builder: (context, state) {
          if (state is RegisterLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Expanded(
                    child: Form(
                      key: formKey,
                      child: ListView(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: emailController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.emailAddress,
                              labelText: 'Email'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            textInputAction: TextInputAction.next,
                            controller: usernameController,
                            keyboardType: TextInputType.text,
                            labelText: 'Username',
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                            controller: passwordController,
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.visiblePassword,
                            labelText: 'Password',
                            isPassword: true,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: firstnameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: lastnameController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: cityController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: streetController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: numberController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: zipcodeController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: latController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'First Name'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: longController,
                              textInputAction: TextInputAction.next,
                              keyboardType: TextInputType.text,
                              labelText: 'Longitude'),
                          const SizedBox(
                            height: 10,
                          ),
                          TextFormFieldWidget(
                              controller: phoneController,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.text,
                              labelText: 'Phone'),
                          const SizedBox(height: 16),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          final user = UserRegisterModel(
                            email: emailController.text,
                            username: usernameController.text,
                            password: passwordController.text,
                            name: Name(
                              firstname: firstnameController.text,
                              lastname: lastnameController.text,
                            ),
                            address: AddressRegister(
                              city: cityController.text,
                              street: streetController.text,
                              number: int.tryParse(numberController.text) ?? 0,
                              zipcode: zipcodeController.text,
                              geolocation: Geolocation(
                                lat: latController.text,
                                long: longController.text,
                              ),
                            ),
                            phone: phoneController.text,
                          );
                          widget.type == 'Edit'
                              ? context
                                  .read<RegisterBloc>()
                                  .add(SubmitEditUserEvent(widget.userId, user))
                              : context
                                  .read<RegisterBloc>()
                                  .add(SubmitRegisterEvent(user));
                        }
                      },
                      child: Text('${widget.type} User'),
                    ),
                  ),
                ],
              ));
        },
      ),
    );
  }
}
