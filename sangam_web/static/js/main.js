// Global variables
let userData = null;
let currentTab = 'home';

// Landmarks data
const landmarks = [
    {
        id: 'ram_ghat',
        title: 'Ram Ghat',
        subtitle: 'The Sacred Bathing Ghat',
        image: '/static/assets/ram ghat.png',
        story: 'Ram Ghat is one of the most sacred bathing ghats in Ujjain, where pilgrims come to take a holy dip in the Shipra River. According to legend, Lord Rama himself visited this ghat during his exile.',
        significance: 'This ghat is considered one of the 84 ghats mentioned in ancient scriptures and is believed to be blessed by Lord Rama himself.'
    },
    {
        id: 'mahakal_temple',
        title: 'Mahakaleshwar Temple',
        subtitle: 'The Jyotirlinga of Ujjain',
        image: '/static/assets/mahakaleshwar temple.png',
        story: 'The Mahakaleshwar Temple is one of the 12 Jyotirlingas of Lord Shiva and is considered one of the most powerful temples in India.',
        significance: 'This is the only Jyotirlinga that faces south, symbolizing the power of Lord Shiva to protect from all directions.'
    },
    {
        id: 'harsiddhi_temple',
        title: 'Harsiddhi Temple',
        subtitle: 'The Shakti Peeth',
        image: '/static/assets/harsiddhi temple.png',
        story: 'The Harsiddhi Temple is one of the 51 Shakti Peethas, where the elbow of Goddess Sati is believed to have fallen.',
        significance: 'This temple is believed to grant all wishes and is especially powerful for those seeking prosperity and wisdom.'
    },
    {
        id: 'kal_bhairav_temple',
        title: 'Kal Bhairav Temple',
        subtitle: 'The Guardian of Ujjain',
        image: '/static/assets/kal bhairav temple.png',
        story: 'The Kal Bhairav Temple is dedicated to Lord Bhairav, the fierce form of Lord Shiva and the guardian deity of Ujjain.',
        significance: 'Lord Bhairav is considered the Kotwal (guardian) of Ujjain and is believed to protect the city and its devotees.'
    },
    {
        id: 'sandipani_ashram',
        title: 'Sandipani Ashram',
        subtitle: 'The Ancient School of Wisdom',
        image: '/static/assets/sandipani ashram.png',
        story: 'Sandipani Ashram is the ancient school where Lord Krishna, Balarama, and Sudama received their education.',
        significance: 'This ashram is considered the birthplace of divine knowledge and is believed to bless students and seekers with wisdom.'
    },
    {
        id: 'shipra_river',
        title: 'Shipra River',
        subtitle: 'The Sacred River of Ujjain',
        image: '/static/assets/shipra river.png',
        story: 'The Shipra River is considered one of the most sacred rivers in India and is believed to have the power to cleanse sins and purify the soul.',
        significance: 'The Shipra River is considered as sacred as the Ganges and is believed to have the power to grant moksha (liberation).'
    }
];

// Seva quests data
const sevaQuests = [
    {
        id: 'water_service',
        title: 'Jal Seva - Water Service',
        description: 'Help serve water to fellow pilgrims at designated water stations',
        icon: 'fas fa-tint',
        punya: 10,
        badge: 'Jal Sevak',
        color: 'blue'
    },
    {
        id: 'cleanup_drive',
        title: 'Swachh Seva - Cleanup Drive',
        description: 'Participate in keeping the sacred grounds clean and beautiful',
        icon: 'fas fa-broom',
        punya: 15,
        badge: 'Swachh Sevak',
        color: 'green'
    },
    {
        id: 'food_distribution',
        title: 'Ann Seva - Food Distribution',
        description: 'Help distribute prasad and food to devotees',
        icon: 'fas fa-utensils',
        punya: 20,
        badge: 'Ann Sevak',
        color: 'orange'
    },
    {
        id: 'crowd_guidance',
        title: 'Marg Darshan - Crowd Guidance',
        description: 'Help guide fellow pilgrims and maintain orderly queues',
        icon: 'fas fa-directions',
        punya: 12,
        badge: 'Marg Darshak',
        color: 'purple'
    },
    {
        id: 'elderly_help',
        title: 'Vriddha Seva - Elderly Assistance',
        description: 'Assist elderly pilgrims with their needs and comfort',
        icon: 'fas fa-wheelchair',
        punya: 25,
        badge: 'Vriddha Sevak',
        color: 'red'
    },
    {
        id: 'temple_cleaning',
        title: 'Mandir Seva - Temple Cleaning',
        description: 'Help clean and maintain the sacred temple premises',
        icon: 'fas fa-temple',
        punya: 18,
        badge: 'Mandir Sevak',
        color: 'indigo'
    }
];

