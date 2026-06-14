import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dart_ipfs_client/dart_ipfs_client.dart';
import '../config.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});
  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final _controller = TextEditingController(text: 'Hello World!');
  String _output = '';
  bool _loading = false;

  Future<void> _addString() async {
    setState(() { _loading = true; _output = 'Adding...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.add(utf8.encode(_controller.text));
      final body = res.body;
      setState(() {
        _output = 'Hash: ${body?.hash}\n'
            'Name: ${body?.name}\n'
            'Bytes: ${body?.bytes}\n'
            'Size: ${body?.size}';
      });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _addBytes() async {
    setState(() { _loading = true; _output = 'Adding bytes...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final bytes = List<int>.generate(256, (i) => i);
      final res = await ipfs.add(bytes);
      final body = res.body;
      setState(() {
        _output = 'Added 256 bytes\n'
            'Hash: ${body?.hash}\n'
            'Name: ${body?.name}\n'
            'Size: ${body?.size}';
      });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ipfs.add()')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Data to add',
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _loading ? null : _addString,
                    icon: const Icon(Icons.text_fields),
                    label: const Text('Add String'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _loading ? null : _addBytes,
                    icon: const Icon(Icons.memory),
                    label: const Text('Add Bytes'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_output, style: const TextStyle(fontFamily: 'monospace', fontSize: 13)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
