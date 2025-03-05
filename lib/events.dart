import 'package:flutter/material.dart';
import 'login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'betting_dialog.dart'; // Import the betting dialog

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedIndex = 0; // For bottom navigation
  bool _showUpcomingEvents = true; // Track which events to display

  final List<Event> upcomingEvents = [
    Event("Nov 29th, 7pm (Dinner)", "Taco Bamba, Arlington, VA", ["Dylan", "Joel"]),
    Event("Dec 3rd, 5pm (Bach Party)", "AirBnb, Miami, FL", ["Rob", "Jackson", "Others"]),
    Event("Dec 5th, 8pm (Movie Night)", "AMC Theaters, Alexandria, VA", ["Micah", "Michelle"]),
    Event("Dec 7th, 2pm (Lunch)", "Red Bistro, Reston", ["Kelly", "Anne", "Others"]),
  ];

  final List<Event> pastEvents = [
    Event("Oct 20th, 6pm (Concert)", "The Anthem, DC", ["Sarah", "Emily"]),
    Event("Nov 1st, 10am (Brunch)", "Founding Farmers, Tysons", ["David", "Amy", "John"]),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300], // Match header color
        title: const Text(
          "Flake",
          style: TextStyle(color: Colors.black), // White title
        ),
        centerTitle: true, // Center the title
        actions: [
          StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.hasData) {
                return IconButton(
                  icon: const Icon(Icons.logout, color: Colors.white),
                  onPressed: () async {
                    bool? confirmLogout = await showDialog<bool>(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Confirm Logout'),
                          content: const Text('Are you sure you want to log out?'),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              child: const Text('Logout'),
                            ),
                          ],
                        );
                      },
                    );
                    if (confirmLogout == true) {
                      await FirebaseAuth.instance.signOut();
                    }
                  },
                );
              } else {
                return IconButton(
                  icon: const Icon(Icons.login, color: Colors.white),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginPage()),
                    );
                  },
                );
              }
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "My Events",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          _buildSegmentedControl(), // Segmented control for Upcoming/Past
          Expanded(
            child: ListView.builder(
              itemCount: _showUpcomingEvents ? upcomingEvents.length : pastEvents.length,
              itemBuilder: (context, index) {
                return EventCard(
                  event: _showUpcomingEvents ? upcomingEvents[index] : pastEvents[index],
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white, // Set background color
        type: BottomNavigationBarType.fixed, // Set type to fixed
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Invites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.leaderboard),
            label: 'Leaderboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800], // Highlight selected icon
        unselectedItemColor: Colors.black, // Set unselected item color
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildSegmentedControl() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showUpcomingEvents = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _showUpcomingEvents ? Colors.amber[200] : Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: const Text("Upcoming Events"),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                setState(() {
                  _showUpcomingEvents = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: !_showUpcomingEvents ? Colors.amber[200] : Colors.grey[300],
                foregroundColor: Colors.black,
              ),
              child: const Text("Past Events"),
            ),
          ),
        ],
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class Event {
  final String dateAndTime;
  final String location;
  final List<String> participants;

  Event(this.dateAndTime, this.location, this.participants);
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    // Split the dateAndTime string into date and title
    List<String> parts = event.dateAndTime.split('(');
    String date = parts[0].trim();
    String title = parts.length > 1 ? parts[1].replaceAll(')', '').trim() : '';

    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return BettingDialog(participants: event.participants);
          },
        );
      },
      child: Card(
        margin: const EdgeInsets.all(16),
        elevation: 4, // Add a subtle shadow
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.amber[800]),
                  const SizedBox(width: 8),
                  Text(
                    date,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.location_on, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    event.location,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.people, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Participants: ${event.participants.join(', ')}',
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}