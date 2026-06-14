import 'package:flutter/material.dart';
import 'package:dart_ipfs_client/dart_ipfs_client.dart';
import '../config.dart';

class IdScreen extends StatefulWidget {
  const IdScreen({super.key});
  @override
  State<IdScreen> createState() => _IdScreenState();
}

class _IdScreenState extends State<IdScreen> {
  String _output = 'Tap "Fetch ID" to query the IPFS node.';
  bool _loading = false;

  Future<void> _fetchId() async {
    setState(() { _loading = true; _output = 'Querying...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.id();
      final id = res.body;
      setState(() {
        _output = 'ID: ${id?.id}\n'
            'Agent: ${id?.agentVersion}\n'
            'Protocol: ${id?.protocolVersion}\n'
            'Public Key: ${id?.publicKey}\n'
            'Addresses (${id?.addresses?.length ?? 0}):\n'
            '${id?.addresses?.map((a) => '  $a').join('\n') ?? ''}';
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
      appBar: AppBar(title: const Text('ipfs.id()')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton.icon(
              onPressed: _loading ? null : _fetchId,
              icon: _loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.search),
              label: const Text('Fetch ID'),
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
}