// Tab management
function showTab(tabName) {
    // Hide all tabs
    const tabs = document.querySelectorAll('.tab-content');
    tabs.forEach(tab => tab.classList.add('hidden'));
    
    // Show selected tab
    const selectedTab = document.getElementById(tabName + 'Tab');
    if (selectedTab) {
        selectedTab.classList.remove('hidden');
    }
    
    // Update navigation
    const navItems = document.querySelectorAll('.nav-item');
    navItems.forEach(item => {
        item.classList.remove('text-orange-600');
        item.classList.add('text-gray-600');
    });
    
    const activeNav = document.querySelector(`[data-tab="${tabName}"]`);
    if (activeNav) {
        activeNav.classList.remove('text-gray-600');
        activeNav.classList.add('text-orange-600');
    }
    
    currentTab = tabName;
    
    // Load tab-specific content
    if (tabName === 'sanskrti') {
        loadLandmarks();
    } else if (tabName === 'seva') {
        loadSevaQuests();
    } else if (tabName === 'profile') {
        loadProfile();
    }
}

// Load user data
async function loadUserData() {
    try {
        const response = await fetch('/api/user_data');
        
        // If we get a 401 or redirect, user is not authenticated
        if (response.status === 401 || response.status === 404) {
            return false;
        }
        
        const data = await response.json();
        
        if (data.success) {
            userData = data.user;
            updatePunyaDisplay();
            return true;
        }
    } catch (error) {
        console.error('Error loading user data:', error);
    }
    return false;
}

// Update punya points display
function updatePunyaDisplay() {
    if (!userData) return;
    
    const punyaElements = document.querySelectorAll('#punyaPoints, #sevaPoints, #profilePunya');
    punyaElements.forEach(el => {
        if (el) el.textContent = userData.punya || 0;
    });
}

// Load landmarks for Sanskrti tab
function loadLandmarks() {
    const grid = document.getElementById('landmarksGrid');
    if (!grid) return;
    
    grid.innerHTML = landmarks.map(landmark => {
        const isVisited = userData && userData.visited_places.includes(landmark.id);
        
        return `
            <div class="relative bg-white rounded-2xl shadow-custom overflow-hidden card-hover cursor-pointer" onclick="openLandmarkDetail('${landmark.id}')">
                <div class="aspect-video relative">
                    <img src="${landmark.image}" alt="${landmark.title}" class="w-full h-full object-cover">
                    <div class="absolute inset-0 bg-gradient-to-t from-black/70 to-transparent"></div>
                    
                    ${isVisited ? `
                        <div class="absolute top-3 left-3 bg-green-600 text-white p-2 rounded-lg">
                            <i class="fas fa-check text-sm"></i>
                        </div>
                    ` : ''}
                    
                    <div class="absolute bottom-0 left-0 right-0 p-4 text-white">
                        <h3 class="text-lg font-bold mb-1">${landmark.title}</h3>
                        <p class="text-sm text-white/90 mb-3">${landmark.subtitle}</p>
                        
                        <button onclick="event.stopPropagation(); markVisited('${landmark.id}')" 
                                class="w-full ${isVisited ? 'bg-green-600' : 'bg-orange-600'} hover:opacity-90 text-white py-2 px-4 rounded-lg text-sm font-semibold transition-opacity">
                            ${isVisited ? 'Visited ✓' : 'Mark Visited'}
                        </button>
                    </div>
                </div>
            </div>
        `;
    }).join('');
}

// Mark landmark as visited
async function markVisited(placeId) {
    try {
        const response = await fetch('/api/mark_visited', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ place_id: placeId })
        });
        
        const data = await response.json();
        
        if (data.success) {
            userData.punya = data.punya;
            userData.visited_places.push(placeId);
            updatePunyaDisplay();
            loadLandmarks();
            showMessage('Landmark marked as visited! +5 punya points', 'success');
        } else if (data.message === 'Already visited') {
            showMessage('You have already visited this landmark', 'info');
        }
    } catch (error) {
        showMessage('Error marking landmark as visited', 'error');
    }
}

// Load seva quests
function loadSevaQuests() {
    const questsContainer = document.getElementById('sevaQuests');
    if (!questsContainer) return;
    
    questsContainer.innerHTML = sevaQuests.map(quest => {
        const isCompleted = userData && userData.completed_seva.includes(quest.id);
        const colorClass = {
            blue: 'blue',
            green: 'green',
            orange: 'orange',
            purple: 'purple',
            red: 'red',
            indigo: 'indigo'
        }[quest.color];
        
        return `
            <div class="bg-white rounded-2xl p-6 shadow-custom">
                <div class="flex items-start mb-4">
                    <div class="w-12 h-12 bg-${colorClass}-100 rounded-xl flex items-center justify-center mr-4 flex-shrink-0">
                        <i class="${quest.icon} text-${colorClass}-600 text-xl"></i>
                    </div>
                    <div class="flex-1">
                        <h3 class="text-lg font-bold text-gray-800 mb-2">${quest.title}</h3>
                        <p class="text-gray-600 text-sm">${quest.description}</p>
                    </div>
                    ${isCompleted ? `
                        <div class="w-10 h-10 bg-green-100 rounded-lg flex items-center justify-center">
                            <i class="fas fa-check-circle text-green-600"></i>
                        </div>
                    ` : ''}
                </div>
                
                <div class="bg-gray-50 rounded-xl p-3 mb-4">
                    <div class="flex items-center space-x-4">
                        <div class="flex items-center">
                            <i class="fas fa-trophy text-orange-600 mr-2"></i>
                            <span class="text-sm font-semibold text-orange-600">${quest.punya} Punya Points</span>
                        </div>
                        <div class="flex items-center">
                            <i class="fas fa-medal text-purple-600 mr-2"></i>
                            <span class="text-sm font-semibold text-purple-600">${quest.badge}</span>
                        </div>
                    </div>
                </div>
                
                <button onclick="completeSeva('${quest.id}', ${quest.punya}, '${quest.badge}')" 
                        ${isCompleted ? 'disabled' : ''}
                        class="w-full ${isCompleted ? 'bg-gray-300 text-gray-600' : `bg-${colorClass}-600 hover:bg-${colorClass}-700 text-white`} py-3 rounded-xl font-semibold transition-colors">
                    ${isCompleted ? 'Completed ✓' : 'I have completed this Seva'}
                </button>
            </div>
        `;
    }).join('');
}

