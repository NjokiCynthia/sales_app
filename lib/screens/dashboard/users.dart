import 'package:flutter/material.dart';
import 'package:petropal/constants/color_contants.dart';
import 'package:petropal/screens/dashboard/add_users.dart';

class User {
  final String name;
  final String email;
  final String location;

  User({required this.name, required this.email, required this.location});
}

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String selectedUserType = 'Oil Marketing Company';

  final List<String> userTypes = [
    'Oil Marketing Company',
    'Reseller',
    'Customer',
  ];

  void _showAddUserDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add new user"),
          backgroundColor: Colors.white,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text("Select the type of user you want to create:"),
              SizedBox(height: 10),
              DropdownButton<String>(
                value: selectedUserType,
                onChanged: (newValue) {
                  setState(() {
                    selectedUserType = newValue!;
                  });
                },
                items: userTypes.map((String userType) {
                  return DropdownMenuItem<String>(
                    value: userType,
                    child: Text(userType),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text("Confirm"),
              onPressed: () {
                // Perform the action when the "Add" button is pressed

                print("Selected User Type: $selectedUserType");
                Navigator.of(context).push(
                    MaterialPageRoute(builder: ((context) => AddUsers())));
                // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text('Users'),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey,
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(8),
              child: GestureDetector(
                onTap: _showAddUserDialog,
                child: Icon(
                  Icons.add,
                  // color: primaryDarkColor,
                ),
              ),
            ),
          ]),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Oil Marketing Companies'),
              Tab(text: 'Resellers'),
              Tab(text: 'Customers'),
            ],
          ),
        ),
        body: DefaultTabController(
          length: 3, // Number of tabs
          child: Column(
            children: [
              Expanded(
                child: TabBarView(
                  children: [
                    // Oil Marketing Companies Tab
                    UsersListTab(userType: 'Oil Companies'),

                    // Resellers Tab
                    UsersListTab(userType: 'Resellers'),

                    // Customers Tab
                    UsersListTab(userType: 'Customers'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class UsersListTab extends StatelessWidget {
  final String userType;

  UsersListTab({required this.userType});

  @override
  Widget build(BuildContext context) {
    // Generate a list of 10 sample users
    List<User> userList = List.generate(10, (index) {
      return User(
        name: 'User $index',
        email: 'user$index@example.com',
        location: 'Location $index',
      );
    });

    return ListView.builder(
      itemCount: userList.length,
      itemBuilder: (context, index) {
        return UserCard(
          user: userList[index],
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final User user;

  UserCard({required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              user.name,
              style: TextStyle(color: Colors.black), // Text color set to black
            ),
            subtitle: Text(
              user.email,
              style: TextStyle(color: Colors.black), // Text color set to black
            ),
            trailing: Icon(
              Icons.edit,
              color: Colors.grey,
            ),
          ),
          Container(
            width: double.infinity,
            height: 1.0,
            color: Colors.grey,
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  Icons.location_on,
                  color: Colors.grey.withOpacity(0.7),
                ),
                SizedBox(width: 8.0),
                Text(
                  user.location,
                  style: TextStyle(
                    color: Colors.grey.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
