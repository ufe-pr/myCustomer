/// List of api end points
class ApiRoutes {
  ApiRoutes._();

  // BASE_URL
  static const base_url = 'https://dev.api.customerpay.me';

  //USER
  static const user = '$base_url/assistant';
  //STORE
  static const store = '$base_url/store';
  //TRANSACTION
  static const transaction = '$base_url/transaction';
  //NOTIFICATION
  static const notification = '$base_url/reminder';
  //AUTHENTICATION
  static const authentication_register = '$base_url/register/user';
  static const authentication_login = '$base_url/login/user';
}

//CRUD FOR USER
// static const all_user = '$user/all';
// static const create_user = '$user/new';
// static const user_id = '$user/:user_id';
// static const update_user = '$user/update/:user_id';
// static const delete_user = '$user/delete/:user_id';

// CRUD FOR TRANSACTIONS
// Add new transaction - /transaction/new
// View all transactions - /transaction/all
// view a single transaction - /transaction/:transaction_id     UPDATE
// Update transaction - /transaction/update/:transaction_id
// Delete transaction (logical delete) - /transaction/delete/:transaction_id

// NOTIFICATION
// Send a debt reminder - /reminder/:customer_id (Reminders are sent via SMS or EMAIL) - CANCELED
// Send SMS reminder - /reminder/sms/:customer_id
// Send Email reminder - /reminder/email/:customer_id

// AUTHENTICATION
// User register - /register/user or /register/customer
// User login - /login
// Enable login with Google
// Login with Apple

// Account Activation
// Send SMS(OTP)- /auth/verify-phone
// Verify token - /auth/verify

// Account Recovery
// Send password reset link - /forgot-password
// Reset password - /reset-password

// CALL ENDPOINTS     UPDATE
// call a customer's number - /call/:customer_id

// ENDPOINTS FOR STORE
// Create store - /store/new
// Retrieve store - /store/:store_id
// Update store - /store/update/:store_id
// Delete store - /store/delete/:store_id
// View all user's stores - /store/all

// ENDPOINTS FOR CUSTOMER
// Create customer - /customer/new
// Retrieve customer - /customer/:customer_id
// Update customer details - /customer/update/:customer_id
// Delete customer (logical delete) - /customer/delete/:customer_id

// ENDPOINTS FOR COMPLAINT FORM
// Register new complaint - /complaint/new
// Retrieve all complaints  - /complaint/all
// Update complaint - /complaint/update/:complaint_id
// Delete a complaint form - /complaint/delete/:complaint_id
