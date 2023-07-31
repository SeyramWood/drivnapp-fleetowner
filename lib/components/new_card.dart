import 'package:flutter/material.dart';

class MyCard2 extends StatefulWidget {
  @override
  _MyCard2State createState() => _MyCard2State();
}

class _MyCard2State extends State<MyCard2> {
  String _selectedOption = 'Unavailable'; // Default selected value
  String _pickupLocation = '';
  String _destination = '';
  String _price = '';
  bool _carWithDriver = false;
  int _numberOfSeats = 1;

  String _driverStatusForDisplay =
      ''; // Local variable to hold the driver status for immediate display
  String _priceForDisplay =
      ''; // Local variable to hold the price for immediate display
  int _seatsForDisplay =
      1; // Local variable to hold the number of seats for immediate display

  void _showRentDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Rent Car Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _pickupLocation = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter pickup location',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _price = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter price',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Car with Driver'),
                      Switch(
                        value: _carWithDriver,
                        onChanged: (value) {
                          setState(() {
                            _carWithDriver = value;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Update the local variable _priceForDisplay and _driverStatusForDisplay immediately
                    setState(() {
                      if (_carWithDriver) {
                        _driverStatusForDisplay = 'With driver Yes';
                      } else {
                        _driverStatusForDisplay = 'With driver No';
                      }
                      _priceForDisplay = _price;
                    });

                    // Do something with the entered data (e.g., store it, process it, etc.)
                    // For now, let's just print the entered data.
                    print('Pickup Location: $_pickupLocation');
                    print('Price: $_price');
                    print('Car with Driver: $_carWithDriver');

                    // Now update the price and driver status in the third column only when "OK" is clicked
                    if (_selectedOption == 'Rent') {
                      _updatePriceAndDriverStatusForDisplay();
                    }

                    Navigator.of(context).pop();
                  },
                  child: Text('Save'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updatePriceAndDriverStatusForDisplay() {
    // Update the displayed price with the entered price and driver status when "OK" is clicked
    setState(() {
      if (_carWithDriver) {
        _driverStatusForDisplay = 'With driver Yes';
      } else {
        _driverStatusForDisplay = 'With driver No';
      }
      _priceForDisplay = _price;
    });
  }

  void _showRideSharingDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Ride Sharing Details'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _destination = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter destination',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _pickupLocation = value;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'Enter pickup location',
                    ),
                  ),
                  SizedBox(height: 10),
                  TextButton(
                    onPressed: () {
                      // Handle recording pickup location
                      setState(() {
                        _pickupLocation = 'Current Location';
                      });
                    },
                    child: Text('Record Pickup Location'),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Date:'),
                      ElevatedButton(
                        onPressed: () {
                          // Handle date selection
                          _showDatePicker();
                        },
                        child: Text('Select Date'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Time:'),
                      ElevatedButton(
                        onPressed: () {
                          // Handle time selection
                          _showTimePicker();
                        },
                        child: Text('Select Time'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        _price = value;
                      });
                    },
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: 'Enter price',
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Number of Seats:'),
                      IconButton(
                        icon: Icon(Icons.remove),
                        onPressed: () {
                          // Handle decreasing the number of seats
                          setState(() {
                            if (_numberOfSeats > 1) {
                              _numberOfSeats--;
                            }
                          });
                        },
                      ),
                      Text(_numberOfSeats
                          .toString()), // Display the selected number of seats
                      IconButton(
                        icon: Icon(Icons.add),
                        onPressed: () {
                          // Handle increasing the number of seats
                          setState(() {
                            _numberOfSeats++;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('Cancel'),
                ),
                TextButton(
                  onPressed: () {
                    // Do something with the entered data (e.g., store it, process it, etc.)
                    // For now, let's just print the entered data.
                    print('Destination: $_destination');
                    print('Pickup Location: $_pickupLocation');
                    print('Date: ...'); // Handle the selected date
                    print('Time: ...'); // Handle the selected time
                    print('Price: $_price');
                    print('Number of Seats: $_numberOfSeats');

                    // Update the first and second text widgets in the third column with the number of seats and price
                    setState(() {
                      _seatsForDisplay = _numberOfSeats;
                      _priceForDisplay = _price;
                    });

                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _showDatePicker() async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (selectedDate != null) {
      // Handle the selected date
      print('Selected Date: $selectedDate');
    }
  }

  Future<void> _showTimePicker() async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      // Handle the selected time
      print('Selected Time: $selectedTime');
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150.0, // Set the height of the card here
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            children: [
              // First Column: Image
              Expanded(
                flex: 2,
                child: Image.network(
                  'https://images.unsplash.com/photo-1604108415419-6d4bd73a1c2c?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8NHx8Zm9yZCUyMGYxNTB8ZW58MHx8MHx8fDA%3D&auto=format&fit=crop&w=800&q=60',
                  fit: BoxFit.cover,
                ),
              ),

              // Second Column: Text, Icon, and Button with Dropdown
              Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Ford f150',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Icon(Icons.star),
                          SizedBox(width: 1.0),
                          Text('4.5 (200)'),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        height: 45,
                        child: DropdownButton<String>(
                          items: <String>['Unavailable', 'Rent', 'Ride sharing']
                              .map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: TextStyle(
                                  fontSize:
                                      16.0, // Set the font size of the dropdown items
                                  color: Colors
                                      .blue, // Change the text color of the dropdown items
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedOption = newValue!;
                              if (_selectedOption == 'Rent') {
                                _showRentDialog();
                              } else if (_selectedOption == 'Ride sharing') {
                                _showRideSharingDialog();
                              } else {
                                // Update the first and second text widgets in the third column with "None" for Unavailable option
                                setState(() {
                                  _driverStatusForDisplay = 'None';
                                  _seatsForDisplay = 0;
                                  _priceForDisplay = 'None';
                                });
                              }
                            });
                          },
                          value: _selectedOption, // Set the initial value here.
                          style: TextStyle(
                            fontSize:
                                16.0, // Set the font size of the selected value
                            color: Colors
                                .blue, // Change the text color of the selected value
                          ),
                          icon: Icon(
                            Icons.keyboard_arrow_down, // Set the dropdown icon
                            color: Colors
                                .blue, // Change the color of the dropdown icon
                          ),
                          elevation: 10, // Add a shadow to the dropdown menu
                          dropdownColor: Colors
                              .white, // Change the background color of the dropdown menu
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Third Column: Two Text Items
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _selectedOption == 'Rent'
                          ? _driverStatusForDisplay
                          : _selectedOption == 'Ride sharing'
                              ? 'Seats: $_seatsForDisplay'
                              : 'None',
                      style: TextStyle(fontSize: 14.0),
                    ),
                    Text(
                      _selectedOption == 'Rent'
                          ? 'Price: $_priceForDisplay'
                          : _selectedOption == 'Ride sharing'
                              ? 'Price: $_priceForDisplay'
                              : 'None',
                      style: TextStyle(fontSize: 14.0),
                    ),
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
