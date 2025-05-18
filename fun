<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Spend Bill Gates' Money</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css">
    <link href="https://cdn.jsdelivr.net/npm/@fortawesome/fontawesome-free@6.0.0/css/all.min.css" rel="stylesheet">
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f8f9fa;
        }
        .header {
            position: sticky;
            top: 0;
            z-index: 50;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }
        .money-display {
            font-size: 3rem;
            font-weight: bold;
            transition: all 0.3s ease;
        }
        .item-card {
            transition: transform 0.2s;
        }
        .item-card:hover {
            transform: translateY(-5px);
        }
        .buy-btn, .sell-btn {
            transition: all 0.2s;
        }
        .buy-btn:hover:not(:disabled) {
            background-color: #38a169;
        }
        .sell-btn:hover:not(:disabled) {
            background-color: #e53e3e;
        }
        .buy-btn:disabled, .sell-btn:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }
        .item-quantity {
            width: 2rem;
            text-align: center;
        }
        .receipt-item {
            border-bottom: 1px solid #e2e8f0;
            padding: 0.5rem 0;
        }
    </style>
</head>
<body>
    <div class="container mx-auto px-4 pb-12">
        <!-- Header -->
        <header class="header bg-white py-4 mb-8">
            <h1 class="text-4xl text-center font-bold mb-2">Spend Bill Gates' Money</h1>
            <div class="money-display text-center text-green-600" id="money-display">$100,000,000,000</div>
        </header>

        <!-- Items Grid -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6" id="items-container">
            <!-- Items will be dynamically inserted here -->
        </div>

        <!-- Receipt Section -->
        <div class="mt-12 bg-white p-6 rounded-lg shadow-md" id="receipt-section">
            <h2 class="text-2xl font-bold mb-4 text-center">Your Receipt</h2>
            <div id="receipt-items" class="mb-4">
                <!-- Receipt items will be added here -->
            </div>
            <div class="flex justify-between font-bold text-lg border-t-2 border-gray-300 pt-4">
                <span>Total:</span>
                <span id="receipt-total">$0</span>
            </div>
            <div class="flex justify-between font-bold text-lg">
                <span>Remaining:</span>
                <span id="receipt-remaining">$100,000,000,000</span>
            </div>
        </div>
    </div>

    <script>
        // Initial money
        let money = 100000000000;
        
        // Items data
        const items = [
            { id: 1, name: "Big Mac", price: 2, image: "https://neal.fun/spend/images/big-mac.jpg", quantity: 0 },
            { id: 2, name: "Flip Flops", price: 3, image: "https://neal.fun/spend/images/flip-flops.jpg", quantity: 0 },
            { id: 3, name: "Coca-Cola Pack", price: 5, image: "https://neal.fun/spend/images/coca-cola-pack.jpg", quantity: 0 },
            { id: 4, name: "Movie Ticket", price: 12, image: "https://neal.fun/spend/images/movie-ticket.jpg", quantity: 0 },
            { id: 5, name: "Book", price: 15, image: "https://neal.fun/spend/images/book.jpg", quantity: 0 },
            { id: 6, name: "Lobster Dinner", price: 45, image: "https://neal.fun/spend/images/lobster-dinner.jpg", quantity: 0 },
            { id: 7, name: "Video Game", price: 60, image: "https://neal.fun/spend/images/video-game.jpg", quantity: 0 },
            { id: 8, name: "Amazon Echo", price: 99, image: "https://neal.fun/spend/images/amazon-echo.jpg", quantity: 0 },
            { id: 9, name: "Year of Netflix", price: 100, image: "https://neal.fun/spend/images/year-of-netflix.jpg", quantity: 0 },
            { id: 10, name: "Air Jordans", price: 125, image: "https://neal.fun/spend/images/air-jordans.jpg", quantity: 0 },
            { id: 11, name: "Airpods", price: 199, image: "https://neal.fun/spend/images/airpods.jpg", quantity: 0 },
            { id: 12, name: "Gaming Console", price: 299, image: "https://neal.fun/spend/images/gaming-console.jpg", quantity: 0 },
            { id: 13, name: "Drone", price: 350, image: "https://neal.fun/spend/images/drone.jpg", quantity: 0 },
            { id: 14, name: "Smartphone", price: 699, image: "https://neal.fun/spend/images/smartphone.jpg", quantity: 0 },
            { id: 15, name: "Bike", price: 800, image: "https://neal.fun/spend/images/bike.jpg", quantity: 0 },
            { id: 16, name: "Kitten", price: 1500, image: "https://neal.fun/spend/images/kitten.jpg", quantity: 0 },
            { id: 17, name: "Puppy", price: 1500, image: "https://neal.fun/spend/images/puppy.jpg", quantity: 0 },
            { id: 18, name: "Auto Rickshaw", price: 2300, image: "https://neal.fun/spend/images/auto-rickshaw.jpg", quantity: 0 },
            { id: 19, name: "Horse", price: 2500, image: "https://neal.fun/spend/images/horse.jpg", quantity: 0 },
            { id: 20, name: "Acre of Farmland", price: 3000, image: "https://neal.fun/spend/images/acre-of-farmland.jpg", quantity: 0 },
            { id: 21, name: "Designer Handbag", price: 5500, image: "https://neal.fun/spend/images/designer-handbag.jpg", quantity: 0 },
            { id: 22, name: "Hot Tub", price: 6000, image: "https://neal.fun/spend/images/hot-tub.jpg", quantity: 0 },
            { id: 23, name: "Luxury Wine", price: 7000, image: "https://neal.fun/spend/images/luxury-wine.jpg", quantity: 0 },
            { id: 24, name: "Diamond Ring", price: 10000, image: "https://neal.fun/spend/images/diamond-ring.jpg", quantity: 0 },
            { id: 25, name: "Jet Ski", price: 12000, image: "https://neal.fun/spend/images/jet-ski.jpg", quantity: 0 },
            { id: 26, name: "Rolex", price: 15000, image: "https://neal.fun/spend/images/rolex.jpg", quantity: 0 },
            { id: 27, name: "Ford F-150", price: 30000, image: "https://neal.fun/spend/images/ford-f-150.jpg", quantity: 0 },
            { id: 28, name: "Tesla", price: 75000, image: "https://neal.fun/spend/images/tesla.jpg", quantity: 0 },
            { id: 29, name: "Monster Truck", price: 150000, image: "https://neal.fun/spend/images/monster-truck.jpg", quantity: 0 },
            { id: 30, name: "Ferrari", price: 250000, image: "https://neal.fun/spend/images/ferrari.jpg", quantity: 0 },
            { id: 31, name: "Single Family Home", price: 300000, image: "https://neal.fun/spend/images/single-family-home.jpg", quantity: 0 },
            { id: 32, name: "Gold Bar", price: 700000, image: "https://neal.fun/spend/images/gold-bar.jpg", quantity: 0 },
            { id: 33, name: "McDonalds Franchise", price: 1500000, image: "https://neal.fun/spend/images/mcdonalds-franchise.jpg", quantity: 0 },
            { id: 34, name: "Superbowl Ad", price: 5250000, image: "https://neal.fun/spend/images/superbowl-ad.jpg", quantity: 0 },
            { id: 35, name: "Yacht", price: 7500000, image: "https://neal.fun/spend/images/yacht.jpg", quantity: 0 },
            { id: 36, name: "M1 Abrams", price: 8000000, image: "https://neal.fun/spend/images/m1-abrams.jpg", quantity: 0 },
            { id: 37, name: "Formula 1 Car", price: 15000000, image: "https://neal.fun/spend/images/formula-1-car.jpg", quantity: 0 },
            { id: 38, name: "Apache Helicopter", price: 31000000, image: "https://neal.fun/spend/images/apache-helicopter.jpg", quantity: 0 },
            { id: 39, name: "Mansion", price: 45000000, image: "https://neal.fun/spend/images/mansion.jpg", quantity: 0 },
            { id: 40, name: "Make a Movie", price: 100000000, image: "https://neal.fun/spend/images/make-a-movie.jpg", quantity: 0 },
            { id: 41, name: "Boeing 747", price: 148000000, image: "https://neal.fun/spend/images/boeing-747.jpg", quantity: 0 },
            { id: 42, name: "Mona Lisa", price: 780000000, image: "https://neal.fun/spend/images/mona-lisa.jpg", quantity: 0 },
            { id: 43, name: "Skyscraper", price: 850000000, image: "https://neal.fun/spend/images/skyscraper.jpg", quantity: 0 },
            { id: 44, name: "Cruise Ship", price: 930000000, image: "https://neal.fun/spend/images/cruise-ship.jpg", quantity: 0 },
            { id: 45, name: "NBA Team", price: 2120000000, image: "https://neal.fun/spend/images/nba-team.jpg", quantity: 0 },
        ];

        // Format number as currency
        function formatMoney(number) {
            return new Intl.NumberFormat('en-US', {
                style: 'currency',
                currency: 'USD',
                maximumFractionDigits: 0
            }).format(number);
        }

        // Update money display
        function updateMoneyDisplay() {
            const moneyDisplay = document.getElementById('money-display');
            moneyDisplay.textContent = formatMoney(money);
            
            // Change color based on remaining money
            if (money < 0) {
                moneyDisplay.classList.remove('text-green-600');
                moneyDisplay.classList.add('text-red-600');
            } else {
                moneyDisplay.classList.remove('text-red-600');
                moneyDisplay.classList.add('text-green-600');
            }
        }

        // Buy item
        function buyItem(id) {
            const item = items.find(item => item.id === id);
            if (money >= item.price) {
                money -= item.price;
                item.quantity += 1;
                updateMoneyDisplay();
                updateItemDisplay(item);
                updateReceiptDisplay();
            }
        }

        // Sell item
        function sellItem(id) {
            const item = items.find(item => item.id === id);
            if (item.quantity > 0) {
                money += item.price;
                item.quantity -= 1;
                updateMoneyDisplay();
                updateItemDisplay(item);
                updateReceiptDisplay();
            }
        }

        // Update item display
        function updateItemDisplay(item) {
            const quantityElement = document.getElementById(`quantity-${item.id}`);
            const sellButton = document.getElementById(`sell-btn-${item.id}`);
            const buyButton = document.getElementById(`buy-btn-${item.id}`);
            
            quantityElement.textContent = item.quantity;
            
            // Enable/disable sell button
            if (item.quantity <= 0) {
                sellButton.disabled = true;
            } else {
                sellButton.disabled = false;
            }
            
            // Enable/disable buy button
            if (money < item.price) {
                buyButton.disabled = true;
            } else {
                buyButton.disabled = false;
            }
            
            // Update buy buttons for all items
            items.forEach(item => {
                const btn = document.getElementById(`buy-btn-${item.id}`);
                if (money < item.price) {
                    btn.disabled = true;
                } else {
                    btn.disabled = false;
                }
            });
        }

        // Update receipt display
        function updateReceiptDisplay() {
            const receiptItems = document.getElementById('receipt-items');
            const receiptTotal = document.getElementById('receipt-total');
            const receiptRemaining = document.getElementById('receipt-remaining');
            
            // Clear existing items
            receiptItems.innerHTML = '';
            
            // Calculate total spent
            let totalSpent = 0;
            
            // Add items to receipt
            items.forEach(item => {
                if (item.quantity > 0) {
                    const itemCost = item.price * item.quantity;
                    totalSpent += itemCost;
                    
                    const receiptItem = document.createElement('div');
                    receiptItem.className = 'receipt-item flex justify-between';
                    receiptItem.innerHTML = `
                        <span>${item.name} × ${item.quantity}</span>
                        <span>${formatMoney(itemCost)}</span>
                    `;
                    receiptItems.appendChild(receiptItem);
                }
            });
            
            // Update total and remaining
            receiptTotal.textContent = formatMoney(totalSpent);
            receiptRemaining.textContent = formatMoney(money);
        }

        // Generate item cards
        function generateItemCards() {
            const container = document.getElementById('items-container');
            
            items.forEach(item => {
                const card = document.createElement('div');
                card.className = 'item-card bg-white rounded-lg shadow-md overflow-hidden';
                card.innerHTML = `
                    <div class="p-3 flex flex-col items-center">
                        <img src="${item.image}" alt="${item.name}" class="h-48 w-auto object-contain mb-3">
                        <h3 class="text-xl font-semibold mb-1">${item.name}</h3>
                        <p class="text-green-600 font-bold mb-4">${formatMoney(item.price)}</p>
                        <div class="flex items-center">
                            <button id="sell-btn-${item.id}" class="sell-btn bg-red-500 text-white px-4 py-2 rounded-l-md disabled:opacity-50" onclick="sellItem(${item.id})" disabled>Sell</button>
                            <span id="quantity-${item.id}" class="bg-gray-100 py-2 px-3 item-quantity">0</span>
                            <button id="buy-btn-${item.id}" class="buy-btn bg-green-500 text-white px-4 py-2 rounded-r-md" onclick="buyItem(${item.id})">Buy</button>
                        </div>
                    </div>
                `;
                container.appendChild(card);
            });
        }

        // Initialize
        document.addEventListener('DOMContentLoaded', function() {
            generateItemCards();
            updateMoneyDisplay();
        });
    </script>
</body>
</html>
