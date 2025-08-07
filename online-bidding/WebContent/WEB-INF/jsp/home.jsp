<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AuctionHub - Live Auctions</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Inter', sans-serif;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            color: #333;
        }
        
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            padding: 1rem 2rem;
            box-shadow: 0 2px 20px rgba(0,0,0,0.1);
            position: sticky;
            top: 0;
            z-index: 1000;
        }
        
        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .logo {
            font-size: 1.8rem;
            font-weight: 700;
            color: #667eea;
            text-decoration: none;
        }
        
        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }
        
        .nav-links a {
            text-decoration: none;
            color: #333;
            font-weight: 500;
            transition: color 0.3s;
        }
        
        .nav-links a:hover {
            color: #667eea;
        }
        
        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        
        .user-avatar {
            width: 40px;
            height: 40px;
            background: #667eea;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
        }
        
        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .auction-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
            margin-bottom: 2rem;
        }
        
        .auction-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem;
            text-align: center;
        }
        
        .auction-title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .auction-subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
        }
        
        .auction-content {
            padding: 2rem;
        }
        
        .item-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
            margin-bottom: 2rem;
        }
        
        .item-image {
            width: 100%;
            height: 400px;
            object-fit: cover;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .item-details {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }
        
        .item-name {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .item-price {
            font-size: 1.5rem;
            color: #667eea;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .countdown {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 15px;
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .countdown-title {
            font-size: 1.2rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .countdown-timer {
            font-size: 2rem;
            font-weight: 700;
            color: #e74c3c;
            font-family: 'Courier New', monospace;
        }
        
        .bid-section {
            background: #f8f9fa;
            padding: 2rem;
            border-radius: 15px;
            margin-bottom: 1.5rem;
        }
        
        .current-bid {
            font-size: 1.3rem;
            font-weight: 600;
            color: #333;
            margin-bottom: 1rem;
        }
        
        .bid-form {
            display: flex;
            gap: 1rem;
            align-items: center;
        }
        
        .bid-input {
            flex: 1;
            padding: 1rem;
            border: 2px solid #e1e5e9;
            border-radius: 10px;
            font-size: 1rem;
            transition: border-color 0.3s;
        }
        
        .bid-input:focus {
            outline: none;
            border-color: #667eea;
        }
        
        .bid-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 1rem 2rem;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: transform 0.3s;
        }
        
        .bid-button:hover {
            transform: translateY(-2px);
        }
        
        .bid-button:disabled {
            background: #ccc;
            cursor: not-allowed;
            transform: none;
        }
        
        .leaderboard {
            background: white;
            border-radius: 15px;
            padding: 2rem;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .leaderboard-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .bid-list {
            list-style: none;
        }
        
        .bid-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem;
            border-bottom: 1px solid #e1e5e9;
        }
        
        .bid-item:last-child {
            border-bottom: none;
        }
        
        .bid-info {
            display: flex;
            flex-direction: column;
        }
        
        .bidder-name {
            font-weight: 600;
            color: #333;
        }
        
        .bid-time {
            font-size: 0.9rem;
            color: #666;
        }
        
        .bid-amount {
            font-weight: 700;
            color: #667eea;
            font-size: 1.1rem;
        }
        
        .login-prompt {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0,0,0,0.1);
        }
        
        .login-prompt h3 {
            font-size: 1.5rem;
            margin-bottom: 1rem;
            color: #333;
        }
        
        .login-button {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            text-decoration: none;
            padding: 1rem 2rem;
            border-radius: 10px;
            font-weight: 600;
            display: inline-block;
            transition: transform 0.3s;
        }
        
        .login-button:hover {
            transform: translateY(-2px);
        }
        
        .auction-ended {
            background: #e74c3c;
            color: white;
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .winner-info {
            background: #27ae60;
            color: white;
            padding: 1rem;
            border-radius: 10px;
            text-align: center;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        @media (max-width: 768px) {
            .item-grid {
                grid-template-columns: 1fr;
            }
            
            .bid-form {
                flex-direction: column;
            }
            
            .nav-links {
                display: none;
            }
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/" class="logo">
                <i class="fas fa-gavel"></i> AuctionHub
            </a>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/auction/view">Live Auction</a>
                <c:if test="${not empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/profile">Profile</a>
                    <div class="user-info">
                        <div class="user-avatar">
                            ${sessionScope.user.name.charAt(0)}
                        </div>
                        <span>${sessionScope.user.name}</span>
                        <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
                    </div>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <a href="${pageContext.request.contextPath}/auth/login">Login</a>
                    <a href="${pageContext.request.contextPath}/auth/register">Register</a>
                </c:if>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-container">
        <c:if test="${not empty auctionItem}">
            <div class="auction-card">
                <div class="auction-header">
                    <h1 class="auction-title">Live Auction</h1>
                    <p class="auction-subtitle">Bid now and win this exclusive item!</p>
                </div>
                
                <div class="auction-content">
                    <c:if test="${auctionItem.status eq 'ENDED' or auctionItem.status eq 'SOLD'}">
                        <div class="auction-ended">
                            <i class="fas fa-clock"></i> Auction has ended
                        </div>
                        <c:if test="${not empty highestBid}">
                            <div class="winner-info">
                                <i class="fas fa-trophy"></i> Winner: ${highestBid.bidderName} - ₹${highestBid.bidAmount}
                            </div>
                        </c:if>
                    </c:if>
                    
                    <div class="item-grid">
                        <img src="${auctionItem.imageUrl}" alt="${auctionItem.name}" class="item-image">
                        <div class="item-details">
                            <h2 class="item-name">${auctionItem.name}</h2>
                            <p class="item-price">Base Price: ₹${auctionItem.basePrice}</p>
                            
                            <c:if test="${auctionItem.status eq 'ACTIVE'}">
                                <div class="countdown">
                                    <div class="countdown-title">Time Remaining</div>
                                    <div class="countdown-timer" id="countdown">Loading...</div>
                                </div>
                                
                                <c:if test="${not empty sessionScope.user}">
                                    <div class="bid-section">
                                        <div class="current-bid">
                                            <c:if test="${not empty highestBid}">
                                                Current Highest Bid: ₹${highestBid.bidAmount} by ${highestBid.bidderName}
                                            </c:if>
                                            <c:if test="${empty highestBid}">
                                                No bids yet. Be the first to bid!
                                            </c:if>
                                        </div>
                                        
                                        <form class="bid-form" id="bidForm">
                                            <input type="hidden" name="auctionItemId" value="${auctionItem.id}">
                                            <input type="number" name="bidAmount" class="bid-input" 
                                                   placeholder="Enter your bid amount" 
                                                   min="${not empty highestBid ? highestBid.bidAmount + 1 : auctionItem.basePrice}" 
                                                   step="0.01" required>
                                            <button type="submit" class="bid-button">
                                                <i class="fas fa-gavel"></i> Place Bid
                                            </button>
                                        </form>
                                    </div>
                                </c:if>
                                
                                <c:if test="${empty sessionScope.user}">
                                    <div class="login-prompt">
                                        <h3><i class="fas fa-lock"></i> Login Required</h3>
                                        <p>Please login to place a bid on this item.</p>
                                        <a href="${pageContext.request.contextPath}/auth/login" class="login-button">
                                            Login Now
                                        </a>
                                    </div>
                                </c:if>
                            </c:if>
                        </div>
                    </div>
                    
                    <div class="leaderboard">
                        <h3 class="leaderboard-title">
                            <i class="fas fa-trophy"></i> Bidding Leaderboard
                        </h3>
                        <ul class="bid-list" id="bidList">
                            <c:forEach var="bid" items="${bids}">
                                <li class="bid-item">
                                    <div class="bid-info">
                                        <span class="bidder-name">${bid.bidderName}</span>
                                        <span class="bid-time">${bid.bidTime}</span>
                                    </div>
                                    <span class="bid-amount">₹${bid.bidAmount}</span>
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
        </c:if>
        
        <c:if test="${empty auctionItem}">
            <div class="auction-card">
                <div class="auction-content">
                    <div class="login-prompt">
                        <h3><i class="fas fa-clock"></i> No Active Auction</h3>
                        <p>There are currently no active auctions. Please check back later!</p>
                    </div>
                </div>
            </div>
        </c:if>
    </div>

    <script>
        // Countdown Timer
        <c:if test="${not empty auctionItem and auctionItem.status eq 'ACTIVE'}">
        function updateCountdown() {
            const endTime = new Date('${auctionItem.endTime}').getTime();
            const now = new Date().getTime();
            const distance = endTime - now;
            
            if (distance < 0) {
                document.getElementById('countdown').innerHTML = 'Auction Ended';
                location.reload(); // Refresh to show winner
                return;
            }
            
            const hours = Math.floor(distance / (1000 * 60 * 60));
            const minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));
            const seconds = Math.floor((distance % (1000 * 60)) / 1000);
            
            document.getElementById('countdown').innerHTML = 
                `${hours.toString().padStart(2, '0')}:${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
        }
        
        updateCountdown();
        setInterval(updateCountdown, 1000);
        </c:if>
        
        // Bid Form Submission
        <c:if test="${not empty sessionScope.user}">
        document.getElementById('bidForm').addEventListener('submit', function(e) {
            e.preventDefault();
            
            const formData = new FormData(this);
            const bidAmount = formData.get('bidAmount');
            const auctionItemId = formData.get('auctionItemId');
            
            fetch('${pageContext.request.contextPath}/bid/place', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: `bidAmount=${bidAmount}&auctionItemId=${auctionItemId}`
            })
            .then(response => response.json())
            .then(data => {
                if (data.success) {
                    alert(data.message);
                    location.reload();
                } else {
                    alert(data.message);
                }
            })
            .catch(error => {
                console.error('Error:', error);
                alert('An error occurred while placing your bid.');
            });
        });
        </c:if>
        
        // Auto-refresh leaderboard every 5 seconds
        setInterval(function() {
            <c:if test="${not empty auctionItem}">
            fetch('${pageContext.request.contextPath}/bid/current?auctionItemId=${auctionItem.id}')
                .then(response => response.json())
                .then(bids => {
                    const bidList = document.getElementById('bidList');
                    bidList.innerHTML = '';
                    
                    bids.forEach(bid => {
                        const li = document.createElement('li');
                        li.className = 'bid-item';
                        li.innerHTML = `
                            <div class="bid-info">
                                <span class="bidder-name">${bid.bidderName}</span>
                                <span class="bid-time">${bid.bidTime}</span>
                            </div>
                            <span class="bid-amount">₹${bid.bidAmount}</span>
                        `;
                        bidList.appendChild(li);
                    });
                });
            </c:if>
        }, 5000);
    </script>
</body>
</html> 