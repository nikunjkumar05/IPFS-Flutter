import 'package:flutter/material.dart';
import 'package:dart_ipfs_client/dart_ipfs_client.dart';
import '../config.dart';

class GetScreen extends StatefulWidget {
  const GetScreen({super.key});
  @override
  State<GetScreen> createState() => _GetScreenState();
}

class _GetScreenState extends State<GetScreen> {
  final _controller = TextEditingController(text: 'Qmf1rtki74jvYmGeqaaV51hzeiaa6DyWc98fzDiuPatzyy');
  String _output = '';
  bool _loading = false;

  Future<void> _get() async {
    setState(() { _loading = true; _output = 'Downloading...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.get(_controller.text);
      setState(() { _output = res.body?.body ?? '(empty)'; });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ipfs.get()')),
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
              onPressed: _loading ? null : _get,
              icon: _loading ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2)) : const Icon(Icons.save_alt),
              label: const Text('Get'),
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
