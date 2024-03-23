import 'package:flutter/material.dart';
import 'package:unamed_yet/models/user_account.dart'; // Adjust the import path as needed
import '../services/user_register_service.dart';

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {

  Future<List<UserAccount>> usersList() async {
    var userAccountResponseData = await UserRemoteService().userList();
    return userAccountResponseData;
  }

  void _approveUser(int index, List<UserAccount> userList) {
    setState(() {
      userList[index].isApproved = true;
      // Here, you would also call your backend to update the user's approval status
    });
  }

  void _declineUser(int index, List<UserAccount> userList) {
    setState(() {
      userList[index].isApproved = false;
      // Here, you would also call your backend to update the user's approval status
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Page'),
      ),
      body: FutureBuilder<List<UserAccount>>(
        future: usersList(),
        builder: (BuildContext context, AsyncSnapshot<List<UserAccount>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error.toString()}'));
          } else if (snapshot.hasData) {
            List<UserAccount> userList = snapshot.data!;
            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(userList[index].name!),
                  subtitle: Text(userList[index].email!),
                  trailing:userList[index].isApproved == false
                      ? Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                       IconButton(
                        icon: const Icon(Icons.check, color: Colors.green),
                        onPressed: () => _approveUser(index, userList),
                      ),IconButton(
                        icon: const Icon(Icons.close, color: Colors.red),
                        onPressed: () => _declineUser(index, userList),
                      )

                    ],
                  ) : Text("Approved"),
                );
              },
            );
          } else {
            return Center(child: Text('No data found.'));
          }
        },
      ),
    );
  }
}
