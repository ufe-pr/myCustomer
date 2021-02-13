import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mycustomers/ui/views/business/business_support_page/support_page.dart';
import 'package:mycustomers/ui/views/business/profile/edit_profile/edit_profile_view.dart';
import 'package:mycustomers/ui/views/business/settings/currency_settings_page/currency_settings_page_view.dart';
import 'package:mycustomers/ui/views/business/settings/language_settings/language_view.dart';
import 'package:mycustomers/ui/views/business/settings/set_pin_settings_page/set_pin_settings_view.dart';
import 'package:mycustomers/ui/views/business/settings/set_pin_settings_page/set_pin_settings_viewmodel.dart';
import 'package:mycustomers/ui/views/home/add_customer_manually/add_customer_manually_view.dart';
import 'package:mycustomers/ui/views/business/profile/profile_screen/profile_view.dart';
import 'package:mycustomers/ui/views/home/add_debt_credit/select_transaction/select_transaction_view.dart';
import 'package:mycustomers/ui/views/home/details/details_view.dart';
import 'package:mycustomers/ui/views/business/business_card_page/business_cardpage_view.dart';
import 'package:mycustomers/ui/views/business/settings/remove_pin_settings_page/remove_pin_settings_page_view.dart';
import 'package:mycustomers/ui/views/business/settings/settings_page/settings_page_view.dart';
import 'package:mycustomers/ui/views/business/profile/addAssistant/addAssitant_view.dart';
import 'package:mycustomers/ui/views/business/settings/app_lock_settings_page/app_lock_settings_page_view.dart';
import 'package:mycustomers/ui/views/business/settings/change_pin_settings_page/change_pin_settings_page_view.dart';
import 'package:mycustomers/ui/views/business/settings/saved_dialog_modal/saved_dialog_view.dart';
import 'package:mycustomers/ui/views/home/home_page/home_page_view.dart';
import 'package:mycustomers/ui/views/home/import_customer/import_customer_view.dart';
import 'package:mycustomers/ui/views/home/main_transaction/main_transaction_view.dart';
import 'package:mycustomers/ui/views/home/onboarding/onboarding_view.dart';
import 'package:mycustomers/ui/views/home/addcustomer/add_customer_view.dart';
import 'package:mycustomers/ui/views/home/schedule_notifications/schedule_reminder/schedule_reminder_view.dart';
import 'package:mycustomers/ui/views/home/sigin/signin_view.dart';
import 'package:mycustomers/ui/views/home/signup/business/business_view.dart';
import 'package:mycustomers/ui/views/home/signup/signup_view.dart';
import 'package:mycustomers/ui/views/home/signup/verification/verification_view.dart';
import 'package:mycustomers/ui/views/main/main_view.dart';
import 'package:mycustomers/ui/views/marketing/add_customer_message/add_customer_message_view.dart';
import 'package:mycustomers/ui/views/marketing/add_new_customer/add_new_customer_view.dart';
import 'package:mycustomers/ui/views/marketing/message_sent_dialogs/message_sent_dialog_view.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/quick_message/quick_message_view.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/message/message_view.dart';
import 'package:mycustomers/ui/views/marketing/marketing_home_page/marketing_homepage_view.dart';
import 'package:mycustomers/ui/views/home/add_debt_credit/add_debt_credit_view.dart';
import 'package:mycustomers/ui/views/home/transactions_details/transaction_detail_view.dart';
import 'package:mycustomers/ui/views/home/transaction_history/transaction_history_view.dart';
import 'package:mycustomers/ui/views/home/schedule_reminder/schedule_remider_view.dart';
import 'package:mycustomers/ui/views/home/schedule_reminder/send_message_view.dart';
import 'package:mycustomers/ui/views/marketing/send_message_page/send_a_message/send_a_message_view.dart';
import 'package:mycustomers/ui/views/startup/startup_view.dart';
import 'package:mycustomers/ui/views/home/notification_view/notification_view.dart';
import 'package:mycustomers/ui/views/home/schedule_notifications/send_reminder/send_reminder_view.dart';
import 'package:mycustomers/ui/widgets/main/create_business/create_business_view.dart';

