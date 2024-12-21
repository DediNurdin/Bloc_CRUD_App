import 'package:bloc_online_store/bloc/auth/auth_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocProvider(
        create: (context) => AuthBloc()..add(GetAuthEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is AuthSuccess) {
              final auth = state.auth;
              return ListView(
                children: [
                  CupertinoFormSection(header: Text('Profile'), children: [
                    CupertinoFormRow(
                      prefix: Text(
                        'Name',
                      ),
                      child:
                          Text('${auth.name.firstname} ${auth.name.lastname}'),
                    ),
                    CupertinoFormRow(
                      prefix: Text(
                        'Email',
                      ),
                      child: Text(auth.email),
                    ),
                    CupertinoFormRow(
                      prefix: Text(
                        'Phone',
                      ),
                      child: Text(auth.phone),
                    ),
                  ]),
                  CupertinoFormSection(header: Text('Address'), children: [
                    CupertinoFormRow(
                      prefix: Text(
                        'Full Adress',
                      ),
                      child: Text(
                          '${auth.address.street}, ${auth.address.city}, ${auth.address.zipcode}'),
                    ),
                  ])
                ],
              );
            } else if (state is AuthError) {
              return Center(child: Text(state.message));
            }
            return Center(child: Text('No data available'));
          },
        ),
      ),
    );
  }
}
