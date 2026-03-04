import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:expense_control_app/features/cards/domain/entities/entities.dart';
import 'package:expense_control_app/features/cards/presentation/providers/providers.dart';

import 'card_form_content.dart';
import 'card_form_submit.dart';

class CardFormSheet extends ConsumerStatefulWidget {
  const CardFormSheet({super.key, this.card});

  final CreditCardEntity? card;

  @override
  ConsumerState<CardFormSheet> createState() => _CardFormSheetState();
}

class _CardFormSheetState extends ConsumerState<CardFormSheet> {
  late final TextEditingController _alias;
  late final TextEditingController _bank;
  late final TextEditingController _last4;
  late final TextEditingController _closing;
  late final TextEditingController _due;
  late final TextEditingController _limit;

  @override
  void initState() {
    super.initState();
    final card = widget.card;
    _alias = TextEditingController(text: card?.alias ?? '');
    _bank = TextEditingController(text: card?.bank ?? '');
    _last4 = TextEditingController(text: card?.last4 ?? '');
    _closing = TextEditingController(text: card?.closingDay.toString() ?? '25');
    _due = TextEditingController(text: card?.dueDay.toString() ?? '10');
    _limit = TextEditingController(
      text: card?.creditLimit.toStringAsFixed(2) ?? '0.00',
    );
  }

  @override
  void dispose() {
    _alias.dispose();
    _bank.dispose();
    _last4.dispose();
    _closing.dispose();
    _due.dispose();
    _limit.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isIOS = Theme.of(context).platform == TargetPlatform.iOS;
    final isLoading = ref.watch(cardFormActionsProvider).isLoading;
    final title = widget.card == null ? 'Nueva tarjeta' : 'Editar tarjeta';

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 16,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: CardFormContent(
        title: title,
        isIOS: isIOS,
        isLoading: isLoading,
        alias: _alias,
        bank: _bank,
        last4: _last4,
        closing: _closing,
        due: _due,
        limit: _limit,
        onSubmit: _submit,
      ),
    );
  }

  void _submit() {
    submitCardForm(
      context: context,
      ref: ref,
      card: widget.card,
      alias: _alias,
      bank: _bank,
      last4: _last4,
      closing: _closing,
      due: _due,
      limit: _limit,
    );
  }
}
