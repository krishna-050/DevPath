import 'dart:math' as math;

import 'package:dev_path/controller/ai_controller.dart';
import 'package:dev_path/models/chat_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonalAiScreen extends StatefulWidget {
  const PersonalAiScreen({super.key});

  @override
  State<PersonalAiScreen> createState() => _PersonalAiScreenState();
}

class _PersonalAiScreenState extends State<PersonalAiScreen>
    with TickerProviderStateMixin {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  // ── Use existing controller; create only if not yet registered ──
  final AiController aiController = Get.isRegistered<AiController>()
      ? Get.find<AiController>()
      : Get.put(AiController());

  late final AnimationController _dotAnimController;

  final List<String> _quickPrompts = [
    'Explain Flutter StatefulWidget',
    'Create a TODO app in Flutter',
    'Interview questions for Flutter',
    'What is GetX?',
    'Best learning roadmap',
    'Career guidance',
  ];

  @override
  void initState() {
    super.initState();
    _dotAnimController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();
  }

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _dotAnimController.dispose();
    super.dispose();
  }

  // ── Delegate to existing AiController – no business logic here ──
  Future<void> _sendMessage([String? customText]) async {
    final query = (customText ?? _textController.text).trim();
    if (query.isEmpty || aiController.isTyping.value) return;
    _textController.clear();
    final future = aiController.sendMessage(query);
    _scrollToBottom();
    await future;
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOut,
      );
    });
  }

  // ─────────────────────────────────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF0B1220) : const Color(0xFFF0F6FF);
    final surfaceColor = isDark ? const Color(0xFF172235) : Colors.white;
    final cardBg = isDark ? const Color(0xFF1E293B) : Colors.white;
    final textPrimary = isDark
        ? const Color(0xFFF1F5F9)
        : const Color(0xFF102B50);
    final textSecondary = isDark
        ? const Color(0xFF94A3B8)
        : const Color(0xFF64748B);
    final borderColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFDCE7F1);
    final inputBg = isDark ? const Color(0xFF1E293B) : const Color(0xFFF0F6FF);

    return Scaffold(
      backgroundColor: bgColor,
      // ── AppBar ────────────────────────────────────────────────────────────
      appBar: _buildAppBar(
        isDark,
        surfaceColor,
        textPrimary,
        textSecondary,
        borderColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // ── Scrollable content (hero + suggestions + messages) ──────────
            Expanded(
              child: Obx(() {
                final msgs = aiController.messages;
                final showHero = msgs.length <= 1;

                return ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  itemCount: _listItemCount(msgs, showHero),
                  itemBuilder: (ctx, index) => _listItem(
                    ctx,
                    index,
                    msgs,
                    showHero,
                    isDark,
                    textPrimary,
                    textSecondary,
                    cardBg,
                    borderColor,
                  ),
                );
              }),
            ),

            // ── Typing indicator ────────────────────────────────────────────
            Obx(
              () => aiController.isTyping.value
                  ? _buildTypingIndicator(isDark, cardBg, borderColor)
                  : const SizedBox.shrink(),
            ),

            // ── Input area ──────────────────────────────────────────────────
            _buildInputArea(
              isDark,
              surfaceColor,
              inputBg,
              textPrimary,
              textSecondary,
              borderColor,
            ),
          ],
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // List helpers
  // ─────────────────────────────────────────────────────────────────────────

  int _listItemCount(List<ChatMessage> msgs, bool showHero) {
    return (showHero ? 2 : 0) + msgs.length;
  }

  Widget _listItem(
    BuildContext ctx,
    int index,
    List<ChatMessage> msgs,
    bool showHero,
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    Color cardBg,
    Color borderColor,
  ) {
    if (showHero) {
      if (index == 0) return _buildHeroBanner();
      if (index == 1)
        return _buildSuggestions(
          textPrimary,
          textSecondary,
          cardBg,
          borderColor,
          isDark,
        );
      return _buildMessageBubble(
        msgs[index - 2],
        isDark,
        textPrimary,
        textSecondary,
        cardBg,
        borderColor,
      );
    }
    return _buildMessageBubble(
      msgs[index],
      isDark,
      textPrimary,
      textSecondary,
      cardBg,
      borderColor,
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // AppBar
  // ─────────────────────────────────────────────────────────────────────────

  PreferredSizeWidget _buildAppBar(
    bool isDark,
    Color surfaceColor,
    Color textPrimary,
    Color textSecondary,
    Color borderColor,
  ) {
    final appBarBg = isDark ? const Color(0xFF0D1B2E) : Colors.white;
    final backIconColor = isDark ? Colors.white : textPrimary;
    final titleColor = isDark ? Colors.white : textPrimary;
    final subtitleColor = isDark
        ? const Color(0xFF93C5FD)
        : const Color(0xFF2563EB);
    final proBgColor = isDark
        ? const Color(0xFF1E293B)
        : const Color(0xFFFEF3C7);
    final proBorderColor = isDark
        ? const Color(0xFF334155)
        : const Color(0xFFFDE68A);
    final proTextColor = const Color(0xFFD97706);
    final menuIconColor = isDark ? Colors.white70 : textSecondary;

    return PreferredSize(
      preferredSize: const Size.fromHeight(64),
      child: Container(
        decoration: BoxDecoration(
          color: appBarBg,
          border: Border(
            bottom: BorderSide(
              color: isDark ? const Color(0xFF1E293B) : borderColor,
              width: 1,
            ),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.25 : 0.04),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: SafeArea(
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                // Back button if screen was pushed via Navigator
                if (Navigator.of(context).canPop()) ...[
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: backIconColor,
                      size: 18,
                    ),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    onPressed: () => Navigator.of(context).maybePop(),
                  ),
                  const SizedBox(width: 10),
                ],

                // Learning Path Robot Logo + Title
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E40AF),
                        Color(0xFF2563EB),
                        Color(0xFF60A5FA),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF60A5FA).withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.all(2),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      'assets/images/robot.png',
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.smart_toy_rounded,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Learning Path',
                      style: TextStyle(
                        color: titleColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        letterSpacing: -0.2,
                      ),
                    ),
                    Text(
                      'Personal AI Mentor',
                      style: TextStyle(
                        color: subtitleColor,
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                // Pro badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: proBgColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: proBorderColor),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.workspace_premium_rounded,
                        color: proTextColor,
                        size: 15,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        'Pro',
                        style: TextStyle(
                          color: proTextColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 6),
                // More options
                PopupMenuButton<String>(
                  icon: Icon(
                    Icons.more_vert_rounded,
                    color: menuIconColor,
                    size: 22,
                  ),
                  color: isDark ? const Color(0xFF1E293B) : Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  onSelected: (val) {
                    if (val == 'clear') aiController.clearChat();
                  },
                  itemBuilder: (_) => [
                    PopupMenuItem(
                      value: 'clear',
                      child: Row(
                        children: [
                          Icon(
                            Icons.refresh_rounded,
                            color: menuIconColor,
                            size: 18,
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'Clear Chat',
                            style: TextStyle(color: textPrimary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Hero Banner (All Blue Theme with Robot image)
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildHeroBanner() {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF0F2B5C),
            Color(0xFF1E40AF),
            Color(0xFF2563EB),
            Color(0xFF3B82F6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF1E40AF).withValues(alpha: 0.45),
            blurRadius: 22,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Sparkle decorations
          ..._buildSparkles(),

          // Subtle background glow circle
          Positioned(
            left: -20,
            bottom: -20,
            child: Container(
              width: 130,
              height: 130,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF60A5FA).withValues(alpha: 0.15),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Actual Robot Illustration Image from assets
                SizedBox(
                  width: 105,
                  height: 110,
                  child: Image.asset(
                    'assets/images/robot.png',
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      debugPrint('ROBOT IMAGE LOAD ERROR: $error');
                      return const Center(
                        child: Icon(
                          Icons.smart_toy_rounded,
                          color: Colors.white,
                          size: 60,
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Hello, Learner! 👋',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          letterSpacing: -0.3,
                        ),
                      ),
                      SizedBox(height: 6),
                      Text(
                        "I'm your Personal AI Mentor.\nAsk me anything about Flutter, Dart, Development & more!",
                        style: TextStyle(
                          color: Color(0xFFDBEAFE),
                          fontSize: 12.5,
                          height: 1.4,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildSparkles() {
    return const [
      Positioned(
        right: 24,
        top: 16,
        child: Text(
          '✦',
          style: TextStyle(color: Color(0xFF93C5FD), fontSize: 16),
        ),
      ),
      Positioned(
        right: 48,
        bottom: 20,
        child: Text(
          '✦',
          style: TextStyle(color: Color(0xFFBFDBFE), fontSize: 12),
        ),
      ),
      Positioned(
        left: 120,
        top: 14,
        child: Text(
          '✦',
          style: TextStyle(color: Color(0xFF60A5FA), fontSize: 13),
        ),
      ),
    ];
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Suggestions Grid (Blue style)
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildSuggestions(
    Color textPrimary,
    Color textSecondary,
    Color cardBg,
    Color borderColor,
    bool isDark,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Text('💡', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              'Try these questions:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14.5,
                color: textPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: _quickPrompts.map((prompt) {
            return GestureDetector(
              onTap: () => _sendMessage(prompt),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isDark
                      ? const Color(0xFF1E293B)
                      : const Color(0xFFEFF6FF),
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: isDark
                        ? const Color(0xFF334155)
                        : const Color(0xFFBFDBFE),
                  ),
                ),
                child: Text(
                  prompt,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: isDark
                        ? const Color(0xFF93C5FD)
                        : const Color(0xFF1D4ED8),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Message Bubble (with Robot image for AI avatar)
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildMessageBubble(
    ChatMessage message,
    bool isDark,
    Color textPrimary,
    Color textSecondary,
    Color cardBg,
    Color borderColor,
  ) {
    final isUser = message.isUser;
    final h = message.timeStamp.hour.toString().padLeft(2, '0');
    final m = message.timeStamp.minute.toString().padLeft(2, '0');
    final timeStr = '$h:$m ${message.timeStamp.hour < 12 ? 'AM' : 'PM'}';

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          // ── AI Avatar with Robot image ───────────────────────────────────
          if (!isUser) ...[
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: const Color(0xFF93C5FD).withValues(alpha: 0.5),
                  width: 1.5,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withValues(alpha: 0.35),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(3),
              child: ClipOval(
                child: Image.asset(
                  'assets/images/robot.png',
                  fit: BoxFit.contain,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.smart_toy_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
          ],

          // ── Bubble ───────────────────────────────────────────────────────
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUser
                    ? const LinearGradient(
                        colors: [
                          Color(0xFF1E40AF),
                          Color(0xFF2563EB),
                          Color(0xFF3B82F6),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isUser ? null : cardBg,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(18),
                  topRight: const Radius.circular(18),
                  bottomLeft: Radius.circular(isUser ? 18 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 18),
                ),
                border: isUser ? null : Border.all(color: borderColor),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: isUser
                    ? CrossAxisAlignment.end
                    : CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      fontSize: 14,
                      height: 1.45,
                      color: isUser ? Colors.white : textPrimary,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        timeStr,
                        style: TextStyle(
                          fontSize: 10,
                          color: isUser
                              ? Colors.white.withValues(alpha: 0.75)
                              : textSecondary,
                        ),
                      ),
                      if (isUser) ...[
                        const SizedBox(width: 3),
                        Icon(
                          Icons.done_all_rounded,
                          size: 12,
                          color: Colors.white.withValues(alpha: 0.75),
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ),

          // ── User avatar ───────────────────────────────────────────────────
          if (isUser) ...[
            const SizedBox(width: 8),
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF1E293B)
                    : const Color(0xFFDBEAFE),
                shape: BoxShape.circle,
                border: Border.all(
                  color: isDark
                      ? const Color(0xFF334155)
                      : const Color(0xFF93C5FD),
                ),
              ),
              child: const Icon(
                Icons.person_rounded,
                size: 20,
                color: Color(0xFF1D4ED8),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Typing indicator (with Robot image + animated blue dots)
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildTypingIndicator(bool isDark, Color cardBg, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E40AF), Color(0xFF3B82F6)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFF93C5FD).withValues(alpha: 0.5),
                width: 1.5,
              ),
            ),
            padding: const EdgeInsets.all(3),
            child: ClipOval(
              child: Image.asset(
                'assets/images/robot.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) => const Icon(
                  Icons.smart_toy_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: cardBg,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(18),
                topRight: Radius.circular(18),
                bottomRight: Radius.circular(18),
                bottomLeft: Radius.circular(4),
              ),
              border: Border.all(color: borderColor),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: AnimatedBuilder(
              animation: _dotAnimController,
              builder: (_, child) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final delay = i / 3;
                    final t = (_dotAnimController.value - delay).clamp(
                      0.0,
                      1.0,
                    );
                    final scale = 0.6 + 0.4 * math.sin(t * math.pi);
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3),
                      child: Transform.scale(
                        scale: scale,
                        child: Container(
                          width: 9,
                          height: 9,
                          decoration: BoxDecoration(
                            color: i == 0
                                ? const Color(0xFF2563EB)
                                : (i == 1
                                      ? const Color(0xFF60A5FA)
                                      : const Color(0xFF93C5FD)),
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    );
                  }),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────────────────────────────────
  // Input area (Blue theme)
  // ─────────────────────────────────────────────────────────────────────────

  Widget _buildInputArea(
    bool isDark,
    Color surfaceColor,
    Color inputBg,
    Color textPrimary,
    Color textSecondary,
    Color borderColor,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // ── Text field row ─────────────────────────────────────────────────
        Container(
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 8),
          decoration: BoxDecoration(
            color: surfaceColor,
            border: Border(top: BorderSide(color: borderColor)),
          ),
          child: Row(
            children: [
              Icon(Icons.attach_file_rounded, color: textSecondary, size: 22),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(maxHeight: 120),
                  decoration: BoxDecoration(
                    color: inputBg,
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: borderColor),
                  ),
                  child: TextField(
                    controller: _textController,
                    focusNode: _focusNode,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => _sendMessage(),
                    style: TextStyle(fontSize: 14, color: textPrimary),
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: 'Ask something...',
                      hintStyle: TextStyle(
                        fontSize: 13.5,
                        color: textSecondary,
                      ),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              // Send button (Pure Blue Gradient)
              GestureDetector(
                onTap: () => _sendMessage(),
                child: Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF1E40AF),
                        Color(0xFF2563EB),
                        Color(0xFF3B82F6),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.45),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.send_rounded,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),

        // ── Shortcut row ───────────────────────────────────────────────────
        Container(
          color: surfaceColor,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 8),
          child: Row(
            children: [
              _shortcutButton(
                icon: Icons.add_circle_rounded,
                label: 'New Chat',
                iconColor: const Color(0xFF2563EB),
                onTap: aiController.clearChat,
              ),
              Container(width: 1, height: 32, color: borderColor),
              _shortcutButton(
                icon: Icons.history_rounded,
                label: 'Chat History',
                iconColor: const Color(0xFF0284C7),
                onTap: () {},
              ),
              Container(width: 1, height: 32, color: borderColor),
              _shortcutButton(
                icon: Icons.menu_book_rounded,
                label: 'Learning Hub',
                iconColor: const Color(0xFF059669),
                onTap: () {},
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _shortcutButton({
    required IconData icon,
    required String label,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: iconColor),
              const SizedBox(width: 5),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF64748B),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
