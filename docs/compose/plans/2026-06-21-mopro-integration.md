# Mopro SDK Integration Plan

> [!NOTE]
> This document may not reflect the current implementation.
> See the final report for up-to-date state:
> [Final Report](../reports/mopro-integration.md)

> **For agentic workers:** REQUIRED SUB-SKILL: Use compose:subagent (recommended) or compose:execute to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the locally-generated `circom_flutter` package with official mopro SDK bindings (`mopro_flutter_bindings`), eliminating the local path dependency and aligning with the zkmopro project structure.

**Architecture:** Use `mopro construct` to generate fresh Flutter bindings with the circom adapter. Copy the generated `mopro_flutter_bindings/` into the project root. Update the example app to import from the new package. Archive the old `circom_flutter/` directory.

**Tech Stack:** mopro CLI v0.3.6, flutter_rust_bridge 2.11.1, circom-prover (zkmopro), Dart/Flutter

---

## File Structure

| Action | File | Purpose |
|--------|------|---------|
| Create | `mopro_flutter_bindings/` | Generated mopro Flutter bindings (via `mopro construct`) |
| Create | `mopro_flutter_bindings/pubspec.yaml` | Package definition for the new bindings |
| Create | `mopro_flutter_bindings/rust/Cargo.toml` | Rust dependencies using official circom-prover |
| Modify | `example/pubspec.yaml` | Change dependency from `circom_flutter` to `mopro_flutter_bindings` |
| Modify | `example/lib/main.dart` | Update import path |
| Modify | `example/lib/screens/zk_screen.dart` | Update import path |
| Archive | `circom_flutter/` | Old local bindings (move to `.archive/` or delete) |

---

### Task 1: Generate Fresh Mopro Bindings

**Covers:** Core integration — creates the official mopro Flutter bindings

**Files:**
- Create: `mopro_flutter_bindings/` (entire directory via mopro CLI)

- [ ] **Step 1: Create a temporary directory and run mopro construct**

```bash
mkdir C:\Users\sange\IPFS-Flutter\tmp_mopro
cd C:\Users\sange\IPFS-Flutter\tmp_mopro
mopro construct --adapter circom --project-name mopro_flutter_bindings --framework flutter --no-auto-update
```

This will:
- Initialize a circom adapter project
- Build Flutter bindings
- Generate `mopro_flutter_bindings/` directory

- [ ] **Step 2: Verify the generated bindings exist**

```bash
ls C:\Users\sange\IPFS-Flutter\tmp_mopro\mopro_flutter_bindings
```

Expected: Directory contains `pubspec.yaml`, `lib/`, `rust/`, etc.

- [ ] **Step 3: Copy the generated bindings to the project root**

```bash
xcopy /E /I C:\Users\sange\IPFS-Flutter\tmp_mopro\mopro_flutter_bindings C:\Users\sange\IPFS-Flutter\mopro_flutter_bindings
```

- [ ] **Step 4: Clean up the temporary directory**

```bash
rmdir /S /Q C:\Users\sange\IPFS-Flutter\tmp_mopro
```

- [ ] **Step 5: Verify the new bindings structure**

Check that `mopro_flutter_bindings/lib/src/rust/third_party/` contains the generated binding files (similar to what `circom_flutter` had).

---

### Task 2: Update Example App Dependencies

**Covers:** Wiring the example app to use the new mopro bindings

**Files:**
- Modify: `example/pubspec.yaml:15-16`

- [ ] **Step 1: Update `example/pubspec.yaml` dependency**

Change:
```yaml
  circom_flutter:
    path: ../circom_flutter
```

To:
```yaml
  mopro_flutter_bindings:
    path: ../mopro_flutter_bindings
```

- [ ] **Step 2: Run `flutter pub get` in the example directory**

```bash
cd C:\Users\sange\IPFS-Flutter\example
flutter pub get
```

Expected: No errors about missing packages.

---

### Task 3: Update Example App Imports

**Covers:** Updating all import statements to use the new package name

**Files:**
- Modify: `example/lib/main.dart:2`
- Modify: `example/lib/screens/zk_screen.dart:5`

- [ ] **Step 1: Update `example/lib/main.dart` import**

Change:
```dart
import 'package:circom_flutter/src/rust/frb_generated.dart';
```

To:
```dart
import 'package:mopro_flutter_bindings/src/rust/frb_generated.dart';
```

- [ ] **Step 2: Update `example/lib/screens/zk_screen.dart` import**

Change:
```dart
import 'package:circom_flutter/src/rust/third_party/circom_prover_bindings.dart';
```

To:
```dart
import 'package:mopro_flutter_bindings/src/rust/third_party/mopro_flutter_bindings.dart';
```

Note: The third_party file name may differ in the generated bindings. Check the actual filename in `mopro_flutter_bindings/lib/src/rust/third_party/` and adjust accordingly.

- [ ] **Step 3: Verify no other files import from circom_flutter**

```bash
cd C:\Users\sange\IPFS-Flutter
grep -r "circom_flutter" example/lib/
```

Expected: No matches.

---

### Task 4: Archive Old circom_flutter

**Covers:** Cleanup of the old locally-generated package

**Files:**
- Archive: `circom_flutter/` → `.archive/circom_flutter/`

- [ ] **Step 1: Create archive directory and move circom_flutter**

```bash
mkdir C:\Users\sange\IPFS-Flutter\.archive
xcopy /E /I C:\Users\sange\IPFS-Flutter\circom_flutter C:\Users\sange\IPFS-Flutter\.archive\circom_flutter
rmdir /S /Q C:\Users\sange\IPFS-Flutter\circom_flutter
```

- [ ] **Step 2: Update `.gitignore` to exclude archive**

Add to `.gitignore`:
```
.archive/
```

---

### Task 5: Verify Integration

**Covers:** End-to-end verification that the new bindings work

**Files:**
- None (verification only)

- [ ] **Step 1: Run `flutter pub get` in example**

```bash
cd C:\Users\sange\IPFS-Flutter\example
flutter pub get
```

Expected: Success, no errors.

- [ ] **Step 2: Check for compilation errors**

```bash
cd C:\Users\sange\IPFS-Flutter\example
flutter analyze
```

Expected: No errors (warnings acceptable).

- [ ] **Step 3: Verify the ZK screen imports resolve**

Confirm that `example/lib/screens/zk_screen.dart` can find:
- `CircomProofResult`
- `ProofLib`
- `circomProve`
- `verifyCircomProof`

These should all be available from the new `mopro_flutter_bindings` package.

---

### Task 6: Update Documentation

**Covers:** Keeping README and docs consistent

**Files:**
- Modify: `README.md` (if it references circom_flutter)

- [ ] **Step 1: Check README for circom_flutter references**

```bash
grep -i "circom_flutter" C:\Users\sange\IPFS-Flutter\README.md
```

- [ ] **Step 2: Update any references to use mopro_flutter_bindings**

If found, replace `circom_flutter` with `mopro_flutter_bindings` in the README.
