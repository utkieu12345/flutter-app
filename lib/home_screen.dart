import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _tenSPController = TextEditingController();
  final TextEditingController _loaiController = TextEditingController();
  final TextEditingController _giaController = TextEditingController();

  final CollectionReference _sanpham =
      FirebaseFirestore.instance.collection("sanpham");

  String? _currentProductId; // Biến để lưu ID của sản phẩm hiện tại

  void _addOrUpdateSanpham() {
    if (_currentProductId == null) {
      // Thêm sản phẩm mới
      _sanpham.add({
        'TenSP': _tenSPController.text,
        'Gia': _giaController.text,
        'Loai': _loaiController.text,
      });
    } else {
      // Cập nhật sản phẩm
      _sanpham.doc(_currentProductId).update({
        'TenSP': _tenSPController.text,
        'Loai': _loaiController.text,
        'Gia': _giaController.text,
      });
    }

    // Xóa nội dung các trường
    _tenSPController.clear();
    _loaiController.clear();
    _giaController.clear();

    setState(() {
      _currentProductId = null; // Đặt lại ID sản phẩm hiện tại
    });
  }

  void _editSanpham(String id, String tenSP, String loai, String gia) {
    setState(() {
      _currentProductId = id; // Lưu ID sản phẩm hiện tại
      _tenSPController.text = tenSP;
      _loaiController.text = loai;
      _giaController.text = gia;
    });
  }

  void _deleteSanpham(String id) {
    _sanpham.doc(id).delete();
  }

  @override
 Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dữ Liệu Sản Phẩm"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              controller: _tenSPController,
              decoration: const InputDecoration(labelText: "Nhập tên sản phẩm"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _loaiController,
              decoration: const InputDecoration(labelText: "Nhập loại sản phẩm"),
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _giaController,
              decoration: const InputDecoration(labelText: "Nhập giá sản phẩm"),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _addOrUpdateSanpham,
              child: Text(_currentProductId == null ? "Thêm Sản Phẩm" : "Chỉnh sửa Sản Phẩm"),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: StreamBuilder(
                stream: _sanpham.snapshots(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var sanpham = snapshot.data!.docs[index];
                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Tên sản phẩm: ${sanpham['TenSP']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Loại: ${sanpham['Loai']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'Giá: ${sanpham['Gia']}',
                                      style: const TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      _deleteSanpham(sanpham.id);
                                    },
                                    icon: const Icon(Icons.delete, color: Colors.red),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      _editSanpham(
                                          sanpham.id,
                                          sanpham['TenSP'],
                                          sanpham['Loai'],
                                          sanpham['Gia'].toString());
                                    },
                                    icon: const Icon(Icons.edit, color: Colors.blue),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
 }
}