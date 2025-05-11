// ignore_for_file: use_build_context_synchronously

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:trendz_merchant/Components/elevated_button.dart';
import 'package:trendz_merchant/Models/service_modal.dart';
import 'package:trendz_merchant/Services/api_services.dart';

class ServiceManagementPage extends StatefulWidget {
  @override
  _ServiceManagementPageState createState() => _ServiceManagementPageState();
}

class _ServiceManagementPageState extends State<ServiceManagementPage> {
  final ApiService apiService = ApiService();
  late Future<Services> services;
  List<int> selectedServices = [];
  bool isDeleteMode = false;
  int newvalue = 1;

  @override
  void initState() {
    super.initState();
    services = apiService.fetchServices();
  }

  // Open Service Dialog for Add/Edit
  void _openServiceDialog({Datum? service, int? index}) {
    TextEditingController nameController =
        TextEditingController(text: service?.name ?? '');
    TextEditingController codecontroller =
        TextEditingController(text: service?.code ?? '');
    TextEditingController descriptionController =
        TextEditingController(text: service?.description ?? '');
    TextEditingController priceController =
        TextEditingController(text: service?.price.toString() ?? '');
    TextEditingController durationController =
        TextEditingController(text: service?.duration.toString() ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(service == null ? 'Add Service' : 'Edit Service'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Service Name'),
                ),
                TextField(
                  controller: codecontroller,
                  decoration: const InputDecoration(labelText: 'Service Code'),
                ),
                TextField(
                  controller: descriptionController,
                  decoration: const InputDecoration(labelText: 'Description'),
                ),
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: 'Price'),
                ),
                TextField(
                  controller: durationController,
                  keyboardType: TextInputType.number,
                  decoration:
                      const InputDecoration(labelText: 'Duration (min)'),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () async {
                if (nameController.text.isEmpty ||
                    priceController.text.isEmpty ||
                    durationController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please fill all fields')),
                  );
                  return;
                }

                Map<String, dynamic> newService = {
                  'name': nameController.text,
                  'description': descriptionController.text,
                  'price': double.parse(priceController.text),
                  'duration': int.parse(durationController.text),
                  'code': codecontroller.text,
                  'icon': "lib/assets/images/haircut.png",
                  'status': 1,
                };
                Future<void> createService() async {
                  try {
                    // Convert the map to the Services object
                    Services service = Services.fromJson(newService);

                    // Assign the created service to the 'services' future (if needed)
                    setState(() {
                      services = Future.value(
                          service); // You can use Future.value to wrap the service object in a Future
                    });

                    // Handle any additional logic, like API calls if necessary
                  } catch (e) {
                    // Handle error if any
                    print('Error    eeeeeee: $e.toString()');

                    //Error in the above code is that the newService

                    //////------------------------------------------------------------------------------------
                    //////------------------------------------------------------------------------------------
                    //////------------------------------------------------------------------------------------
                  }
                }

                try {
                  // setState(() {
                  //   services = apiService.fetchServices();
                  // });

                  createService();

                  if (service == null) {
                    // Add New Service
                    String createdService =
                        await ApiService().createService(newService);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Service created successfully')),
                    );

                    Navigator.pop(context);
                  } else {
                    // Update Existing Service
                    newService['id'] = service.id;
                    await ApiService().updateService(service.id!, newService);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Service updated successfully')),
                    );
                    Navigator.pop(context);

                    // setState(() {
                    //     services[index!] = newService; // Update UI with edited service

                    //   });
                  }
                  // } else {
                  // EDIT: Call API to update service
                  //   newService['id'] = service['id'];
                  //   Map<String, dynamic> updatedService = await ApiService()
                  //       .updateService(service['id'], newService);

                  //   setState(() {
                  //     services[index!] =
                  //         updatedService; // Update UI with edited service
                  //     isLoading = false;
                  //   });
                  //   ScaffoldMessenger.of(context).showSnackBar(
                  //     const SnackBar(
                  //         content: Text('Service updated successfully')),
                  //   );
                  //   Navigator.pop(context);
                  // }
                } catch (e) {
                  setState(() {});
                  print(e);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: $e')),
                  );

                  //There is an error in the above code. The error is in the commented code.
                  //if i uncomment it then it will show an error of type error in the code.
                  //============================================================================================================
                  //============================================================================================================
                  //============================================================================================================
                }
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _toggleSelection(int serviceId) {
    setState(() {
      if (selectedServices.contains(serviceId)) {
        selectedServices.remove(serviceId);
      } else {
        selectedServices.add(serviceId);
      }
    });
  }

  // Delete Selected Services
  void _deleteSelectedServices() async {
    setState(() {
      // Show loading indicator
    });

    try {
      for (var serviceId in selectedServices) {
        // Delete service via API
        String message = await ApiService().deleteService(serviceid: serviceId);
        print('Service deleted: $message');
      }

      setState(() {
        selectedServices.clear();
        isDeleteMode = false;
        services = apiService.fetchServices(); // Refetch services here
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Selected services deleted successfully')),
      );
    } catch (e) {
      print('Error during service deletion: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Services',
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontSize: 17),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _openServiceDialog,
          ),
        ],
      ),
      body: FutureBuilder<Services>(
        future: services,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Column(
                children: [
                  Text('Failed to load services:'),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        services = apiService.fetchServices();
                      });
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (snapshot.data!.data.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Iconsax.empty_wallet, size: 100),
                  const SizedBox(height: 10),
                  const Text('No services found'),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: snapshot.data!.data.length,
            itemBuilder: (context, index) {
              Datum service = snapshot.data!.data[index];
              return ListTile(
                onTap: () {
                  if (isDeleteMode) {
                    _toggleSelection(service.id!);
                  } else {
                    _openServiceDialog(service: service, index: index);
                  }
                },
                onLongPress: () {
                  setState(() {
                    isDeleteMode = true;
                    selectedServices.add(service.id!);
                  });
                },
                leading: CircleAvatar(
                  backgroundImage: AssetImage('lib/assets/images/haircut.png'),
                ),
                title: Text(service.name),
                subtitle: Text(
                  '₹${service.price} | ${service.duration} min',
                ),
                trailing: isDeleteMode
                    ? selectedServices.contains(service.id)
                        ? const Icon(Icons.check_circle, color: Colors.green)
                        : const Icon(Icons.circle_outlined)
                    : null,
              );
            },
          );
        },
      ),
      bottomNavigationBar: isDeleteMode
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Cancel",
                      icon: Icons.safety_check,
                      onPressed: () {
                        setState(() {
                          isDeleteMode = false;
                          selectedServices.clear();
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: CustomElevatedButton(
                      text: "Delete",
                      icon: Iconsax.trash,
                      onPressed: _deleteSelectedServices,
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
