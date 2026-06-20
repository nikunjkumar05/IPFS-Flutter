import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:mopro_flutter_bindings/mopro_flutter_bindings.dart';

class ZkScreen extends StatefulWidget {
  const ZkScreen({super.key});
  @override
  State<ZkScreen> createState() => _ZkScreenState();
}

class _ZkScreenState extends State<ZkScreen> {
  final _controllerA = TextEditingController(text: '5');
  final _controllerB = TextEditingController(text: '3');
  CircomProofResult? _proofResult;
  bool? _isValid;
  bool _isWorking = false;
  String _output = '';

  Future<String> _copyAssetToFileSystem(String assetPath) async {
    final byteData = await rootBundle.load(assetPath);
    final directory = await getApplicationDocumentsDirectory();
    final filename = assetPath.split('/').last;
    final file = File('${directory.path}/$filename');
    await file.writeAsBytes(byteData.buffer.asUint8List());
    return file.path;
  }

  Future<void> _generateProof() async {
    if (_controllerA.text.isEmpty || _controllerB.text.isEmpty || _isWorking) return;
    setState(() {
      _isWorking = true;
      _output = 'Generating proof...';
      _isValid = null;
    });
    try {
      final inputs = '{"a":["${_controllerA.text}"],"b":["${_controllerB.text}"]}';
      final zkeyPath = await _copyAssetToFileSystem('assets/multiplier2_final.zkey');
      final graphPath = await _copyAssetToFileSystem('assets/multiplier2.bin');
      final result = await circomProve(
        graphPath: graphPath,
        inputs: inputs,
        zkeyPath: zkeyPath,
      );
      setState(() {
        _proofResult = result;
        _output = 'Proof generated!\n\nProof: ${result.proof}\n\nInputs: ${result.inputs}';
      });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _isWorking = false; });
    }
  }

  Future<void> _verifyProof() async {
    if (_proofResult == null || _isWorking) return;
    setState(() {
      _isWorking = true;
      _output = 'Verifying proof...';
    });
    try {
      final zkeyPath = await _copyAssetToFileSystem('assets/multiplier2_final.zkey');
      final valid = await verifyCircomProof(
        zkeyPath: zkeyPath,
        proofResult: _proofResult!,
        proofLib: ProofLib.arkworks,
      );
      setState(() {
        _isValid = valid;
        _output = 'Verification result: ${valid ? "VALID" : "INVALID"}';
      });
    } catch (e) {
      setState(() { _output = 'Error: $e'; });
    } finally {
      setState(() { _isWorking = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ZK Proof (Mopro + Circom)')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _controllerA,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input a (public)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controllerB,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Input b (private)',
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _isWorking ? null : _generateProof,
                    icon: _isWorking
                        ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                        : const Icon(Icons.lock, size: 16),
                    label: const Text('Prove'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: (_isWorking || _proofResult == null) ? null : _verifyProof,
                    icon: const Icon(Icons.check_circle, size: 16),
                    label: const Text('Verify'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            if (_isValid != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  _isValid! ? 'Proof is VALID' : 'Proof is INVALID',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: _isValid! ? Colors.green : Colors.red,
                  ),
                ),
              ),
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
    _controllerA.dispose();
    _controllerB.dispose();
    super.dispose();
  }
}
