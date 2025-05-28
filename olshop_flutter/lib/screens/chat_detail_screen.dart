import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class ChatDetailScreen extends StatefulWidget {
  const ChatDetailScreen({super.key});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {
      "from": "admin",
      "text": "Halo! Ada yang bisa dibantu?",
      "type": "text",
    },
  ];

  final ScrollController _scrollController = ScrollController();

  bool _isRecording = false;
  bool _vnEnabled = true;
  late AnimationController _recordAnimController;

  // List dummy asset image
  final List<String> assetImages = [
    'assets/images/photos/foto1.jpg',
    'assets/images/photos/foto2.jpg',
    'assets/images/photos/foto3.jpg',
  ];

  // List dummy pdf asset
  final List<String> assetPdfs = [
    'assets/pdf/contoh1.pdf',
    'assets/pdf/contoh2.pdf',
    'assets/pdf/contoh3.pdf',
  ];

  @override
  void initState() {
    super.initState();
    _recordAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    )..stop();
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    _recordAnimController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (_controller.text.trim().isNotEmpty) {
      setState(() {
        messages.add({
          "from": "user",
          "text": _controller.text.trim(),
          "type": "text",
        });
        _controller.clear();
      });
      Future.delayed(const Duration(milliseconds: 100), () {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
          );
        }
      });
    }
  }

  void _showAttachmentMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      backgroundColor: Colors.white,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 22, horizontal: 24),
          child: Wrap(
            runSpacing: 12,
            children: [
              Center(
                child: Container(
                  width: 48,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  margin: const EdgeInsets.only(bottom: 14),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _AttachmentButton(
                    icon: Icons.insert_drive_file_rounded,
                    label: "Dokumen",
                    color: Colors.indigo.shade700,
                    onTap: () {
                      Navigator.pop(context);
                      _showAssetPdfPicker();
                    },
                  ),
                  _AttachmentButton(
                    icon: Icons.photo_rounded,
                    label: "Foto",
                    color: Colors.pink.shade400,
                    onTap: () {
                      Navigator.pop(context);
                      _showAssetPhotoPicker();
                    },
                  ),
                  _AttachmentButton(
                    icon: Icons.mic_rounded,
                    label: "Suara",
                    color: Colors.green.shade400,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  _AttachmentButton(
                    icon: Icons.more_horiz,
                    label: "Lainnya",
                    color: Colors.orange.shade400,
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void _showAssetPhotoPicker() async {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Pilih Foto dari Assets",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                itemCount: assetImages.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (ctx, i) {
                  final img = assetImages[i];
                  return GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                      _sendImageFromAssets(img);
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(
                        img,
                        fit: BoxFit.cover,
                        height: 80,
                        width: 80,
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _sendImageFromAssets(String path) {
    setState(() {
      messages.add({
        "from": "user",
        "type": "image",
        "image": path,
      });
    });
    _scrollToBottom();
  }

  void _showAssetPdfPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(18),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Pilih Dokumen PDF",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 14),
              ...assetPdfs.map((pdf) {
                final fileName = pdf.split('/').last;
                return ListTile(
                  leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                  title: Text(fileName, style: const TextStyle(fontWeight: FontWeight.w600)),
                  onTap: () {
                    Navigator.pop(context);
                    _sendPdfFromAssets(pdf);
                  },
                );
              }).toList(),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  void _sendPdfFromAssets(String pdfPath) {
    setState(() {
      messages.add({
        "from": "user",
        "type": "pdf",
        "pdf": pdfPath,
      });
    });
    _scrollToBottom();
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 120), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
    });
    _recordAnimController.repeat(reverse: true);
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
    });
    _recordAnimController.stop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text("Voice note (VN) berhasil direkam (dummy)"),
        backgroundColor: Colors.indigo.shade900,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
        duration: const Duration(seconds: 2),
        elevation: 6,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Color adminBubble = Colors.indigo.shade100;
    final Color userBubble = Colors.indigo.shade700;
    final Color inputBg = Colors.white;
    final Color sendBtn = Colors.indigo.shade900;
    final Color vnBtn = Colors.deepOrange;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            ClipOval(
              child: Image.asset(
                'assets/images/admin2.png',
                width: 38,
                height: 38,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            const Text('Admin GamUp'),
          ],
        ),
        backgroundColor: Colors.indigo.shade900,
        elevation: 1.2,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                const Text("VN", style: TextStyle(fontWeight: FontWeight.w600)),
                Switch(
                  value: _vnEnabled,
                  activeColor: Colors.deepOrange,
                  onChanged: (val) {
                    setState(() {
                      _vnEnabled = val;
                      if (!_vnEnabled && _isRecording) {
                        _stopRecording();
                      }
                    });
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  padding: const EdgeInsets.fromLTRB(16, 18, 16, 10),
                  itemCount: messages.length,
                  itemBuilder: (context, i) {
                    final msg = messages[i];
                    final isUser = msg["from"] == "user";
                    final bool isAdminFirst = i == 0 && msg["from"] == "admin";
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                        mainAxisAlignment: isUser
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          if (isAdminFirst)
                            Padding(
                              padding: const EdgeInsets.only(right: 7),
                              child: ClipOval(
                                child: Image.asset(
                                  'assets/images/admin2.png',
                                  width: 34,
                                  height: 34,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          Flexible(
                            child: Builder(
                              builder: (_) {
                                if (msg["type"] == "image") {
                                  return Container(
                                    padding: const EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                      color: isUser
                                          ? userBubble.withAlpha(38)
                                          : adminBubble.withAlpha(32),
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        msg["image"],
                                        width: 160,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                } else if (msg["type"] == "pdf") {
                                  final pdfPath = msg["pdf"] as String;
                                  final pdfName = pdfPath.split('/').last;
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => PDFViewerScreen(assetPath: pdfPath),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      margin: const EdgeInsets.only(top: 2, bottom: 2),
                                      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                                      decoration: BoxDecoration(
                                        color: Colors.red.withAlpha(isUser ? 55 : 32),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(color: Colors.red.withAlpha(70)),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          const Icon(Icons.picture_as_pdf, color: Colors.red, size: 30),
                                          const SizedBox(width: 14),
                                          Text(
                                            pdfName,
                                            style: const TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Colors.red,
                                            ),
                                          ),
                                          const SizedBox(width: 6),
                                          const Icon(Icons.open_in_new, size: 18, color: Colors.redAccent),
                                        ],
                                      ),
                                    ),
                                  );
                                } else {
                                  return Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 12),
                                    decoration: BoxDecoration(
                                      color: isUser ? userBubble : adminBubble,
                                      borderRadius: BorderRadius.only(
                                        topLeft: const Radius.circular(18),
                                        topRight: const Radius.circular(18),
                                        bottomLeft:
                                            Radius.circular(isUser ? 18 : 5),
                                        bottomRight:
                                            Radius.circular(isUser ? 5 : 18),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withAlpha((0.06 * 255).round()),
                                          blurRadius: 8,
                                          offset: const Offset(2, 4),
                                        )
                                      ],
                                    ),
                                    child: Text(
                                      msg["text"] ?? "",
                                      style: TextStyle(
                                        color: isUser
                                            ? Colors.white
                                            : Colors.indigo.shade900,
                                        fontSize: 16,
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              if (_isRecording)
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  child: FadeTransition(
                    opacity: Tween(begin: 0.3, end: 1.0).animate(_recordAnimController),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.mic_rounded, color: Colors.redAccent, size: 32),
                        const SizedBox(width: 10),
                        const Text(
                          "Sedang merekam...",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                            fontSize: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: inputBg,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((0.07 * 255).round()),
                      blurRadius: 16,
                      offset: const Offset(0, -4),
                    )
                  ],
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(24),
                    topRight: Radius.circular(24),
                  ),
                ),
                child: Row(
                  children: [
                    Material(
                      color: Colors.grey.shade300,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(Icons.add, color: Colors.indigo, size: 27),
                        splashRadius: 25,
                        tooltip: 'Lampirkan',
                        onPressed: _showAttachmentMenu,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(22),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: TextField(
                          controller: _controller,
                          minLines: 1,
                          maxLines: 3,
                          style: const TextStyle(fontSize: 16),
                          decoration: const InputDecoration(
                            hintText: "Tulis pesan...",
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (_vnEnabled)
                      GestureDetector(
                        onLongPress: _startRecording,
                        onLongPressUp: _stopRecording,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: 45,
                          height: 45,
                          decoration: BoxDecoration(
                            color: _isRecording
                                ? Colors.redAccent.withAlpha(60)
                                : vnBtn.withAlpha((0.13 * 255).round()),
                            shape: BoxShape.circle,
                            boxShadow: _isRecording
                                ? [
                                    BoxShadow(
                                      color: Colors.redAccent.withAlpha(110),
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            Icons.mic,
                            color: _isRecording ? Colors.redAccent : vnBtn,
                            size: 26,
                          ),
                        ),
                      ),
                    if (_vnEnabled) const SizedBox(width: 6),
                    Material(
                      color: sendBtn,
                      shape: const CircleBorder(),
                      child: IconButton(
                        icon: const Icon(Icons.send, color: Colors.white),
                        onPressed: _sendMessage,
                        splashRadius: 24,
                        tooltip: 'Kirim',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class PDFViewerScreen extends StatelessWidget {
  final String assetPath;
  const PDFViewerScreen({required this.assetPath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(assetPath.split('/').last),
        backgroundColor: Colors.indigo.shade900,
      ),
      body: SfPdfViewer.asset(assetPath),
    );
  }
}

// Widget tombol lampiran
class _AttachmentButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AttachmentButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: color.withAlpha((0.14 * 255).round()),
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(14),
              child: Icon(icon, color: color, size: 30),
            ),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: color, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}
