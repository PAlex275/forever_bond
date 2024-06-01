import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:forever_bond/Model/guest.dart';
import 'package:forever_bond/View/bloc/guests_bloc/guests_bloc.dart';

import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

class GuestsScreen extends StatefulWidget {
  const GuestsScreen({Key? key}) : super(key: key);
  static const String routeName = '/guests';
  @override
  State<GuestsScreen> createState() => _GuestsScreenState();
}

class _GuestsScreenState extends State<GuestsScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  bool _isConfirmed = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    BlocProvider.of<GuestsBloc>(context).add(LoadGuests());
    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _lastNameController.dispose();
    _phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Guest List'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            GoRouter.of(context).canPop() ? GoRouter.of(context).pop() : null;
          },
        ),
      ),
      body: BlocBuilder<GuestsBloc, GuestsState>(
        builder: (context, state) {
          if (state is GuestLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is GuestLoaded) {
            return _buildGuestList(state.guests);
          } else if (state is GuestError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return Container();
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddGuestDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildGuestList(List<Guest> guests) {
    return ListView.builder(
      itemCount: guests.length,
      itemBuilder: (context, index) {
        final guest = guests[index];
        return ListTile(
          title: Text('${guest.firstName} ${guest.lastName}'),
          subtitle: Text(guest.phoneNumber),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () {
                  _showEditGuestDialog(context, guest);
                },
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  _showDeleteGuestDialog(context, guest);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showAddGuestDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Adăugare invitat'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nume'),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introdu un nume';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Prenume'),
                      controller: _lastNameController,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Număr de telefon'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introdu un numar de telefon';
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
                    ),
                    Row(
                      children: [
                        const Text('Confirmat:'),
                        StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Checkbox(
                            value: _isConfirmed,
                            onChanged: (value) {
                              setState(() {
                                _isConfirmed = value!;
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Anulează'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final guest = Guest(
                  id: const Uuid().v4(),
                  firstName: _nameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                  phoneNumber: _phoneNumberController.text.trim(),
                  isConfirmed: _isConfirmed,
                );

                final bloc = BlocProvider.of<GuestsBloc>(context);
                bloc.add(AddGuest(guest));
                Navigator.pop(context);
              }
            },
            child: const Text('Adaugă'),
          ),
        ],
      ),
    );
  }

  void _showEditGuestDialog(BuildContext context, Guest guest) {
    _nameController.text = guest.firstName;
    _lastNameController.text = guest.lastName;
    _phoneNumberController.text = guest.phoneNumber;
    _isConfirmed = guest.isConfirmed;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Editare invitat'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Nume'),
                      controller: _nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introdu un nume';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(labelText: 'Prenume'),
                      controller: _lastNameController,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: 'Număr de telefon'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Introdu un număr de telefon';
                        }
                        return null;
                      },
                      controller: _phoneNumberController,
                    ),
                    Row(
                      children: [
                        const Text('Confirmat:'),
                        StatefulBuilder(builder:
                            (BuildContext context, StateSetter setState) {
                          return Checkbox(
                            value: _isConfirmed,
                            onChanged: (value) {
                              setState(() {
                                _isConfirmed = value!;
                              });
                            },
                          );
                        }),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Anulează'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                final updatedGuest = Guest(
                  id: guest.id,
                  firstName: _nameController.text.trim(),
                  lastName: _lastNameController.text.trim(),
                  phoneNumber: _phoneNumberController.text.trim(),
                  isConfirmed: _isConfirmed,
                );

                final bloc = BlocProvider.of<GuestsBloc>(context);
                bloc.add(UpdateGuest(updatedGuest));
                Navigator.pop(context);
              }
            },
            child: const Text('Actualizează'),
          ),
        ],
      ),
    );
  }

  void _showDeleteGuestDialog(BuildContext context, Guest guest) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Ștergere invitat'),
        content: Text(
            'Ești sigur că vrei să ștergi invitatul ${guest.firstName} ${guest.lastName}?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Anulează'),
          ),
          ElevatedButton(
            onPressed: () {
              final bloc = BlocProvider.of<GuestsBloc>(context);
              bloc.add(DeleteGuest(guest.id));
              Navigator.pop(context);
            },
            child: const Text('Șterge'),
          ),
        ],
      ),
    );
  }
}