/// An abstract class that is responsible for navigation and route
abstract class Routes {
  static const startupViewRoute = '/';
  static const onboardingViewRoute = '/onboarding';
  static const languageViewRoute = '/language';
  static const homeViewRoute = '/home';
  static const signinViewRoute = '/signin';
  static const signupViewRoute = '/signup';
  static const verificationViewRoute = '/verify';
  static const businessViewRoute = '/business';
  static const mainViewRoute = '/main';
  static const addcustomerRoute = '/addcustomer';
  static const addCustomerManuallyDebtor = '/addcusmandeb';
  static const addCustomerManuallyCreditor = '/addcusmancred';
  static const detailsViewRoute = '/details';
  static const addCustomer = '/addcustomer';
  static const addCustomerMessageRoute = '/addcusmess'; // (^ = ^)
  static const supportViewRoute = '/support';
  static const importCustomerDebtorViewRoute = '/importcustomerdebtor';
  static const importCustomerCreditorViewRoute = '/importcustomercreditor';
  static const addnewCredit = '/addnewCredit';
  static const addnewDebt = '/addnewDebt';
  static const addCredit = '/addCredit';
  static const addDebt = '/addDebt';
  static const selectDebt = '/selectDebt';
  static const selectCredit = '/selectCredit';
  static const selectRouteDebt = '/selectRouteDebt';
  static const selectRouteCredit = '/selectRouteCredit';
  static const mainTransaction = '/mainTransaction';
  static const transactionDetails = '/transactionDetails';
  static const transactionHistory = '/transactionHistory';
  static const addAssistantRoute = '/addAssistant';
  static const changeLanguagePref = '/changeLang';
  static const showDialogModal = '/saveDialogModal';
  static const businessCardRoute = '/businessCard';
  static const bussinessSettingsPage = '/bussinessSettingsPage';
  static const currencySettingsViewRoute = '/currencySettings';
  static const profileViewRoute = '/Profile';
  static const editProfileViewRoute = '/editProfile';
  static const appLockSettingsViewRoute = '/appLockSettings';
  static const changePinSettingsViewRoute = '/changePinSettings';
  static const removePinSettingsViewRoute = '/removePinSettings';
  static const languageSettingsViewRoute = '/languagePinSettings';
  static const scheduleReminder = '/scheduleReminder';
  static const sendReminder = '/sendReminder';
  static const sendMessageViewRoute = '/sendMessage';
  static const messageView = '/message';
  static const marketingHomepageView = '/marketingHomePage';
  static const addCustomerMarketing = '/addCustomerMarketing';
  static const addNewCustomerMarketing = '/addNewCustomerMarketing';
  static const notificationsViewRoute = '/NotificationsViews';
  static const businessCardDisplayModal = '/businessCardDisplayModal';
  static const quickMessages = '/quickMessages';
  static const messageSntDialog = '/dialog';
  static const createBusinessView = '/createBusiness';
  static const setPinSettingsViewRoute = '/setPinSettingsPage';
  static const sendNotificationMessage = '/sendNotificationMessage';
  static const scheduleNotifications = '/scheduleNotifications';
}

class Router {
  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.startupViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => StartupView(),
          settings: settings,
        );
      case Routes.onboardingViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => OnboardingView(),
          settings: settings,
        );
      // case Routes.languageViewRoute:
      //   return CupertinoPageRoute<dynamic>(
      //     builder: (context) => LanguageView(),
      //     settings: settings,
      //   );
      case Routes.verificationViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => VerificationView(),
          settings: settings,
        );
      case Routes.mainViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainView(),
          settings: RouteSettings(name: Routes.mainViewRoute, arguments: Map()),
          // settings: settings,
        );
      case Routes.addCustomer:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerView(),
          settings: settings,
        );
      case Routes.importCustomerDebtorViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ImportCustomerView(
            action: 'debtor',
          ),
          settings: settings,
        );
      case Routes.importCustomerCreditorViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ImportCustomerView(
            action: 'creditor',
          ),
          settings: settings,
        );
      case Routes.selectDebt:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SelectTransactionView(
            action: 'credit',
          ),
          settings: settings,
        );
      case Routes.selectCredit:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SelectTransactionView(
            action: 'debit',
          ),
          settings: settings,
        );
      case Routes.addnewDebt:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddDebtCreditView(
            action: 'debit',
            update: false,
            newCus: true,
          ),
          settings: settings,
        );
      case Routes.addnewCredit:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddDebtCreditView(
            action: 'credit',
            update: false,
            newCus: true,
          ),
          settings: settings,
        );
      case Routes.addDebt:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddDebtCreditView(
            action: 'debit',
            update: false,
            newCus: false,
          ),
          settings: settings,
        );
      case Routes.addCredit:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddDebtCreditView(
            action: 'credit',
            update: false,
            newCus: false,
          ),
          settings: settings,
        );
      case Routes.selectRouteDebt:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddDebtCreditView(
            action: 'debit',
            update: true,
            newCus: false,
          ),
          settings: settings,
        );
      case Routes.selectRouteCredit:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddDebtCreditView(
            action: 'credit',
            update: true,
            newCus: false,
          ),
          settings: settings,
        );
      case Routes.transactionHistory:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => TransactionHistory(),
          settings: settings,
        );
      case Routes.mainTransaction:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainTransaction(),
          settings: settings,
        );
      case Routes.transactionDetails:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => TransactionDetails(),
          settings: settings,
        );
      case Routes.businessViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => BusinessView(),
          settings: settings,
        );
      case Routes.addCustomerMessageRoute:
        final frequentCustomerList = settings.arguments;
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerMessageView(frequent: frequentCustomerList,),
          settings: settings,
        );
      case Routes.signupViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SignUpView(),
          settings: settings,
        );
      case Routes.signinViewRoute:
        return CupertinoPageRoute<dynamic>(
            builder: (context) => SignInView(), settings: settings);

      case Routes.bussinessSettingsPage:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SettingsPage(),
          settings: settings,
        );

      case Routes.profileViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ProfilePageView(),
          settings: settings,
        );
      case Routes.editProfileViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => EditProfileView(),
          settings: settings,
        );
      case Routes.supportViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SupportPageView(),
          settings: settings,
        );
      case Routes.mainViewRoute:
