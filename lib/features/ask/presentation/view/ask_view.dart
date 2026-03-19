import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tax_app/core/theme/colors.dart';
import 'package:tax_app/core/utils/extensions.dart';
import '../../../onboarding/presentation/widgets/general_scaffold.dart';
import '../contract/ask_contract.dart';

const _suggestions = [
  'Do I pay VAT on electricity?',
  'I dey earn ₦90k monthly—how law take affect me?',
  'What is minimum tax?',
  'How much PAYE for ₦150k salary?',
];

class AskView extends StatelessWidget implements AskViewContract {
  const AskView({super.key, required this.controller});

  final AskControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final hasMessages = controller.messages.isNotEmpty;
    final hasInput = controller.questionController.text.trim().isNotEmpty;

    return TaxLightScaffold(
      showTopActions: false,
      title: 'Ask Me',
      showLogo: false,
      body: Column(
        children: [
          Expanded(
            child: hasMessages
                ? _ChatList(controller: controller)
                : _EmptyState(onSuggestion: controller.sendSuggestion),
          ),
          _InputBar(
            controller: controller.questionController,
            hasInput: hasInput,
            onSend: controller.send,
          ),
          6.verticalSpace,
          'Answers are based only on stored tax laws'.toText(
            fontSize: 12,
            color: AppColors.subText,
            translate: false,
          ),
          10.verticalSpace,
        ],
      ),
    );
  }
}

// ─── Empty state ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onSuggestion});

  final ValueChanged<String> onSuggestion;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: 32.h),
      children: [
        Center(
          child: Container(
            width: 72.r,
            height: 72.r,
            decoration: BoxDecoration(
              color: AppColors.orange.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              color: AppColors.orange,
              size: 32.sp,
            ),
          ),
        ),
        20.verticalSpace,
        'Ask anything about tax laws'.toText(
          fontSize: 18,
          fontWeight: FontWeight.w700,
          textAlign: TextAlign.center,
          translate: false,
        ),
        10.verticalSpace,
        'I\'ll answer using official law sources and\nshow you where the information came from.'.toText(
          fontSize: 14,
          color: AppColors.secondaryText,
          textAlign: TextAlign.center,
          translate: false,
        ),
        28.verticalSpace,
        'Try asking:'.toText(
          fontSize: 13,
          color: AppColors.subText,
          textAlign: TextAlign.center,
          translate: false,
        ),
        14.verticalSpace,
        ..._suggestions.map(
          (s) => Padding(
            padding: EdgeInsets.only(bottom: 10.h),
            child: _SuggestionChip(text: s, onTap: () => onSuggestion(s)),
          ),
        ),
      ],
    );
  }
}

class _SuggestionChip extends StatelessWidget {
  const _SuggestionChip({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppColors.border),
        ),
        child: text.toText(fontSize: 15, translate: false),
      ),
    );
  }
}

// ─── Chat list ────────────────────────────────────────────────────────────────

class _ChatList extends StatelessWidget {
  const _ChatList({required this.controller});

  final AskControllerContract controller;

  @override
  Widget build(BuildContext context) {
    final messages = controller.messages;
    return ListView.separated(
      controller: controller.scrollController,
      padding: EdgeInsets.only(top: 16.h, bottom: 16.h),
      itemCount: messages.length,
      separatorBuilder: (_, i) => 12.verticalSpace,
      itemBuilder: (_, i) {
        final msg = messages[i];
        return msg.isUser
            ? _UserBubble(text: msg.text)
            : _BotCard(message: msg);
      },
    );
  }
}

class _UserBubble extends StatelessWidget {
  const _UserBubble({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: 0.75.sw),
        padding: REdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.primaryGreen,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.r),
            topRight: Radius.circular(16.r),
            bottomLeft: Radius.circular(16.r),
            bottomRight: Radius.circular(4.r),
          ),
        ),
        child: text.toText(
          fontSize: 15,
          color: AppColors.white,
          translate: false,
        ),
      ),
    );
  }
}

class _BotCard extends StatelessWidget {
  const _BotCard({required this.message});

  final AskMessage message;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: message.text.toText(
                  fontSize: 15,
                  textHeight: 24 / 15,
                  translate: false,
                ),
              ),
              8.horizontalSpace,
              GestureDetector(
                onTap: () => Clipboard.setData(
                  ClipboardData(text: message.text),
                ),
                child: Icon(
                  Icons.copy_rounded,
                  size: 18.sp,
                  color: AppColors.subText,
                ),
              ),
            ],
          ),
          if (message.sources != null && message.sources!.isNotEmpty) ...[
            16.verticalSpace,
            Divider(color: AppColors.border, height: 1),
            12.verticalSpace,
            'Where this came from:'.toText(
              fontSize: 13,
              color: AppColors.subText,
              translate: false,
            ),
            10.verticalSpace,
            ...message.sources!.map(
              (s) => Padding(
                padding: EdgeInsets.only(bottom: 12.h),
                child: _SourceRow(source: s),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _SourceRow extends StatelessWidget {
  const _SourceRow({required this.source});

  final AskSource source;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              source.name.toText(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                translate: false,
              ),
              4.verticalSpace,
              source.section.toText(
                fontSize: 13,
                color: AppColors.subText,
                translate: false,
              ),
            ],
          ),
        ),
        Icon(
          Icons.open_in_new_rounded,
          size: 18.sp,
          color: AppColors.subText,
        ),
      ],
    );
  }
}

// ─── Input bar ────────────────────────────────────────────────────────────────

class _InputBar extends StatelessWidget {
  const _InputBar({
    required this.controller,
    required this.hasInput,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool hasInput;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(10.r),
              border: Border.all(color: AppColors.border),
            ),
            child: TextField(
              controller: controller,
              style: TextStyle(
                fontFamily: 'Nunito',
                fontSize: 14.sp,
                color: const Color(0xff0A0D14),
              ),
              decoration: InputDecoration(
                hintText: 'Type your question...',
                hintStyle: TextStyle(
                  fontFamily: 'Nunito',
                  fontSize: 14.sp,
                  color: AppColors.subText,
                ),
                border: InputBorder.none,
                contentPadding:
                    REdgeInsets.symmetric(horizontal: 16, vertical: 14),
              ),
              onSubmitted: (_) => onSend(),
            ),
          ),
        ),
        10.horizontalSpace,
        GestureDetector(
          onTap: hasInput ? onSend : null,
          child: Container(
            width: 50.r,
            height: 50.r,
            decoration: BoxDecoration(
              color: hasInput
                  ? AppColors.primaryGreen
                  : AppColors.primaryGreen.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(
              Icons.send_rounded,
              color: AppColors.white,
              size: 20.sp,
            ),
          ),
        ),
      ],
    );
  }
}
