import 'package:flutter/material.dart';
import 'package:dart_ipfs_client/dart_ipfs_client.dart';
import '../config.dart';

class PubSubScreen extends StatefulWidget {
  const PubSubScreen({super.key});
  @override
  State<PubSubScreen> createState() => _PubSubScreenState();
}

class _PubSubScreenState extends State<PubSubScreen> {
  final _topicController = TextEditingController(text: 'flutter-ipfs-demo');
  final _messageController = TextEditingController(text: 'hello');
  String _output = '';
  bool _loading = false;

  Future<void> _publish() async {
    setState(() { _loading = true; _output = 'Publishing...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      await ipfs.pubsubPublish(_topicController.text, _messageController.text);
      setState(() { _output = 'Published "${_messageController.text}" to ${_topicController.text}'; });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _subscribe() async {
    setState(() { _loading = true; _output = 'Subscribing to ${_topicController.text}...\nWaiting for messages...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.pubsubSubscribe(_topicController.text);
      setState(() { _output = 'Subscribed to ${_topicController.text}\nResponse: ${res.body ?? '(empty)'}'; });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _loading = false; });
    }
  }

  Future<void> _peers() async {
    setState(() { _loading = true; _output = 'Fetching peers...'; });
    try {
      final ipfs = Ipfs(url: ipfsUrl);
      final res = await ipfs.pubsubPeers(_topicController.text);
      final peers = res.body?.strings;
      setState(() {
        _output = 'Peers (${peers?.length ?? 0}):\n'
            '${peers?.map((p) => '  $p').join('\n') ?? '  None'}';
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
      appBar: AppBar(title: const Text('ipfs.pubsub')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _topicController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Topic',
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Message',
              ),
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                ElevatedButton.icon(
                  onPressed: _loading ? null : _publish,
                  icon: const Icon(Icons.send, size: 16),
                  label: const Text('Publish'),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _subscribe,
                  icon: const Icon(Icons.subscriptions, size: 16),
                  label: const Text('Subscribe'),
                ),
                ElevatedButton.icon(
                  onPressed: _loading ? null : _peers,
                  icon: const Icon(Icons.people, size: 16),
                  label: const Text('Peers'),
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
    _topicController.dispose();
    _messageController.dispose();
    super.dispose();
  }
}
