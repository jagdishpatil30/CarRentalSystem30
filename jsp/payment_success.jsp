<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    // Just to test if session values still exist
    String user = (String) session.getAttribute("user");
    String car = (String) session.getAttribute("car");
    String amount = (String) session.getAttribute("amount");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>Payment Success</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <style>
        body {
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            font-family: 'Poppins', sans-serif;
        }

        .success-container {
            background-color: white;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
            text-align: center;
            max-width: 500px;
        }

        .success-icon {
            font-size: 50px;
            color: #28a745;
            margin-bottom: 20px;
        }

        h2 {
            font-size: 24px;
            margin-bottom: 15px;
        }

        p {
            font-size: 16px;
            color: #6c757d;
        }

        .loader {
            margin: 30px auto 0 auto;
            border: 6px solid #f3f3f3;
            border-top: 6px solid #28a745;
            border-radius: 50%;
            width: 40px;
            height: 40px;
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    <script>
        setTimeout(function () {
            window.location.href = "book_reciept.jsp";
        }, 5000);
    </script>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">✅</div>
        <h2>Thanks for Payment</h2>
        <p>Your booking is confirmed!</p>
        <p>Please wait, receipt is generating...</p>
        <div class="loader"></div>
    </div>
</body>
</html>
