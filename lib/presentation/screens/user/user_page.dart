import '../../../models/user_model.dart';
import '../auth/register_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/user/user_bloc.dart';

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
        automaticallyImplyLeading: false,
        title: const Text('User'),
      ),
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is DeleteUserSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Delete User Successful!')),
            );
          } else if (state is DeleteUserFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error)),
            );
          }
        },
        child: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserSuccess) {
              return RefreshIndicator(
                onRefresh: () async {
                  context.read<UserBloc>().add(GetUserEvent());
                },
                child: ListView.builder(
                  itemCount: state.user.length,
                  itemBuilder: (context, index) {
                    UserModel user = state.user[index];
                    return Container(
                      margin: EdgeInsets.only(
                          bottom: 5,
                          left: 5,
                          right: 5,
                          top: index == 0 ? 5 : 0),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
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
                                        builder: (context) => RegisterPage(
                                              type: 'Edit',
                                              userId: user.id.toString(),
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
                                        SubmitDeleteUserEvent(
                                            user.id.toString()),
                                      );
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.white,
                                ))
                          ],
                        ),
                        title: Text(
                          '${user.name.firstname} ${user.name.lastname}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(user.email),
                      ),
                    );
                  },
                ),
              );
            } else if (state is UserInitial) {
              context.read<UserBloc>().add(GetUserEvent());
              return const Center(child: CircularProgressIndicator());
            } else if (state is DeleteUserLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return const Center(
              child: Text('No Data'),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => RegisterPage(
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
