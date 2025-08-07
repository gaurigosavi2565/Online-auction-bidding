// AuctionHub - Complete Frontend Auction System
class AuctionHub {
    constructor() {
        this.currentItem = null;
        this.bids = [];
        this.timer = null;
        this.timeLeft = 300; // 5 minutes in seconds
        this.isAuctionActive = true;
        this.currentUser = this.getCurrentUser();
        
        this.init();
    }
    
    init() {
        this.generateRandomItem();
        this.startTimer();
        this.loadBids();
        this.setupEventListeners();
        this.updateUI();
    }
    
    // Random Item Generation
    generateRandomItem() {
        const items = [
            { name: "Antique Gold Watch", basePrice: 15000, category: "watches", imageUrl: "https://source.unsplash.com/400x300/?luxury+watch" },
            { name: "Vintage Camera", basePrice: 25000, category: "cameras", imageUrl: "https://source.unsplash.com/400x300/?vintage+camera" },
            { name: "Classic Car Model", basePrice: 35000, category: "cars", imageUrl: "https://source.unsplash.com/400x300/?classic+car" },
            { name: "Rare Coin Collection", basePrice: 45000, category: "coins", imageUrl: "https://source.unsplash.com/400x300/?rare+coins" },
            { name: "Art Deco Vase", basePrice: 55000, category: "art", imageUrl: "https://source.unsplash.com/400x300/?art+deco+vase" },
            { name: "Signed Baseball", basePrice: 75000, category: "sports", imageUrl: "https://source.unsplash.com/400x300/?signed+baseball" },
            { name: "Limited Edition Book", basePrice: 85000, category: "books", imageUrl: "https://source.unsplash.com/400x300/?rare+book" },
            { name: "Vintage Guitar", basePrice: 95000, category: "music", imageUrl: "https://source.unsplash.com/400x300/?vintage+guitar" },
            { name: "Antique Jewelry Box", basePrice: 120000, category: "jewelry", imageUrl: "https://source.unsplash.com/400x300/?jewelry+box" },
            { name: "Rare Stamp Collection", basePrice: 150000, category: "stamps", imageUrl: "https://source.unsplash.com/400x300/?rare+stamps" },
            { name: "Vintage Vinyl Record", basePrice: 180000, category: "music", imageUrl: "https://source.unsplash.com/400x300/?vinyl+record" },
            { name: "Classic Painting", basePrice: 220000, category: "art", imageUrl: "https://source.unsplash.com/400x300/?classic+painting" },
            { name: "Antique Furniture", basePrice: 280000, category: "furniture", imageUrl: "https://source.unsplash.com/400x300/?antique+furniture" },
            { name: "Vintage Camera Lens", basePrice: 350000, category: "cameras", imageUrl: "https://source.unsplash.com/400x300/?camera+lens" },
            { name: "Rare Wine Bottle", basePrice: 450000, category: "wine", imageUrl: "https://source.unsplash.com/400x300/?rare+wine" },
            { name: "Classic Motorcycle", basePrice: 550000, category: "vehicles", imageUrl: "https://source.unsplash.com/400x300/?classic+motorcycle" },
            { name: "Antique Clock", basePrice: 750000, category: "clocks", imageUrl: "https://source.unsplash.com/400x300/?antique+clock" },
            { name: "Vintage Typewriter", basePrice: 950000, category: "machines", imageUrl: "https://source.unsplash.com/400x300/?typewriter" },
            { name: "Rare Comic Book", basePrice: 1200000, category: "comics", imageUrl: "https://source.unsplash.com/400x300/?comic+book" },
            { name: "Classic Sculpture", basePrice: 1500000, category: "art", imageUrl: "https://source.unsplash.com/400x300/?sculpture" }
        ];
        
        const randomItem = items[Math.floor(Math.random() * items.length)];
        
        this.currentItem = {
            id: Date.now(),
            name: randomItem.name,
            basePrice: randomItem.basePrice,
            imageUrl: randomItem.imageUrl,
            category: randomItem.category,
            startTime: new Date(),
            endTime: new Date(Date.now() + 300000) // 5 minutes from now
        };
        
        this.updateItemDisplay();
    }
    
    updateItemDisplay() {
        document.getElementById('itemName').textContent = this.currentItem.name;
        document.getElementById('basePrice').textContent = `₹${this.currentItem.basePrice.toLocaleString()}`;
        document.getElementById('itemImage').src = this.currentItem.imageUrl;
        document.getElementById('itemImage').alt = this.currentItem.name;
    }
    
    // Timer Management
    startTimer() {
        this.timer = setInterval(() => {
            this.timeLeft--;
            this.updateTimerDisplay();
            
            if (this.timeLeft <= 0) {
                this.endAuction();
            }
        }, 1000);
    }
    
