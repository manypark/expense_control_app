import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'card_form_adaptive_field.dart';

class CardFormContent extends StatelessWidget {
  const CardFormContent({
    super.key,
    required this.title,
    required this.isIOS,
    required this.isLoading,
    required this.alias,
    required this.bank,
    required this.last4,
    required this.closing,
    required this.due,
    required this.limit,
    required this.onSubmit,
  });

  final String title;
  final bool isIOS;
  final bool isLoading;
  final TextEditingController alias;
  final TextEditingController bank;
  final TextEditingController last4;
  final TextEditingController closing;
  final TextEditingController due;
  final TextEditingController limit;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.of(context).pop(),
                icon: const Icon(Icons.close),
              ),
            ],
          ),
          const SizedBox(height: 12),
          CardFormAdaptiveField(
            controller: alias,
            label: 'Alias',
            isIOS: isIOS,
            enabled: !isLoading,
          ),
          CardFormAdaptiveField(
            controller: bank,
            label: 'Banco',
            isIOS: isIOS,
            enabled: !isLoading,
          ),
          CardFormAdaptiveField(
            controller: last4,
            label: 'Ultimos 4 digitos',
            isIOS: isIOS,
            keyboardType: TextInputType.number,
            maxLength: 4,
            enabled: !isLoading,
          ),
          Row(
            children: [
              Expanded(
                child: CardFormAdaptiveField(
                  controller: closing,
                  label: 'Dia cierre',
                  isIOS: isIOS,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: CardFormAdaptiveField(
                  controller: due,
                  label: 'Dia pago',
                  isIOS: isIOS,
                  keyboardType: TextInputType.number,
                  enabled: !isLoading,
                ),
              ),
            ],
          ),
          CardFormAdaptiveField(
            controller: limit,
            label: 'Linea de credito',
            isIOS: isIOS,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            enabled: !isLoading,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: isIOS
                ? CupertinoButton.filled(
                    onPressed: isLoading ? null : onSubmit,
                    child: Text(isLoading ? 'Cargando...' : 'Guardar'),
                  )
                : FilledButton(
                    onPressed: isLoading ? null : onSubmit,
                    child: Text(isLoading ? 'Cargando...' : 'Guardar'),
                  ),
          ),
        ],
      ),
    );
  }
}
