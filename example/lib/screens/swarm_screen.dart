import 'package:flutter/material.dart';
import 'package:dart_ipfs_client/dart_ipfs_client.dart';
import '../config.dart';

class SwarmScreen extends StatefulWidget {
  const SwarmScreen({super.key});
  @override
  State<SwarmScreen> createState() => _SwarmScreenState();
}

class _SwarmScreenState extends State<SwarmScreen> {
  final _peerController = TextEditingController(
    text: '/ip4/147.75.100.9/tcp/4001/p2p/Qmbut9Ywz9YEDrz8ySBSgWyJk41Uvm2QJPhwDJzJyGFsD6',
  );
  String _output = '';
  bool _loading = false;

  Future<void> _connect() async {
    setState(() { _loading = true; _output = 'Connecting...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.swarmConnect(_peerController.text);
      setState(() { _output = 'Connected: ${res.body?.message ?? "OK"}'; });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _disconnect() async {
    setState(() { _loading = true; _output = 'Disconnecting...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.swarmDisconnect(_peerController.text);
      setState(() { _output = 'Disconnected: ${res.body?.message ?? "OK"}'; });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ipfs.swarm')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _peerController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Peer multiaddr',
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _loading ? null : _connect,
                    icon: const Icon(Icons.link),
                    label: const Text('Connect'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _loading ? null : _disconnect,
                    icon: const Icon(Icons.link_off),
                    label: const Text('Disconnect'),
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
    _peerController.dispose();
    super.dispose();
  }
}
