import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/user.dart';
import '../../../bloc/user/user_bloc.dart';
import 'add_user_page.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  void initState() {
    super.initState();
    context.read<UserBloc>().add(GetUserEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const Text('User'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserSuccess) {
            return ListView.builder(
              itemCount: state.user.length,
              itemBuilder: (context, index) {
                User user = state.user[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 5, left: 5, right: 5),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.amber)),
                            onPressed: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => AddUserPage(
                                          type: 'Edit',
                                          userData: user,
                                        )),
                              );
                            },
                            icon: const Icon(
                              Icons.edit,
                              color: Colors.white,
                            )),
                        const VerticalDivider(
                          color: Colors.black12,
                        ),
                        IconButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    WidgetStatePropertyAll(Colors.red)),
                            onPressed: () {
                              context.read<UserBloc>().add(
                                    DeleteUserEvent(user.id),
                                  );
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ))
                      ],
                    ),
                    title: Text(
                      user.name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(user.email),
                  ),
                );
              },
            );
          } else if (state is UserInitial) {
            context.read<UserBloc>().add(GetUserEvent());
            return const Center(child: CircularProgressIndicator());
          } else if (state is DeleteUserLoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is DeleteUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
          return const Center(child: Text('No Data Available'));
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const AddUserPage(
                      type: 'Add',
                    )),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
