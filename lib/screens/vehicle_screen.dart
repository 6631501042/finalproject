import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/vehicle_models.dart';
import '../widgets/section_title.dart';

class VehicleScreen extends StatefulWidget {
  const VehicleScreen({super.key});

  @override
  State<VehicleScreen> createState() => _VehicleScreenState();
}

class _VehicleScreenState extends State<VehicleScreen> {
  List<Vehicle> vehicles = [];

  @override
  void initState() {
    super.initState();
    _loadVehicles();
  }

  Future<void> _loadVehicles() async {
    final prefs = await SharedPreferences.getInstance();

    final data = prefs.getStringList('vehicles') ?? [];

    vehicles = data.map((e) {
      final json = jsonDecode(e);

      return Vehicle(
        id: json['id'],
        model: json['model'],
        licensePlate: json['licensePlate'],
        frontImage: json['frontImage'],
        backImage: json['backImage'],
        leftImage: json['leftImage'],
        rightImage: json['rightImage'],
        licenceplateImage: json['licenceplateImage'],
      );
    }).toList();

    setState(() {});
  }

  Future<void> _saveVehicles() async {
    final prefs = await SharedPreferences.getInstance();

    final data = vehicles.map((v) {
      return jsonEncode({
        'id': v.id,
        'model': v.model,
        'licensePlate': v.licensePlate,
        'frontImage': v.frontImage,
        'backImage': v.backImage,
        'leftImage': v.leftImage,
        'rightImage': v.rightImage,
        'licenceplateImage': v.licenceplateImage,
      });
    }).toList();

    await prefs.setStringList('vehicles', data);
  }

  Future<void> _deleteVehicle(int index) async {
    vehicles.removeAt(index);
    await _saveVehicles();
    setState(() {});
  }

  Future<void> _openVehicleForm({Vehicle? vehicle}) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => VehicleFormScreen(
          vehicle: vehicle,
          onSave: (savedVehicle) async {
            final index = vehicles.indexWhere((e) => e.id == savedVehicle.id);

            if (index == -1) {
              vehicles.add(savedVehicle);
            } else {
              vehicles[index] = savedVehicle;
            }

            await _saveVehicles();

            setState(() {});
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Profile', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
        actions: [
          IconButton(
            icon: const Icon(Icons.add_circle_outline),
            onPressed: () => _openVehicleForm(),
          ),
        ],
      ),
      body: vehicles.isEmpty
          ? const Center(child: Text('No vehicle added'))
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: vehicles.length,
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];

                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    leading: vehicle.frontImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              File(vehicle.frontImage!),
                              width: 55,
                              height: 55,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Icon(Icons.motorcycle),
                    title: Text(vehicle.model),
                    subtitle: Text(vehicle.licensePlate),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete_outline),
                      onPressed: () => _deleteVehicle(index),
                    ),
                    onTap: () {
                      _openVehicleForm(vehicle: vehicle);
                    },
                  ),
                );
              },
            ),
    );
  }
}

class VehicleFormScreen extends StatefulWidget {
  const VehicleFormScreen({super.key, this.vehicle, required this.onSave});

  final Vehicle? vehicle;
  final Function(Vehicle) onSave;

  @override
  State<VehicleFormScreen> createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends State<VehicleFormScreen> {
  final picker = ImagePicker();

  late TextEditingController modelController;
  late TextEditingController plateController;

  String? front;
  String? back;
  String? left;
  String? right;
  String? licenceplate;
  @override
  void initState() {
    super.initState();

    modelController = TextEditingController(text: widget.vehicle?.model ?? '');

    plateController = TextEditingController(
      text: widget.vehicle?.licensePlate ?? '',
    );

    front = widget.vehicle?.frontImage;
    back = widget.vehicle?.backImage;
    left = widget.vehicle?.leftImage;
    right = widget.vehicle?.rightImage;
    licenceplate = widget.vehicle?.licenceplateImage;
  }

  Future<void> pickImage(String angle) async {
    final file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (file == null) return;

    setState(() {
      switch (angle) {
        case 'front':
          front = file.path;
          break;
        case 'back':
          back = file.path;
          break;
        case 'left':
          left = file.path;
          break;
        case 'right':
          right = file.path;
          break;
        case 'licenceplate':
          licenceplate = file.path;
          break;
      }
    });
  }

  void saveVehicle() {
    if (modelController.text.isEmpty ||
        plateController.text.isEmpty ||
        front == null ||
        back == null ||
        left == null ||
        right == null ||
        licenceplate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all information')),
      );
      return;
    }

    final vehicle = Vehicle(
      id:
          widget.vehicle?.id ??
          DateTime.now().millisecondsSinceEpoch.toString(),
      model: modelController.text,
      licensePlate: plateController.text,
      frontImage: front,
      backImage: back,
      leftImage: left,
      rightImage: right,
      licenceplateImage: licenceplate,
    );

    widget.onSave(vehicle);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.vehicle == null ? 'Add Vehicle' : 'Edit Vehicle', style: const TextStyle(fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionTitle(
            title: 'Vehicle Profile',
            actionLabel: '4 angles',
            icon: Icons.two_wheeler_outlined,
            color: Theme.of(context).colorScheme.primary,
          ),

          const SizedBox(height: 16),

          TextField(
            controller: modelController,
            decoration: const InputDecoration(
              labelText: 'Vehicle model',
              prefixIcon: Icon(Icons.motorcycle_outlined), // motorcycle_outlined
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: plateController,
            decoration: const InputDecoration(
              labelText: 'Licence plate',
              prefixIcon: Icon(Icons.confirmation_number_outlined),
            ),
          ),

          const SizedBox(height: 16),

          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _PhotoTile(
                title: 'Front',
                imagePath: front,
                onTap: () => pickImage('front'),
              ),
              _PhotoTile(
                title: 'Back',
                imagePath: back,
                onTap: () => pickImage('back'),
              ),
              _PhotoTile(
                title: 'Left',
                imagePath: left,
                onTap: () => pickImage('left'),
              ),
              _PhotoTile(
                title: 'Right',
                imagePath: right,
                onTap: () => pickImage('right'),
              ),
              _PhotoTile(
                title: 'Licence Plate',
                imagePath: licenceplate,
                onTap: () => pickImage('licenceplate'),
              ),
            ],
          ),

          const SizedBox(height: 24),

          FilledButton.icon(
            onPressed: saveVehicle,
            icon: const Icon(Icons.save_outlined),
            label: const Text('Save Vehicle'),
          ),
        ],
      ),
    );
  }
}

class _PhotoTile extends StatelessWidget {
  const _PhotoTile({
    required this.title,
    required this.imagePath,
    required this.onTap,
  });

  final String title;
  final String? imagePath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width - 44) / 2,
      child: InkWell(
        onTap: onTap,
        child: Card(
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: double.infinity,
                child: imagePath == null
                    ? const Icon(Icons.add_a_photo_outlined, size: 40)
                    : Image.file(File(imagePath!), fit: BoxFit.cover),
              ),
              Padding(padding: const EdgeInsets.all(8), child: Text(title)),
            ],
          ),
        ),
      ),
    );
  }
}
