// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:petropal/constants/api.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/constants/theme.dart';
import 'package:petropal/models/contacts_list.dart';
import 'package:petropal/providers/user_provider.dart';
import 'package:petropal/reseller/reseller_dashboard/reseller_profile/contact_details.dart';
import 'package:provider/provider.dart';

class ViewStaff extends StatefulWidget {
  const ViewStaff({super.key});

  @override
  State<ViewStaff> createState() => _ViewStaffState();
}

class _ViewStaffState extends State<ViewStaff> {
  int _backgroundColorIndex = 0;

  bool fetchingContacts = true;

  List<ContactListing> contactList = [];
  Future<void> _fetchContacts(BuildContext context) async {
    setState(() {
      fetchingContacts = true;
    });

    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final token = userProvider.user?.token;

    final postData = {};
    final apiClient = ApiClient();
    final headers = {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    };

    try {
      final response = await apiClient.post(
        '/contact-persons/query',
        postData,
        headers: headers,
      );
      print('These are the contacts i have');
      print('Response: $response');

      if (response['status'] == 1 && response['data'] != null) {
        final data = List<Map<String, dynamic>>.from(response['data']);
        final contactListing = data.map((contactData) {
          return ContactListing.fromJson(contactData);
        }).toList();

        setState(() {
          contactList = contactListing;
        });
      } else {
        print('No or invalid contacts found in the response');
        // Handle the case when 'status' is not 1 or 'cartProductsListing' is null
      }
    } catch (error) {
      print('contact Fetch By ID Error: $error');
      // Handle the error
    }

    setState(() {
      fetchingContacts = false;
    });
  }

  Future<void> _refreshContacts(BuildContext context) async {
    await _fetchContacts(context);
  }

  @override
  void initState() {
    super.initState();
    _fetchContacts(context);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.grey[50],
    ));

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.grey[50],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: const Icon(
            Icons.arrow_back_ios,
            color: primaryDarkColor,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('View Staff added', style: m_title),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: ((context) => const ContactDetails()),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: primaryDarkColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(5),
                child: const Icon(
                  Icons.add,
                  color: primaryDarkColor,
                ),
              ),
            ),
          ],
        ),
        elevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => _refreshContacts(context),
        child: Column(
          children: [
            Expanded(
              child: fetchingContacts
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : contactList.isEmpty
                      ? Center(
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'No staff added at the moment',
                                  style: displayTitle,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: ((context) =>
                                                const ContactDetails())));
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Icon(
                                          Icons.add,
                                          color: primaryDarkColor,
                                        ),
                                        Text(
                                          'Add now',
                                          style: TextStyle(
                                              color: primaryDarkColor),
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : ListView.builder(
                          itemCount: contactList.length,
                          itemBuilder: (BuildContext context, int index) {
                            _backgroundColorIndex = 1 - _backgroundColorIndex;

                            ContactListing contact = contactList[index];
                            return Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      color: primaryDarkColor.withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(8),
                                    child: const Icon(
                                      Icons.person,
                                      color: primaryDarkColor,
                                      size: 15,
                                    ),
                                  ),
                                  title: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${contact.name}',
                                        style: const TextStyle(
                                            color: Colors.black),
                                      ),
                                      Text(
                                        contact.position ?? '',
                                        style: const TextStyle(
                                            color: primaryDarkColor),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        contact.email!,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                      Text(
                                        contact.phoneNumber!,
                                        style:
                                            const TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Divider(
                                    color: Colors.grey[
                                        300], // Change the color if needed
                                    height: 1,
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
