<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="refresh" content="3;url=../user_dashboard.html">
    <title>Profile Updated</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@400;600&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css">
    <style>
        body {
            margin: 0;
            font-family: 'Poppins', sans-serif;
            background: url('../imgs/11.jpg') no-repeat center center/cover;
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #333;
        }

        .success-container {
            background: rgba(255, 255, 255, 0.9);
            padding: 40px;
            border-radius: 15px;
            text-align: center;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            max-width: 500px;
            width: 90%;
        }

        .success-icon {
            font-size: 60px;
            color: #4CAF50;
            margin-bottom: 20px;
            animation: bounce 1s infinite alternate;
        }

        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-10px); }
        }

        h1 {
            color: #2E7D32;
            margin-bottom: 15px;
        }

        p {
            color: #666;
            margin-bottom: 25px;
            font-size: 18px;
        }

        .redirect-message {
            color: #2196F3;
            font-weight: 600;
            margin-top: 20px;
        }

        .progress-bar {
            width: 100%;
            height: 5px;
            background: #e0e0e0;
            border-radius: 5px;
            margin-top: 20px;
            overflow: hidden;
        }

        .progress {
            height: 100%;
            width: 100%;
            background: #4CAF50;
            animation: progress 3s linear forwards;
        }

        @keyframes progress {
            from { width: 100%; }
            to { width: 0%; }
        }

        .home-btn {
            display: inline-block;
            background: #2196F3;
            color: white;
            padding: 12px 25px;
            border-radius: 25px;
            text-decoration: none;
            font-weight: 600;
            transition: background 0.3s;
            margin-top: 20px;
        }

        .home-btn:hover {
            background: #0b7dda;
        }
    </style>
</head>
<body>
    <div class="success-container">
        <div class="success-icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h1>Profile Updated Successfully!</h1>
        <p>Your profile information has been successfully updated.</p>
        
        <div class="progress-bar">
            <div class="progress"></div>
        </div>
        
        <div class="redirect-message">
            <p>You will be redirected to the home page in <span id="countdown">3</span> seconds...</p>
        </div>
        
        <a href="../user_dashboard.html" class="home-btn">
            <i class="fas fa-home"></i> Go to Home Now
        </a>
    </div>

    <script>
        // Countdown timer
        let seconds = 3;
        const countdownElement = document.getElementById('countdown');
        
        const timer = setInterval(function() {
            seconds--;
            countdownElement.textContent = seconds;
            
            if (seconds <= 0) {
                clearInterval(timer);
            }
        }, 1000);
    </script>
</body>
</html>