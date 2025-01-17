import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../bloc/auth/auth_bloc.dart';
import '../../../utils/utils.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Profile')),
      body: BlocProvider(
        create: (context) => AuthBloc()..add(GetAuthEvent()),
        child: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthLoading) {
              return Center(child: CupertinoActivityIndicator());
            } else if (state is AuthSuccess) {
              final auth = state.auth;

              return Column(
                children: [
                  CupertinoFormSection(header: Text('Profile'), children: [
                    CupertinoFormRow(
                      prefix: Text(
                        'Name',
                      ),
                      child: Text(
                          '${auth.name.firstname.capitalize()} ${auth.name.lastname.capitalize()}'),
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
                          '${auth.address.street.capitalize()}, ${auth.address.city.capitalize()}, ${auth.address.zipcode.capitalize()}'),
                    ),
                  ]),
                  SizedBox(
                      height: 500,
                      child: FlutterMap(
                        options: MapOptions(
                          initialCenter: LatLng(
                              double.parse(auth.address.geolocation.lat),
                              double.parse(auth.address.geolocation.long)),
                          initialZoom: 9.2,
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName: 'com.example.app',
                          ),
                          MarkerLayer(markers: [
                            Marker(
                              point: LatLng(
                                  double.parse(auth.address.geolocation.lat),
                                  double.parse(auth.address.geolocation.long)),
                              width: 80,
                              height: 80,
                              child: IconButton(
                                onPressed: () {},
                                icon: Icon(CupertinoIcons.location),
                                color: Colors.red,
                                iconSize: 35,
                              ),
                            ),
                          ]),
                          RichAttributionWidget(
                            attributions: [
                              TextSourceAttribution(
                                'OpenStreetMap contributors',
                                onTap: () => launchUrl(Uri.parse(
                                    'https://openstreetmap.org/copyright')),
                              ),
                            ],
                          ),
                        ],
                      ))
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
