import 'package:flutter/material.dart';
import 'package:appwrite/models.dart'; // Ensure this is the correct import for Document.
import 'package:tiket_bus/api.dart'; // Ensure this is where AppWrite.init() and AppWrite.getBusTickets() are defined.

void main() {
  runApp(const MyApp());
  AppWrite.init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PEMESANAN TIKET BUS',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'PEMESANAN TIKET BUS'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Document>?>(
      future: AppWrite.getMusic(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_rounded,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_rounded,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final busTickets = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_rounded,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Available Bus Tickets',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  ListView.builder(
                    itemCount: busTickets.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      final ticket = busTickets[index];
                      return Card(
                        margin: const EdgeInsets.only(bottom: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 5,
                        child: ListTile(
                          contentPadding: EdgeInsets.all(10),
                          leading: CircleAvatar(
                            backgroundColor: Colors.deepPurple,
                            child: Icon(Icons.directions_bus, color: Colors.white),
                          ),
                          title: Text(
                            ticket.data['destination'] ?? 'No Destination',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 5),
                              Text('From: ${ticket.data['departure'] ?? 'Unknown'}'),
                              Text('Price: ${ticket.data['price'] ?? 'Unknown'} \$'),
                              Text('Date: ${ticket.data['date'] ?? 'Unknown'}'),
                            ],
                          ),
                          trailing: Icon(Icons.arrow_forward_ios, color: Colors.deepPurple),
                          onTap: () {
                            // Add your onTap functionality here
                          },
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_rounded,
                    size: 30.0,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ),
            body: Center(child: Text('No data available')),
          );
        }
      },
    );
  }
}