//        settings.arguments = Map();
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MainView(),
          settings: settings,
        );
      case Routes.addAssistantRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddAssistantView(),
          settings: settings,
        );
      case Routes.showDialogModal:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SavedDialogView(),
          settings: settings,
        );
      case Routes.messageSntDialog:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MessageDialogView(),
          settings: settings,
        );
      case Routes.businessCardRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => BusinessCardPageView(),
          settings: settings,
        );
      case Routes.currencySettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => CurrencySettingsPageView(),
          settings: settings,
        );
      case Routes.languageSettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => LanguageSelectionPageView(),
          settings: settings,
        );
      case Routes.appLockSettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AppLockSettingsPageView(),
          settings: settings,
        );
      case Routes.setPinSettingsViewRoute:
        return CupertinoPageRoute(
            builder: (context) => SetPinSettingsPageView(), settings: settings);
      case Routes.changePinSettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ChangePinSettingsPageView(),
          settings: settings,
        );
      case Routes.removePinSettingsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => RemovePinSettingsPageView(),
          settings: settings,
        );
      case Routes.detailsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => DetailsView(),
          settings: settings,
        );
      case Routes.sendReminder:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SendReminders(),
          settings: settings,
        );
      case Routes.scheduleReminder:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ScheduleReminders(),
          settings: settings,
        );
      case Routes.sendMessageViewRoute:
        final customerList = settings.arguments;
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SendAMessage(customerList),
          settings: settings,
        );
      case Routes.quickMessages:
        final customerList = settings.arguments;
        return CupertinoPageRoute<dynamic>(
          builder: (context) => QuickMessageView(customerList),
          settings: settings,
        );
      case Routes.messageView:
        final customerList = settings.arguments;
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MessageView(customerList),
          settings: settings,
        );
      case Routes.marketingHomepageView:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => MarketingHomePageView(),
          settings: RouteSettings(
              name: Routes.marketingHomepageView, arguments: Map()),
        );
      case Routes.createBusinessView:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => CreateBusinessView(),
          settings: settings,
        );
      case Routes.addCustomerManuallyDebtor:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerManuallyView(
            action: 'debtor',
          ),
          settings: settings,
        );
      case Routes.addCustomerManuallyCreditor:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerManuallyView(
            action: 'creditor',
          ),
          settings: settings,
        );
      case Routes.addCustomerMarketing:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddCustomerMessageView(),
          settings: settings,
        );
      case Routes.addNewCustomerMarketing:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => AddNewCustomerView(),
          settings: settings,
        );
      case Routes.notificationsViewRoute:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => NotificationsView(),
          settings: settings,
        );
      case Routes.sendNotificationMessage:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => SendMessage(),
          settings: settings,
        );
      case Routes.scheduleNotifications:
        return CupertinoPageRoute<dynamic>(
          builder: (context) => ScheduleNotifications(),
          settings: settings,
        );
      default:
        return unknownRoutePage(settings.name);
    }
  }
}

// borrowed from auto_route:
// returns an error page routes with a helper message.
PageRoute unknownRoutePage(String routeName) => CupertinoPageRoute(
      builder: (ctx) => Scaffold(
        body: Container(
          color: Colors.redAccent,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: Text(
                  routeName == "/"
                      ? 'Initial route not found! \n did you forget to annotate your home page with @initial or @MaterialRoute(initial:true)?'
                      : 'Route name $routeName is not found!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 16),
                ),
              ),
              OutlineButton.icon(
                label: Text('Back'),
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(ctx).pop(),
              )
            ],
          ),
        ),
      ),
    );
