import 'package:flutter/material.dart';

class EventPage extends StatefulWidget {
  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  int _selectedIndex = 0; // For bottom navigation

  final List<Event> upcomingEvents = [
    Event("Nov 29th, 7pm (Dinner)", "Taco Bamba, Arlington, VA", "Dylan, Joel"),
    Event("Dec 3rd, 5pm (Bach Party)", "AirBnb, Miami, FL", "Rob, Jackson, Others"),
    Event("Dec 5th, 8pm (Movie Night)", "AMC Theaters, Alexandria, VA", "Micah, Michelle"),
    Event("Dec 7th, 2pm (Lunch)", "Red Bistro, Reston", "Kelly, Anne, Others"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[300], // Match header color
        title: Text(
          "FLAKE",
          style: TextStyle(color: Colors.white), // White title
        ),
        centerTitle: true, // Center the title
        actions: [
          IconButton(
            icon: Icon(Icons.notifications, color: Colors.white),
            onPressed: () {
              // Handle notification icon press
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
              itemCount: upcomingEvents.length,
              itemBuilder: (context, index) {
                return EventCard(event: upcomingEvents[index]);
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.card_giftcard),
            label: 'Offers',
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
                // Handle Upcoming Events tab press
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber[200], // Light amber color
                foregroundColor: Colors.black, // Text color
              ),
              child: Text("Upcoming Events"),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: ElevatedButton(
              onPressed: () {
                // Handle Past Events tab press
              },
              child: Text("Past Events"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[300], // Light grey color
                foregroundColor: Colors.black, // Text color
              ),
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
  final String participants;

  Event(this.dateAndTime, this.location, this.participants);
}

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({required this.event});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: ListTile(
        title: Text(event.dateAndTime),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(event.location),
            Text(event.participants),
          ],
        ),
        trailing: Icon(Icons.group), // Add icon to the right
      ),
    );
  }
}