// Complete seva quest
async function completeSeva(sevaId, punyaPoints, badge) {
    try {
        const response = await fetch('/api/complete_seva', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({ 
                seva_id: sevaId, 
                punya: punyaPoints, 
                badge: badge 
            })
        });
        
        const data = await response.json();
        
        if (data.success) {
            userData.punya = data.punya;
            userData.completed_seva.push(sevaId);
            if (!userData.badges.includes(badge)) {
                userData.badges.push(badge);
            }
            updatePunyaDisplay();
            loadSevaQuests();
            showMessage(`Congratulations! You earned ${punyaPoints} punya points and the ${badge} badge!`, 'success');
        }
    } catch (error) {
        showMessage('Error completing seva quest', 'error');
    }
}

// Load profile data
function loadProfile() {
    if (!userData) return;
    
    document.getElementById('userName').textContent = userData.name || 'Unknown';
    document.getElementById('userEmail').textContent = userData.email || 'Unknown';
    document.getElementById('sangamId').textContent = `SANGAM ID: ${userData.sangam_id || 'Unknown'}`;
    
    document.getElementById('profilePunya').textContent = userData.punya || 0;
    document.getElementById('badgeCount').textContent = userData.badges?.length || 0;
    document.getElementById('visitedCount').textContent = userData.visited_places?.length || 0;
    
    // Load badges
    const badgesList = document.getElementById('badgesList');
    if (userData.badges && userData.badges.length > 0) {
        badgesList.innerHTML = userData.badges.map(badge => `
            <div class="bg-purple-100 text-purple-800 px-3 py-2 rounded-lg text-sm font-semibold text-center">
                <i class="fas fa-medal mr-1"></i>
                ${badge}
            </div>
        `).join('');
    } else {
        badgesList.innerHTML = '<p class="text-gray-500 col-span-2">No badges earned yet</p>';
    }
}

// SOS functionality
function showSOSDialog() {
    document.getElementById('sosDialog').classList.remove('hidden');
}

function closeSOS() {
    document.getElementById('sosDialog').classList.add('hidden');
}

// Chatbot functionality
function openChatbot() {
    window.open('/chatbot', '_blank', 'width=400,height=600');
}

// Logout
function logout() {
    window.location.href = '/logout';
}

// Message display
function showMessage(message, type) {
    const messageDiv = document.createElement('div');
    const bgColor = {
        'success': 'bg-green-500',
        'error': 'bg-red-500',
        'info': 'bg-blue-500'
    }[type] || 'bg-gray-500';
    
    messageDiv.className = `fixed top-4 right-4 ${bgColor} text-white px-6 py-3 rounded-lg shadow-lg z-50 opacity-0 transform translate-x-full transition-all duration-300`;
    messageDiv.textContent = message;
    
    document.body.appendChild(messageDiv);
    
    setTimeout(() => {
        messageDiv.classList.remove('opacity-0', 'translate-x-full');
    }, 100);
    
    setTimeout(() => {
        messageDiv.classList.add('opacity-0', 'translate-x-full');
        setTimeout(() => {
            document.body.removeChild(messageDiv);
        }, 300);
    }, 3000);
}

// Landmark detail modal (placeholder)
function openLandmarkDetail(landmarkId) {
    const landmark = landmarks.find(l => l.id === landmarkId);
    if (landmark) {
        showMessage(`Opening details for ${landmark.title}`, 'info');
    }
}

// Initialize app
document.addEventListener('DOMContentLoaded', async function() {
    // Check if we're on the main page (authenticated)
    if (window.location.pathname === '/main') {
        // Load user data
        const userLoaded = await loadUserData();
        
        if (!userLoaded) {
            // Only redirect if we actually failed to load user data
            // and we're not already being redirected
            if (!window.location.href.includes('/login')) {
                window.location.href = '/login';
            }
            return;
        }
        
        // Set initial active tab
        showTab('home');
    }
});