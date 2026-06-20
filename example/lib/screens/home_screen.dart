import 'package:flutter/material.dart';
import 'id_screen.dart';
import 'add_screen.dart';
import 'cat_screen.dart';
import 'get_screen.dart';
import 'ls_screen.dart';
import 'swarm_screen.dart';
import 'pubsub_screen.dart';
import 'zk_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final features = [
      _Feature('ID', 'Get IPFS node identity', Icons.info_outline, const IdScreen()),
      _Feature('Add', 'Add data to IPFS', Icons.upload, const AddScreen()),
      _Feature('Cat', 'Retrieve data by CID', Icons.download, const CatScreen()),
      _Feature('Get', 'Download file by CID', Icons.save_alt, const GetScreen()),
      _Feature('Ls', 'List directory contents', Icons.list, const LsScreen()),
      _Feature('Swarm', 'Connect/disconnect peers', Icons.hub, const SwarmScreen()),
      _Feature('PubSub', 'Publish/subscribe messaging', Icons.message, const PubSubScreen()),
      _Feature('ZK Proof', 'Generate & verify ZK proofs', Icons.lock, const ZkScreen()),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('IPFS Flutter Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: features.length,
        itemBuilder: (context, index) {
          final f = features[index];
          return Card(
            child: ListTile(
              leading: Icon(f.icon, size: 32),
              title: Text(f.title, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(f.subtitle),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => f.screen),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Feature {
  final String title;
  final String subtitle;
  final IconData icon;
  final Widget screen;
  _Feature(this.title, this.subtitle, this.icon, this.screen);
}