    updateTimerDisplay() {
        const minutes = Math.floor(this.timeLeft / 60);
        const seconds = this.timeLeft % 60;
        
        document.getElementById('minutes').textContent = minutes.toString().padStart(2, '0');
        document.getElementById('seconds').textContent = seconds.toString().padStart(2, '0');
        
        // Change color when time is running low
        const timerElement = document.getElementById('timer');
        if (this.timeLeft <= 60) {
            timerElement.style.background = 'linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%)';
            timerElement.style.animation = 'pulse 1s infinite';
        } else if (this.timeLeft <= 120) {
            timerElement.style.background = 'linear-gradient(135deg, #feca57 0%, #ff9ff3 100%)';
        }
    }
    
    endAuction() {
        clearInterval(this.timer);
        this.isAuctionActive = false;
        
        document.getElementById('itemStatus').textContent = 'ENDED';
        document.getElementById('itemStatus').style.background = 'linear-gradient(135deg, #ff6b6b 0%, #ee5a24 100%)';
        
        const winner = this.getWinner();
        this.showWinnerAnnouncement(winner);
        this.saveWonItem(winner);
        
        // Disable bidding
        document.getElementById('bidForm').style.display = 'none';
        document.getElementById('bidButton').disabled = true;
    }
    
    getWinner() {
        if (this.bids.length === 0) {
            return null;
        }
        
        // Sort by bid amount (highest first) and then by time (earliest first)
        const sortedBids = [...this.bids].sort((a, b) => {
            if (b.amount !== a.amount) {
                return b.amount - a.amount;
            }
            return new Date(a.time) - new Date(b.time);
        });
        
        return sortedBids[0];
    }
    
    showWinnerAnnouncement(winner) {
        const winnerAnnouncement = document.getElementById('winnerAnnouncement');
        const winnerMessage = document.getElementById('winnerMessage');
        
        if (winner) {
            winnerMessage.textContent = `Item sold to ${winner.bidderName} for ₹${winner.amount.toLocaleString()}`;
        } else {
            winnerMessage.textContent = 'No bids were placed. Item remains unsold.';
        }
        
        winnerAnnouncement.style.display = 'block';
        winnerAnnouncement.scrollIntoView({ behavior: 'smooth' });
    }
    
    // Bidding System
    placeBid(bidderName, amount) {
        if (!this.isAuctionActive) {
            this.showToast('Auction has ended!', 'error');
            return false;
        }
        
        if (amount <= this.currentItem.basePrice) {
            this.showToast(`Bid must be higher than base price (₹${this.currentItem.basePrice.toLocaleString()})`, 'error');
            return false;
        }
        
        const highestBid = this.getHighestBid();
        if (highestBid && amount <= highestBid.amount) {
            this.showToast(`Bid must be higher than current highest bid (₹${highestBid.amount.toLocaleString()})`, 'error');
            return false;
        }
        
        const newBid = {
            id: Date.now(),
            bidderName: bidderName,
            amount: amount,
            time: new Date(),
            itemId: this.currentItem.id
        };
        
        this.bids.push(newBid);
        this.saveBids();
        this.updateBidsDisplay();
        this.updateCurrentBidDisplay();
        
        this.showToast(`Bid placed successfully! ₹${amount.toLocaleString()}`, 'success');
        return true;
    }
    
    getHighestBid() {
        if (this.bids.length === 0) return null;
        return this.bids.reduce((highest, bid) => bid.amount > highest.amount ? bid : highest);
    }
    
    updateCurrentBidDisplay() {
        const highestBid = this.getHighestBid();
        const currentBidElement = document.getElementById('currentBid');
        const bidderInfoElement = document.getElementById('bidderInfo');
        
        if (highestBid) {
            currentBidElement.textContent = `₹${highestBid.amount.toLocaleString()}`;
            bidderInfoElement.innerHTML = `
                <strong>${highestBid.bidderName}</strong> is currently winning
                <br><small>Bid placed at ${highestBid.time.toLocaleTimeString()}</small>
            `;
            bidderInfoElement.style.display = 'block';
        } else {
            currentBidElement.textContent = 'No bids yet';
            bidderInfoElement.style.display = 'none';
        }
    }
    
    updateBidsDisplay() {
        const bidsList = document.getElementById('bidsList');
        
        if (this.bids.length === 0) {
            bidsList.innerHTML = '<div class="no-bids">No bids placed yet. Be the first to bid!</div>';
            return;
        }
        
        // Sort bids by amount (highest first) and then by time (earliest first)
        const sortedBids = [...this.bids].sort((a, b) => {
            if (b.amount !== a.amount) {
                return b.amount - a.amount;
            }
            return new Date(a.time) - new Date(b.time);
        });
        
        bidsList.innerHTML = sortedBids.map(bid => `
            <div class="bid-item">
                <div class="bid-info">
                    <div class="bidder-name">${bid.bidderName}</div>
                    <div class="bid-time">${bid.time.toLocaleTimeString()}</div>
                </div>
                <div class="bid-amount">₹${bid.amount.toLocaleString()}</div>
            </div>
        `).join('');
    }
    
    // Local Storage Management
    saveBids() {
        localStorage.setItem('auctionBids', JSON.stringify(this.bids));
    }
    
    loadBids() {
        const savedBids = localStorage.getItem('auctionBids');
        if (savedBids) {
            this.bids = JSON.parse(savedBids).map(bid => ({
                ...bid,
                time: new Date(bid.time)
            }));
        }
    }
    
