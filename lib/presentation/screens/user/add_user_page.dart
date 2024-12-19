import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/region/region_bloc.dart';
import '../../../bloc/user/user_bloc.dart';
import '../../../models/user.dart';
import '../delegate/search_delegate_prov.dart';

class AddUserPage extends StatefulWidget {
  const AddUserPage({super.key, required this.type, this.userData});

  final String type;
  final User? userData;
  @override
  State<AddUserPage> createState() => _AddUserPageState();
}

class _AddUserPageState extends State<AddUserPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final TextEditingController provController = TextEditingController();
  final TextEditingController provIdController = TextEditingController();

  final TextEditingController kabKotController = TextEditingController();
  final TextEditingController kabKotIdController = TextEditingController();

  final TextEditingController kecController = TextEditingController();
  final TextEditingController kecIdController = TextEditingController();

  final TextEditingController kelController = TextEditingController();
  final TextEditingController kelIdController = TextEditingController();

  @override
  void initState() {
    if (widget.type == 'Edit') {
      nameController.text = widget.userData!.name;
      emailController.text = widget.userData!.email;
      phoneController.text = widget.userData!.phone;
    }
    super.initState();
  }

  Widget icloading = const Icon(Icons.chevron_right);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('${widget.type} User'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is AddUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.of(context).pop();
          } else if (state is AddUserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
          if (state is EditUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
            Navigator.of(context).pop();
          } else if (state is EditUserErrorState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ListView(
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                controller: emailController,
                decoration: const InputDecoration(labelText: 'Email'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                keyboardType: TextInputType.number,
                controller: phoneController,
                decoration: const InputDecoration(labelText: 'Phone'),
              ),
              const SizedBox(
                height: 8,
              ),
              BlocListener<RegionBloc, RegionState>(
                listener: (context, state) {
                  if (state is ProvinsiSuccess) {
                    showSearch(
                        context: context,
                        delegate: SearchDelegateProv(
                            allProvList: state.provinsi,
                            allProvListSuggest: state.provinsi,
                            provController: provController,
                            provIdController: provIdController));

                    icloading = const Icon(Icons.chevron_right);
                  } else if (state is ProvinsiError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.error)),
                    );
                  }

                  if (state is ProvinsiLoading) {
                    setState(() {
                      icloading = const CupertinoActivityIndicator();
                    });
                  }
                },
                child: TextField(
                  controller: provController,
                  readOnly: true,
                  onTap: () {
                    context.read<RegionBloc>().add(GetProvinsiEvent());
                  },
                  decoration: InputDecoration(
                      labelText: 'Provinsi', suffixIcon: icloading),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: kabKotController,
                readOnly: true,
                onTap: () {},
                decoration: const InputDecoration(labelText: 'Kab / Kota'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: kecController,
                readOnly: true,
                onTap: () {},
                decoration: const InputDecoration(labelText: 'Kecamatan'),
              ),
              const SizedBox(
                height: 8,
              ),
              TextField(
                controller: kelController,
                readOnly: true,
                onTap: () {},
                decoration: const InputDecoration(labelText: 'Kelurahan'),
              ),
              const SizedBox(
                height: 50,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  onPressed: () {
                    if (nameController.text.isNotEmpty &&
                        emailController.text.isNotEmpty) {
                      widget.type == 'Add'
                          ? context.read<UserBloc>().add(
                                PostAddUserEvent(
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                ),
                              )
                          : context.read<UserBloc>().add(
                                PutEditUserEvent(
                                  widget.userData!.id,
                                  nameController.text,
                                  emailController.text,
                                  phoneController.text,
                                ),
                              );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Harap lengkapi data')),
                      );
                    }
                  },
                  child: Text(
                    '${widget.type} User',
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
