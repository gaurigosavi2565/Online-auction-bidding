<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile - AuctionHub</title>
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
        
        .main-container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }
        
        .profile-header {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            padding: 2rem;
            margin-bottom: 2rem;
            text-align: center;
        }
        
        .profile-avatar {
            width: 120px;
            height: 120px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            font-weight: 700;
            margin: 0 auto 1rem;
        }
        
        .profile-name {
            font-size: 2rem;
            font-weight: 700;
            color: #333;
            margin-bottom: 0.5rem;
        }
        
        .profile-email {
            color: #666;
            margin-bottom: 1rem;
        }
        
        .profile-stats {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-top: 1.5rem;
        }
        
        .stat-item {
            text-align: center;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            color: #667eea;
        }
        
        .stat-label {
            color: #666;
            font-size: 0.9rem;
        }
        
        .content-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 2rem;
        }
        
        .section-card {
            background: white;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            overflow: hidden;
        }
        
        .section-header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem;
            text-align: center;
        }
        
        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
        }
        
        .section-content {
            padding: 1.5rem;
        }
        
        .item-card {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 1rem;
            border: 1px solid #e1e5e9;
            border-radius: 10px;
            margin-bottom: 1rem;
        }
        
        .item-card:last-child {
            margin-bottom: 0;
        }
        
        .item-image {
            width: 80px;
            height: 80px;
            object-fit: cover;
            border-radius: 10px;
        }
        
        .item-info {
            flex: 1;
        }
        
        .item-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.25rem;
        }
        
        .item-price {
            color: #667eea;
            font-weight: 600;
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
            flex: 1;
        }
        
        .bid-item-name {
            font-weight: 600;
            color: #333;
            margin-bottom: 0.25rem;
        }
        
        .bid-time {
            font-size: 0.9rem;
            color: #666;
        }
        
        .bid-amount {
            font-weight: 700;
            color: #667eea;
        }
        
        .empty-state {
            text-align: center;
            padding: 3rem;
            color: #666;
        }
        
        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
        
        @media (max-width: 768px) {
            .content-grid {
                grid-template-columns: 1fr;
            }
            
            .profile-stats {
                flex-direction: column;
                gap: 1rem;
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
                <a href="${pageContext.request.contextPath}/profile">Profile</a>
                <a href="${pageContext.request.contextPath}/auth/logout">Logout</a>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="main-container">
        <!-- Profile Header -->
        <div class="profile-header">
            <div class="profile-avatar">
                ${user.name.charAt(0)}
            </div>
            <h1 class="profile-name">${user.name}</h1>
            <p class="profile-email">${user.email}</p>
            <p>Member since ${user.joinDate}</p>
            
            <div class="profile-stats">
                <div class="stat-item">
                    <div class="stat-number">${totalBids}</div>
                    <div class="stat-label">Total Bids</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">${wonItems.size()}</div>
                    <div class="stat-label">Won Items</div>
                </div>
            </div>
        </div>

        <!-- Content Grid -->
        <div class="content-grid">
            <!-- Won Items Section -->
            <div class="section-card">
                <div class="section-header">
                    <h2 class="section-title">
                        <i class="fas fa-trophy"></i> Won Items
                    </h2>
                </div>
                <div class="section-content">
                    <c:if test="${not empty wonItems}">
                        <c:forEach var="item" items="${wonItems}">
                            <div class="item-card">
                                <img src="${item.imageUrl}" alt="${item.name}" class="item-image">
                                <div class="item-info">
                                    <div class="item-name">${item.name}</div>
                                    <div class="item-price">Won for ₹${item.basePrice}</div>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty wonItems}">
                        <div class="empty-state">
                            <i class="fas fa-trophy"></i>
                            <h3>No Won Items Yet</h3>
                            <p>Start bidding to win your first item!</p>
                        </div>
                    </c:if>
                </div>
            </div>

            <!-- Bidding History Section -->
            <div class="section-card">
                <div class="section-header">
                    <h2 class="section-title">
                        <i class="fas fa-history"></i> Bidding History
                    </h2>
                </div>
                <div class="section-content">
                    <c:if test="${not empty bidHistory}">
                        <c:forEach var="bid" items="${bidHistory}">
                            <div class="bid-item">
                                <div class="bid-info">
                                    <div class="bid-item-name">${bid.itemName}</div>
                                    <div class="bid-time">${bid.bidTime}</div>
                                </div>
                                <div class="bid-amount">₹${bid.bidAmount}</div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty bidHistory}">
                        <div class="empty-state">
                            <i class="fas fa-history"></i>
                            <h3>No Bidding History</h3>
                            <p>Start bidding to see your history here!</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 