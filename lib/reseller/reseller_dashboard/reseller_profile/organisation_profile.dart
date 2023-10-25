import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/r_profile.dart';

class OrganisationProfile extends StatefulWidget {
  const OrganisationProfile({super.key});

  @override
  State<OrganisationProfile> createState() => _OrganisationProfileState();
}

class _OrganisationProfileState extends State<OrganisationProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ResellerProfile()));
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: primaryDarkColor,
                      ),
                    ),
                    Text(
                      'Organisation Profile Details',
                      style: m_title,
                    ),
                    Container(
                      width: 30,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
