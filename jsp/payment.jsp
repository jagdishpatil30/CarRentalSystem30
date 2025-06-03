<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Get all booking details from session
    String userName = (String) session.getAttribute("user_name");
    String carName = (String) session.getAttribute("car_name");
    String days = (String) session.getAttribute("days");
    String totalPrice = (String) session.getAttribute("total_price");
    String bookingDate = (String) session.getAttribute("booking_date");

    // Set default values if null
    if (totalPrice == null) totalPrice = "0.00";
    if (userName == null) userName = "";
    if (carName == null) carName = "";
    if (days == null) days = "0";
    if (bookingDate == null) bookingDate = java.time.LocalDate.now().toString();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Car Rental Payment Gateway</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <style>
        :root {
            --primary: #4361ee;
            --primary-dark: #3a0ca3;
            --secondary: #f72585;
            --light: #f8f9fa;
            --dark: #212529;
            --success: #4cc9f0;
            --danger: #ef233c;
            --warning: #f8961e;
            --border-radius: 8px;
            --shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
            --transition: all 0.3s ease;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        body {
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            color: var(--dark);
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .payment-container {
            max-width: 500px;
            width: 100%;
            background: white;
            border-radius: var(--border-radius);
            box-shadow: var(--shadow);
            overflow: hidden;
        }

        .payment-header {
            background: linear-gradient(135deg, var(--primary), var(--primary-dark));
            color: white;
            padding: 20px;
            text-align: center;
        }

        .payment-header h2 {
            font-size: 1.5rem;
            margin-bottom: 5px;
        }

        .payment-body {
            padding: 25px;
        }

        .booking-details {
            margin-bottom: 20px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eee;
        }

        .detail-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }

        .detail-row .label {
            font-weight: 500;
            color: #6c757d;
        }

        .detail-row .value {
            font-weight: 600;
        }

        .payment-amount {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
            padding: 15px;
            background-color: #f8f9fa;
            border-radius: var(--border-radius);
        }

        .payment-amount .label {
            font-weight: 500;
            color: #6c757d;
            font-size: 1.1rem;
        }

        .payment-amount .value {
            font-weight: 700;
            color: var(--primary-dark);
            font-size: 1.3rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            margin-bottom: 8px;
            font-weight: 500;
            color: #495057;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ced4da;
            border-radius: var(--border-radius);
            font-size: 1rem;
            transition: var(--transition);
        }

        .form-control:focus {
            border-color: var(--primary);
            outline: none;
            box-shadow: 0 0 0 2px rgba(67, 97, 238, 0.2);
        }

        .card-icons {
            display: flex;
            gap: 10px;
            margin-top: 10px;
        }

        .card-icon {
            width: 40px;
            height: 25px;
            background-color: #f1f3f5;
            border-radius: 4px;
            display: flex;
            justify-content: center;
            align-items: center;
            font-size: 0.8rem;
            color: #6c757d;
        }

        .row {
            display: flex;
            gap: 15px;
        }

        .row .form-group {
            flex: 1;
        }

        .btn {
            display: block;
            width: 100%;
            padding: 12px;
            background: var(--primary);
            color: white;
            border: none;
            border-radius: var(--border-radius);
            font-size: 1rem;
            font-weight: 500;
            cursor: pointer;
            text-align: center;
            transition: var(--transition);
        }

        .btn:hover {
            background: var(--primary-dark);
        }

        @media (max-width: 576px) {
            .row {
                flex-direction: column;
                gap: 0;
            }

            .payment-body {
                padding: 20px;
            }
        }
    </style>
</head>
<body>
    <div class="payment-container">
        <div class="payment-header">
            <h2><i class="fas fa-lock"></i> Secure Payment</h2>
            <p>Complete your car rental booking</p>
        </div>

        <div class="payment-body">
            <div class="booking-details">
                <div class="detail-row">
                    <span class="label">Customer:</span>
                    <span class="value" name="user_name"><%= userName %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Car:</span>
                    <span class="value"name="car_name"><%= carName %></span>
                </div>
                <div class="detail-row">
                    <span class="label">Duration:</span>
                    <span class="value"name="days"><%= days %> days</span>
                </div>
                <div class="detail-row">
                    <span class="label">Booking Date:</span>
                    <span class="value"><%= bookingDate %></span>
                </div>
            </div>

            <div class="payment-amount">
                <span class="label">Total Amount:</span>
                <span class="value"name="total_price">₹<%= totalPrice %></span>
            </div>

            <form action="/CarRent/UserBookCarFinal" method="post">
                <div class="form-group">
                    <label for="cardNumber">Card Number</label>
                    <input type="text" id="cardNumber" name="cardNumber" class="form-control" 
                           placeholder="1234 5678 9012 3456" required
                           oninput="formatCardNumber(this)"
                           onkeypress="return isNumberKey(event)" maxlength="19">
                    
                </div>

                <div class="form-group">
                    <label for="cardName">Name on Card</label>
                    <input type="text" id="cardName" name="cardName" class="form-control" 
                           placeholder="John Doe" required
                           onkeypress="return lettersOnly(event)">
                </div>

                <div class="row">
                    <div class="form-group">
                        <label for="expiryDate">Expiry Date</label>
                        <input type="text" id="expiryDate" name="expiryDate" class="form-control" 
                               placeholder="MM/YY" required 
                               oninput="formatExpiryDate(this)"
                               onkeypress="return isNumberKey(event)"
                               maxlength="5">
                    </div>

                    <div class="form-group">
                        <label for="cvv">CVV</label>
                        <input type="text" id="cvv" name="cvv" class="form-control" 
                               placeholder="123" required
                               onkeypress="return isNumberKey(event)"
                               maxlength="3">
                    </div>
                </div>

                <button type="submit" class="btn">
                    <i class="fas fa-lock"></i> Pay ₹<%= totalPrice %>
                </button>
            </form>
        </div>
    </div>

    <script>
        // Format card number with spaces after every 4 digits
        function formatCardNumber(input) {
            // Remove all non-digit characters
            let value = input.value.replace(/\D/g, '');
            
            // Add space after every 4 digits
            value = value.replace(/(\d{4})(?=\d)/g, '$1 ');
            
            // Update the input value
            input.value = value;
        }

        // Only allow numbers to be entered
        function isNumberKey(evt) {
            const charCode = (evt.which) ? evt.which : evt.keyCode;
            if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                return false;
            }
            return true;
        }

        // Only allow letters and spaces to be entered
        function lettersOnly(evt) {
            const charCode = (evt.which) ? evt.which : evt.keyCode;
            if ((charCode >= 65 && charCode <= 90) || 
                (charCode >= 97 && charCode <= 122) || 
                charCode === 32) {
                return true;
            }
            return false;
        }

        // Format expiry date as MM/YY
        function formatExpiryDate(input) {
            let value = input.value.replace(/\D/g, '');
            
            if (value.length > 2) {
                value = value.substring(0, 2) + '/' + value.substring(2, 4);
            }
            
            input.value = value;
        }
    </script>
</body>
</html>