    saveWonItem(winner) {
        if (!winner) return;
        
        const wonItems = this.getWonItems();
        const wonItem = {
            id: Date.now(),
            itemName: this.currentItem.name,
            itemImage: this.currentItem.imageUrl,
            winningBid: winner.amount,
            winnerName: winner.bidderName,
            date: new Date().toISOString(),
            itemId: this.currentItem.id
        };
        
        wonItems.push(wonItem);
        localStorage.setItem('wonItems', JSON.stringify(wonItems));
    }
    
    getWonItems() {
        const savedItems = localStorage.getItem('wonItems');
        return savedItems ? JSON.parse(savedItems) : [];
    }
    
    getCurrentUser() {
        return localStorage.getItem('currentUser') || 'Guest User';
    }
    
    setCurrentUser(name) {
        this.currentUser = name;
        localStorage.setItem('currentUser', name);
    }
    
    // UI Management
    updateUI() {
        this.updateCurrentBidDisplay();
        this.updateBidsDisplay();
        this.updateProfileDisplay();
    }
    
    updateProfileDisplay() {
        const wonItems = this.getWonItems();
        const userWonItems = wonItems.filter(item => item.winnerName === this.currentUser);
        
        document.getElementById('userName').textContent = this.currentUser;
        document.getElementById('totalWon').textContent = userWonItems.length;
        
        const wonItemsGrid = document.getElementById('wonItemsGrid');
        if (userWonItems.length === 0) {
            wonItemsGrid.innerHTML = '<div class="no-items">You haven\'t won any items yet.</div>';
        } else {
            wonItemsGrid.innerHTML = userWonItems.map(item => `
                <div class="won-item">
                    <img src="${item.itemImage}" alt="${item.itemName}" style="width: 100%; height: 150px; object-fit: cover; border-radius: 8px; margin-bottom: 1rem;">
                    <h4>${item.itemName}</h4>
                    <div class="price">Winning Bid: ₹${item.winningBid.toLocaleString()}</div>
                    <div class="date">Won on ${new Date(item.date).toLocaleDateString()}</div>
                </div>
            `).join('');
        }
    }
    
    // Event Listeners
    setupEventListeners() {
        // Bid form submission
        document.getElementById('bidForm').addEventListener('submit', (e) => {
            e.preventDefault();
            
            const bidderName = document.getElementById('bidderName').value.trim();
            const bidAmount = parseFloat(document.getElementById('bidAmount').value);
            
            if (!bidderName) {
                this.showToast('Please enter your name', 'error');
                return;
            }
            
            if (isNaN(bidAmount) || bidAmount <= 0) {
                this.showToast('Please enter a valid bid amount', 'error');
                return;
            }
            
            if (this.placeBid(bidderName, bidAmount)) {
                document.getElementById('bidForm').reset();
                this.setCurrentUser(bidderName);
            }
        });
        
        // Navigation
        document.querySelectorAll('.nav-link').forEach(link => {
            link.addEventListener('click', (e) => {
                e.preventDefault();
                const target = e.target.getAttribute('href').substring(1);
                this.showSection(target);
                
                // Update active nav link
                document.querySelectorAll('.nav-link').forEach(l => l.classList.remove('active'));
                e.target.classList.add('active');
            });
        });
    }
    
    showSection(sectionName) {
        // Hide all sections
        document.querySelectorAll('section').forEach(section => {
            section.style.display = 'none';
        });
        
        // Show target section
        const targetSection = document.getElementById(sectionName);
        if (targetSection) {
            targetSection.style.display = 'block';
            targetSection.scrollIntoView({ behavior: 'smooth' });
        }
    }
    
    // Toast Notifications
    showToast(message, type = 'success') {
        const toast = document.getElementById('toast');
        const toastMessage = toast.querySelector('.toast-message');
        
        toast.className = `toast ${type}`;
        toastMessage.textContent = message;
        
        toast.classList.add('show');
        
        setTimeout(() => {
            toast.classList.remove('show');
        }, 3000);
    }
}

// Global Functions
function startNewAuction() {
    location.reload();
}

function showAuction() {
    document.querySelectorAll('section').forEach(section => {
        section.style.display = 'none';
    });
    document.getElementById('auction').style.display = 'block';
    
    // Update active nav link
    document.querySelectorAll('.nav-link').forEach(link => link.classList.remove('active'));
    document.querySelector('a[href="#auction"]').classList.add('active');
}

// Initialize the application
document.addEventListener('DOMContentLoaded', () => {
    window.auctionHub = new AuctionHub();
    
    // Add CSS animation for timer pulse
    const style = document.createElement('style');
    style.textContent = `
        @keyframes pulse {
            0% { transform: scale(1); }
            50% { transform: scale(1.05); }
            100% { transform: scale(1); }
        }
    `;
    document.head.appendChild(style);
});

// Auto-refresh bids every 5 seconds for real-time feel
setInterval(() => {
    if (window.auctionHub && window.auctionHub.isAuctionActive) {
        window.auctionHub.updateBidsDisplay();
    }
}, 5000); 