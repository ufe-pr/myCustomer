import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/core/models/customer.dart';
import 'package:mycustomers/ui/shared/const_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mycustomers/ui/shared/size_config.dart';

extension Initial on Contact {
  String get initial => (this == null) ? '.' : this.initials().isNotEmpty ? this.initials() : this.displayName[0].toUpperCase();
}

class CustomerCircleAvatar extends StatelessWidget {
  CustomerCircleAvatar({
    Key key,
    this.customer,
    this.child,
    this.bgColor, this.contact, this.action
  }) : super(key: key) {
    assert((customer != null) || (child != null) || (contact != null));
  }

  final Customer customer;
  final Contact contact;
  final Widget child;
  final Color bgColor;
  final String action;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: this.child != null ? this.child : this.contact != null && this.contact.avatar.isNotEmpty ? Image.memory(this.contact.avatar, fit: BoxFit.cover,) :
          Text(
            '${customer?.name?.substring(0, 1) ?? contact?.initial ?? '(*)'}${customer.lastName ==''?'': customer?.lastName?.substring(0, 1) ?? ''}'.toUpperCase(),
            style: TextStyle(
              color: action == 'debtor' ? BrandColors.primary : BrandColors.secondary,
              fontSize: SizeConfig.yMargin(context, 2),
            ),
          ),
      radius: SizeConfig.xMargin(context, 6),
      backgroundColor: this.bgColor != null ? this.bgColor : action == 'debtor' ? BrandColors.primary.withOpacity(0.3) : BrandColors.secondary.withOpacity(0.3),
    );
  }
}
