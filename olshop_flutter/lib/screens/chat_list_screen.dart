import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class ChatListScreen extends StatelessWidget {
  const ChatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> chats = [
      {
        "name": "Admin GamUp Store",
        "lastMessage": "Silakan chat jika ada pertanyaan!",
        "avatar": "assets/images/admin2.png",
        "time": "Sekarang"
      },
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo.shade900,
        elevation: 0.8,
        title: const Text(
          'Chat Admin',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, letterSpacing: 0.7),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.grey.shade100,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 14),
          itemCount: chats.length,
          separatorBuilder: (_, __) => const SizedBox(height: 14),
          itemBuilder: (context, i) {
            final chat = chats[i];
            return Material(
              elevation: 2.5,
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
              child: InkWell(
                borderRadius: BorderRadius.circular(20),
                splashColor: Colors.indigo.shade100,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChatDetailScreen()),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
                  child: Row(
                    children: [
                      ClipOval(
                        child: Image.asset(
                          chat["avatar"],
                          width: 52,
                          height: 52,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 18),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chat["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 17,
                                letterSpacing: 0.3,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              chat["lastMessage"],
                              style: TextStyle(
                                color: Colors.indigo.shade400,
                                fontSize: 15,
                                overflow: TextOverflow.ellipsis,
                              ),
                              maxLines: 1,
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            chat["time"],
                            style: TextStyle(
                              color: Colors.indigo.shade400,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 8),
                          // Bubble new message (dummy, bisa dihilangkan kalau ga perlu)
                          // Container(
                          //   padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          //   decoration: BoxDecoration(
                          //     color: Colors.indigo.shade700,
                          //     borderRadius: BorderRadius.circular(8),
                          //   ),
                          //   child: const Text(
                          //     "1",
                          //     style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          //   ),
                          // ),
                        ],
                      ),
                      const Icon(Icons.arrow_forward_ios_rounded, color: Colors.grey, size: 18),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
