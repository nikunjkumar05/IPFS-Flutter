import 'package:flutter/material.dart';
import 'package:dart_ipfs_client/dart_ipfs_client.dart';
import '../config.dart';

class LsScreen extends StatefulWidget {
  const LsScreen({super.key});
  @override
  State<LsScreen> createState() => _LsScreenState();
}

class _LsScreenState extends State<LsScreen> {
  final _controller = TextEditingController(text: 'Qmf1rtki74jvYmGeqaaV51hzeiaa6DyWc98fzDiuPatzyy');
  String _output = '';
  bool _loading = false;

  Future<void> _ls() async {
    setState(() { _loading = true; _output = 'Listing...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.ls(_controller.text);
      final objects = res.body?.objects;
      if (objects == null || objects.isEmpty) {
        setState(() { _output = 'No objects found'; });
        return;
      }
      final buf = StringBuffer();
      for (final obj in objects) {
        buf.writeln('Hash: ${obj.hash}');
        if (obj.links != null) {
          for (final link in obj.links!) {
            buf.writeln('  ${link.name} (${link.type == 1 ? "dir" : "file"}) - ${link.size} bytes - ${link.hash}');
          }
        }
      }
      setState(() { _output = buf.toString(); });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ipfs.ls()')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'CID',
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _loading ? null : _ls,
              icon: _loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.list),
              label: const Text('List'),
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
