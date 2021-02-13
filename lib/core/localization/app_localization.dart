import 'package:flutter/cupertino.dart';
import 'package:mycustomers/app/local_setup.dart';
import 'package:mycustomers/core/constants/local_keys.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

import '../constants/local_keys.dart';

class AppLocalizations {
  final Locale locale;
  Map<String, String> _sentences;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations);

  Future<bool> load() async {
    final path = 'assets/languages/${locale.languageCode}.json';
    final data = await rootBundle.loadString(path);
    final Map<String, dynamic> _result = json.decode(data);

    _sentences = <String, String>{};
    _result.forEach((String key, dynamic value) {
      _sentences[key] = value.toString();
    });

    return true;
  }

  String translate(String key) {
    return _sentences[key];
  }

  //list of available local strings that the app can use
  String get onboardingWelcomeText =>
      translate(LocalKeys.onboarding_welcome_text);
  String get onboardingWelcomeDesc =>
      translate(LocalKeys.onboarding_welcome_desc);
  String get getStartedButton => translate(LocalKeys.getstarted_button);
  String get signIn => translate(LocalKeys.sign_in);
  String get pushAReminder => translate(LocalKeys.push_a_reminder);
  String get pushAReminderDesc => translate(LocalKeys.push_a_reminder_desc);
  String get collectYourMoney => translate(LocalKeys.collect_your_money);
  String get collectYourMoneyDesc =>
      translate(LocalKeys.collect_your_money_desc);
  String get engagedWithYourPeople =>
      translate(LocalKeys.engaged_with_your_people);
  String get engagedWithYourPeopleDesc =>
      translate(LocalKeys.engaged_with_your_people_desc);
  String get signUp => translate(LocalKeys.sign_up);
  String get signUpEnterPhoneNumber => translate(LocalKeys.enter_phone_number);
  String get continueWithSocialAccount =>
      translate(LocalKeys.continue_with_social_account);
  String get alreadyAmemberSignIn =>
      translate(LocalKeys.already_a_member_sign_in);
  String get notAMemberSignUp => translate(LocalKeys.not_a_member_sign_up);
  String get nextButton => translate(LocalKeys.next_button);
  String get verifyCode => translate(LocalKeys.verify_code);
  String get enter4DigitCode => translate(LocalKeys.enter_4_digit_code);
  String get verifyAndProceed => translate(LocalKeys.verify_and_proceed);
  String get verificationErrorMessage =>
      translate(LocalKeys.verification_error_message);
  String get businessDetails => translate(LocalKeys.business_details);
  String get oneLastStep => translate(LocalKeys.one_last_step);
  String get enterYourFullName => translate(LocalKeys.enter_your_full_name);
  String get enterYourCompanyName =>
      translate(LocalKeys.enter_your_company_name);
  String get submitAndFinish => translate(LocalKeys.submit_and_finish);
  String get customersOwingYou => translate(LocalKeys.customers_owing_you);
  String get peopleYouOwe => translate(LocalKeys.people_you_owe);
  String get customersAreOwingYou =>
      translate(LocalKeys.customers_are_owing_you);

  String get addCustomersOwingYou =>
      translate(LocalKeys.add_customers_owing_you);
  String get home => translate(LocalKeys.home);
  String get marketing => translate(LocalKeys.marketing);
  String get business => translate(LocalKeys.business);
  String get searchByName => translate(LocalKeys.search_by_name);
  String get youAreOwing => translate(LocalKeys.you_are_owing);
  String get addPeopleYouOwe => translate(LocalKeys.add_people_you_owe);

  String get notifications => translate(LocalKeys.notifications);
  String get view => translate(LocalKeys.view);
  String get yourCompany => translate(LocalKeys.your_company);
  String get addCustomer => translate(LocalKeys.add_customer);
  String get help => translate(LocalKeys.help);
  String get signOut => translate(LocalKeys.sign_out);
  String get addBusiness => translate(LocalKeys.add_business);
  String get businessName => translate(LocalKeys.business_name);
  String get aboutBusiness => translate(LocalKeys.about_business);
  String get searchCustomers => translate(LocalKeys.search_customers);
  String get cancel => translate(LocalKeys.cancel);
  String get addNewCustomer => translate(LocalKeys.add_new_customer);
  String get addDebtorsFromContacts =>
      translate(LocalKeys.add_debtors_from_contacts);
  String get addButton => translate(LocalKeys.add_button);
  String get addACustomer => translate(LocalKeys.add_a_customer);
  String get customerDetails => translate(LocalKeys.customer_details);
  String get enterNameOfDebtor => translate(LocalKeys.enter_name_of_debtor);
  String get continueButton => translate(LocalKeys.continue_button);
  String get addTransaction => translate(LocalKeys.add_transaction);
  String get downloadReport => translate(LocalKeys.download_report);
  String get sendReminder => translate(LocalKeys.send_reminder);
  String get addDebit => translate(LocalKeys.add_debit);
  String get addCredit => translate(LocalKeys.add_credit);
  String get sms => translate(LocalKeys.sms);
  String get call => translate(LocalKeys.call);
  String get setReminder => translate(LocalKeys.set_reminder);
  String get viewHistory => translate(LocalKeys.view_history);
  String get owesYou => translate(LocalKeys.owes_you);
  String get enterAmount => translate(LocalKeys.enter_amount);
  String get selectDueDate => translate(LocalKeys.select_due_date);
  String get enterItemspurchased => translate(LocalKeys.enter_items_purchased);
  String get save => translate(LocalKeys.save);
  String get borrowedYou => translate(LocalKeys.borrowed_you);
  String get itemsPurchased => translate(LocalKeys.items_purchased);
  String get costOfItems => translate(LocalKeys.cost_of_items);
  String get amountPaid => translate(LocalKeys.amount_paid);
  String get amountOwing => translate(LocalKeys.amount_owing);
  String get shareTo => translate(LocalKeys.share_to);
  String get share => translate(LocalKeys.share);
  String get typeAHeading => translate(LocalKeys.type_a_heading);
  String get startTypingYourmessage =>
      translate(LocalKeys.start_typing_your_message);
  String get schedule => translate(LocalKeys.schedule);
  String get sendCapital => translate(LocalKeys.send_capital);
  String get scheduleReminder => translate(LocalKeys.schedule_reminder);
  String get transactionHistory => translate(LocalKeys.transaction_history);
  String get selectDate => translate(LocalKeys.select_date);
  String get payedYou => translate(LocalKeys.payed_you);
  String get details => translate(LocalKeys.details);
  String get transaction => translate(LocalKeys.transaction);
  String get deliverables => translate(LocalKeys.deliverables);
  String get completedPayment => translate(LocalKeys.completed_payment);
  String get setRemindsDate => translate(LocalKeys.set_reminds_date);
  String get setRemDateDesc => translate(LocalKeys.set_rem_date_desc);
  String get forAWeek => translate(LocalKeys.for_a_week);
  String get forAMonth => translate(LocalKeys.for_a_month);
  String get time => translate(LocalKeys.time);
  String get exportAsPdf => translate(LocalKeys.export_as_pdf);
  String get export => translate(LocalKeys.export);
  String get transactionReport => translate(LocalKeys.transaction_report);
  String get monthlyReport => translate(LocalKeys.monthly_report);
  String get date => translate(LocalKeys.date);
  String get remark => translate(LocalKeys.remark);
  String get sendMessage => translate(LocalKeys.send_message);
  String get addCustomerFromContacts =>
      translate(LocalKeys.add_customer_from_contacts);
  String get contacts => translate(LocalKeys.contacts);
  String get customerName => translate(LocalKeys.customer_name);
  String get customerPhoneNo => translate(LocalKeys.customer_phone_no);
  String get customerList => translate(LocalKeys.customer_list);
  String get sendMessageAll => translate(LocalKeys.send_message_all);
  String get quickMessage => translate(LocalKeys.quick_message);
  String get composeMessage => translate(LocalKeys.compose_message);
  String get title => translate(LocalKeys.title);
  String get message => translate(LocalKeys.message);
  String get selectedCustomer => translate(LocalKeys.selected_customer);
  String get messageSent => translate(LocalKeys.message_sent);
  String get frequentlyContacted => translate(LocalKeys.frequently_contacted);
  String get profile => translate(LocalKeys.profile);
  String get buisnessCard => translate(LocalKeys.business_card);
  String get support => translate(LocalKeys.support);
  String get settings => translate(LocalKeys.settings);
  String get regPhoneNo => translate(LocalKeys.reg_phone_no);
  String get name => translate(LocalKeys.name);
  String get edit => translate(LocalKeys.edit);
  String get editPic => translate(LocalKeys.edit_pic);
  String get changePic => translate(LocalKeys.change_pic);
  String get download => translate(LocalKeys.download);
  String get saveAndShare => translate(LocalKeys.save_and_share);
  String get changeLanguage => translate(LocalKeys.change_language);
  String get changeCurrency => translate(LocalKeys.change_currency);
  String get appLock => translate(LocalKeys.app_lock);
  String get receiveNotifications => translate(LocalKeys.receive_notifications);
  String get receiveNewsletters => translate(LocalKeys.receive_newsletters);
  String get receiveSpecialOffers =>
      translate(LocalKeys.receive_special_offers);
  String get receiveUpdates => translate(LocalKeys.receive_updates);
  String get selectYourLanguage => translate(LocalKeys.select_your_language);
  String get selectYourCurrency => translate(LocalKeys.select_your_currency);
  String get saved => translate(LocalKeys.saved);
  String get createANewPin => translate(LocalKeys.create_a_new_pin);
  String get confirmNewPin => translate(LocalKeys.confirm_new_pin);
  String get changeAppLockPin => translate(LocalKeys.change_app_lock_pin);
  String get removeAppLock => translate(LocalKeys.remove_app_lock);
  String get enterPin => translate(LocalKeys.enter_pin);
  String get pinRemoved => translate(LocalKeys.pin_removed);
  String get invalidPhoneNo => translate(LocalKeys.invalid_phone_no);
  String get pleaseEnterPassword => translate(LocalKeys.please_enter_password);
  String get continueWithSocialAcct =>
      translate(LocalKeys.continue_with_social_acct);
  String get googleComingSoon => translate(LocalKeys.google_coming_soon);
  String get facebookComingSoon => translate(LocalKeys.facebook_coming_soon);
  String get pleaseStoreName => translate(LocalKeys.please_store_name);
  String get enterStoreName => translate(LocalKeys.enter_store_name);
  String get pleaseStoreAddress => translate(LocalKeys.please_store_address);
  String get enterStoreAddress => translate(LocalKeys.enter_store_address);
  String get allCustomers => translate(LocalKeys.all_customers);
  String get noCustomerAdded => translate(LocalKeys.no_customer_added);
  String get noCustomerFound => translate(LocalKeys.no_customer_found);
  String get sortedBy => translate(LocalKeys.sorted_by);
  String get dateOfIssue => translate(LocalKeys.date_of_issue);
  String get filter => translate(LocalKeys.filter);
  String get noCustomerYet => translate(LocalKeys.no_customer_yet);
  String get typeCustomerName => translate(LocalKeys.type_customer_name);
  String get all => translate(LocalKeys.all);
  String get storeName => translate(LocalKeys.store_name);
  String get companyTagLine => translate(LocalKeys.company_tag_line);
  String get personalName => translate(LocalKeys.personal_name);
  String get position => translate(LocalKeys.position);
  String get phoneNumber => translate(LocalKeys.phone_number);
  String get emailAddress => translate(LocalKeys.email_address);
  String get shopAddress => translate(LocalKeys.shop_address);
  String get saveSuccessful => translate(LocalKeys.save_successful);
  String get sharing => translate(LocalKeys.sharing);
  String get successful => translate(LocalKeys.successful);
  String get customerSupport => translate(LocalKeys.customer_support);
  String get email => translate(LocalKeys.email);
  String get writeMessageHere => translate(LocalKeys.write_message_here);
  String get send => translate(LocalKeys.send);
  String get noTransaction => translate(LocalKeys.no_transaction);
  String get transactionDetails => translate(LocalKeys.transaction_details);
  String get amountOwed => translate(LocalKeys.amount_owed);
  String get delete => translate(LocalKeys.delete);
  String get editProfile => translate(LocalKeys.edit_profile);
  String get notPickedImage => translate(LocalKeys.not_picked_image);
  String get addProfilePicture => translate(LocalKeys.add_profile_picture);
  String get darkMode => translate(LocalKeys.dark_mode);
  String get setApplockPin => translate(LocalKeys.set_applock_pin);
  String get enterOldPin => translate(LocalKeys.enter_old_pin);
  String get currency => translate(LocalKeys.currency);
  String get language => translate(LocalKeys.language);
  String get enterName => translate(LocalKeys.enter_name);
  String get mobileNumber => translate(LocalKeys.mobile_number);
  String get selectATransaction => translate(LocalKeys.select_a_transaction);
  String get addNewCredit => translate(LocalKeys.add_new_credit);
  String get addNewDebit => translate(LocalKeys.add_new_debit);
  String get existingCredits => translate(LocalKeys.existing_credits);
  String get existingDebits => translate(LocalKeys.existing_debits);
  String get youAreOwingCustomers =>
      translate(LocalKeys.you_are_owing_customers);
  String get youDoNotHaveAnyCustomerOwingYou =>
      translate(LocalKeys.you_do_not_have_any_customer_owing_you);
  String get youCurrentlyDoNotOweAnyPerson =>
      translate(LocalKeys.you_currently_do_not_owe_any_person);
  String get selectDateOfPurchase =>
      translate(LocalKeys.select_date_of_purchase);
  String get selectDateOfPayment => translate(LocalKeys.select_date_of_payment);
  String get add => translate(LocalKeys.add);
  String get youOwe => translate(LocalKeys.you_owe);
  String get addFromContacts => translate(LocalKeys.add_from_contacts);
  String get addManually => translate(LocalKeys.add_manually);
  String get transactionsGoHere => translate(LocalKeys.transactions_go_here);
  String get collecting => translate(LocalKeys.collecting);
  String get giving => translate(LocalKeys.giving);
  String get addCreditorFromContacts =>
      translate(LocalKeys.add_creditor_from_contacts);
  String get search => translate(LocalKeys.search);
  String get report => translate(LocalKeys.report);
  String get reminder => translate(LocalKeys.reminder);
  String get isSafeAndSecure => translate(LocalKeys.is_safe_and_secure);
  String get canViewThisTransaction =>
      translate(LocalKeys.can_view_this_transaction);
  String get costOfGoodsPurchased =>
      translate(LocalKeys.cost_of_goods_purchased);
  String get paid => translate(LocalKeys.paid);
  String get addDebt => translate(LocalKeys.add_debt);
  String get reminders => translate(LocalKeys.reminders);
  String get activities => translate(LocalKeys.activities);
  String get noRemindersYet => translate(LocalKeys.no_reminders_yet);
  String get noActivitiesYet => translate(LocalKeys.no_activities_yet);
  String get fieldShouldNotBeEmpty =>
      translate(LocalKeys.field_should_not_be_empty);
  String get youHaveAPendingMessageToSend =>
      translate(LocalKeys.you_have_a_pending_message_to_send);
  String get password => translate(LocalKeys.password);
  String get pleaseEnterYourFullName =>
      translate(LocalKeys.please_enter_your_full_name);
  String get pleaseEnterYourPhoneNumber =>
      translate(LocalKeys.please_enter_your_phone_number);
  String get pleaseEnterYourEmailAddress =>
      translate(LocalKeys.please_enter_your_email_address);
  String get selectADate => translate(LocalKeys.select_a_date);
  String get showYourCustomersThatYouReallyCare =>
      translate(LocalKeys.show_your_customers_that_you_really_care);
  String get itsAllAboutSendingMessagesToCustomers =>
      translate(LocalKeys.its_all_about_sending_messages_to_customers);
  String get selectContacts => translate(LocalKeys.select_contacts);
  String get phoneContacts => translate(LocalKeys.phone_contacts);
  String get weHaveAlreadyMadeMessagesForYou =>
      translate(LocalKeys.we_have_already_made_messages_for_you);
  String get createUniqueMessagesForCustomers =>
      translate(LocalKeys.create_unique_messages_for_customers);
  String get happyNewYear => translate(LocalKeys.happy_new_year);
  String get bestWishesFromMe => translate(LocalKeys.best_wishes_from_me);
  String get seasonGreetings => translate(LocalKeys.season_greetings);
  String get wishingYouAHappyNewYear =>
      translate(LocalKeys.wishing_you_a_happy_new_year);
  String get sendAMessage => translate(LocalKeys.send_a_message);
  String get zeroSelectedCustomers =>
      translate(LocalKeys.zero_selected_customers);
  String get accessDenied => translate(LocalKeys.access_denied);
  String get myCustomerNeedsAccessToYourContacts =>
      translate(LocalKeys.my_customer_needs_access_to__your_contacts);
  String get deny => translate(LocalKeys.deny);
  String get allow => translate(LocalKeys.allow);
  String get debtor => translate(LocalKeys.debtor);
  String get noNumber => translate(LocalKeys.no_number);
  String get credit => translate(LocalKeys.credit);
  String get pickADateAndTypeInYourMessage =>
      translate(LocalKeys.pick_a_date_and_type_in_your_message);
  String get theyAreOwingYou => translate(LocalKeys.they_are_owing_you);
  String get youAreOwingThem => translate(LocalKeys.you_are_owing_them);
  String get facebook => translate(LocalKeys.facebook);
  String get whatsapp => translate(LocalKeys.whatsapp);
  String get gmail => translate(LocalKeys.gmail);
  String get pickImage => translate(LocalKeys.pick_image);
  String get userName => translate(LocalKeys.user_name);
  String get comingSoon => translate(LocalKeys.coming_soon);
  String get amount => translate(LocalKeys.amount);
  String get dueDate => translate(LocalKeys.due_date);
  String get description => translate(LocalKeys.description);
  String get enterDescription => translate(LocalKeys.enter_description);
  String get enterCustomerName => translate(LocalKeys.enter_customer_name);
  String get noResultFoundFor => translate(LocalKeys.no_result_found_for);
  String get paymentDate => translate(LocalKeys.payment_date);
  String get addNewDebtor => translate(LocalKeys.add_new_debtor);
  String get addNewCreditor => translate(LocalKeys.add_new_creditor);
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocalCodes.contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    final localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

class FallbackCupertinoLocalizationsDelegate
    extends LocalizationsDelegate<CupertinoLocalizations> {
  const FallbackCupertinoLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return supportedLocalCodes.contains(locale.languageCode);
  }

  @override
  Future<CupertinoLocalizations> load(Locale locale) {
    return DefaultCupertinoLocalizations.load(locale);
  }

  @override
  bool shouldReload(FallbackCupertinoLocalizationsDelegate old) => false;
}
