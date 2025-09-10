from flask import Flask, render_template, request, jsonify, session, redirect, url_for
from werkzeug.security import generate_password_hash, check_password_hash
from functools import wraps
import os
from data_models import LANDMARKS_DATA, SEVA_QUESTS_DATA, ICON_MAPPING

app = Flask(__name__)

# Best Practice: Load secret key from environment variable for security.
# A default is provided for development convenience.
app.secret_key = os.environ.get('SECRET_KEY', 'sangam_super_secret_key_2025_dev')

# --- In-memory Database ---
# WARNING: This is for demonstration purposes only. All data will be lost on restart.
# In a production environment, this MUST be replaced with a proper database (e.g., SQLite, PostgreSQL).
users_db = {}


# --- Decorator for Authentication ---
# Best Practice: Use a decorator to avoid repeating the session check in every route.
def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        if 'user_id' not in session:
            # For API endpoints, return a JSON error; for pages, redirect.
            if request.path.startswith('/api/'):
                return jsonify({'success': False, 'message': 'Authentication required'}), 401
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated_function


# --- Page Routes ---

@app.route('/')
def home():
    # If user is logged in, redirect to main app
    if 'user_id' in session:
        return redirect(url_for('main'))
    # Otherwise show landing page
    return render_template('landing.html', on_login_page=True)

@app.route('/login')
def login():
    # If a user who is already logged in tries to visit the login page,
    # redirect them to the main application page.
    if 'user_id' in session:
        return redirect(url_for('main'))
    # Pass a flag to the template to indicate this is the login page.
    # This is CRUCIAL to prevent the redirect loop.
    return render_template('login.html', on_login_page=True)

# Apply the login_required decorator to all protected page routes
@app.route('/main')
@login_required
def main():
    return render_template('main.html', active_tab='home')

@app.route('/sanskrti')
@login_required
def sanskrti():
    return render_template('main.html', active_tab='sanskrti')

@app.route('/seva')
@login_required
def seva():
    return render_template('main.html', active_tab='seva')

@app.route('/profile')
@login_required
def profile():
    return render_template('main.html', active_tab='profile')

@app.route('/chatbot')
@login_required
def chatbot():
    return render_template('chatbot.html')


# --- Authentication API Routes ---

@app.route('/register', methods=['POST'])
def register():
    data = request.json
    name = data.get('name')
    email = data.get('email')
    mobile = data.get('mobile')
    password = data.get('password')

    if not all([name, email, password, mobile]):
        return jsonify({'success': False, 'message': 'Missing required fields'}), 400

    if email in users_db:
        return jsonify({'success': False, 'message': 'Email already exists'}), 409

    # Security: Hash the password before storing it
    hashed_password = generate_password_hash(password)

    # Note: SANGAM ID generation is not ideal for production.
    # A database primary key or UUID would be better.
    sangam_id = f"SNG{len(users_db) + 1001:04d}"

    users_db[email] = {
        'name': name,
        'email': email,
        'mobile': mobile,
        'password': hashed_password, # Store the hash, not the plaintext password
        'sangam_id': sangam_id,
        'punya': 0,
        'badges': [],
        'visited_places': [],
        'completed_seva': []
    }

    return jsonify({
        'success': True,
        'message': f'Welcome to S.A.N.G.A.M, {name}! Your SANGAM ID: {sangam_id}',
        'sangam_id': sangam_id
    }), 201

@app.route('/login_user', methods=['POST'])
def login_user():
    data = request.json
    email = data.get('email')
    password = data.get('password')

    user = users_db.get(email)

    # Security: Use check_password_hash to securely compare passwords
    if not user or not check_password_hash(user['password'], password):
        return jsonify({'success': False, 'message': 'Invalid email or password'}), 401

    session['user_id'] = email
    
    # Create a user object to return, excluding the password hash for security
    user_data_to_return = user.copy()
    del user_data_to_return['password']
    
    return jsonify({
        'success': True,
        'message': f'Welcome back, {user["name"]}!',
        'user': user_data_to_return
    })

@app.route('/sacred-streams')
@login_required
def sacred_streams():
    """Sacred Streams story page"""
    return render_template('story.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

@app.route('/test_login')
def test_login():
    # Create Chinmay's account for testing
    chinmay_email = 'chinmay.p0704@gmail.com'
    if chinmay_email not in users_db:
        users_db[chinmay_email] = {
            'name': 'Chinmay',
            'email': chinmay_email,
            'mobile': '9106688138',
            'password': 'chinmay123',
            'sangam_id': 'sangam_00001',
            'punya': 75,
            'badges': ['Early Adopter', 'Temple Visitor'],
            'visited_places': ['ram_ghat', 'mahakal_temple'],
            'completed_seva': ['water_service', 'cleanup_drive']
        }
    
    session['user_id'] = chinmay_email
    return redirect(url_for('main'))


# --- Functional API Routes ---

@app.route('/api/user_data')
@login_required
def get_user_data():
    user_email = session['user_id']
    user = users_db.get(user_email)
    
    if user:
        # Best Practice: Never send the password hash to the client
        user_data_to_return = user.copy()
        del user_data_to_return['password']
        return jsonify({'success': True, 'user': user_data_to_return})
        
    return jsonify({'success': False, 'message': 'User not found'}), 404

@app.route('/api/mark_visited', methods=['POST'])
@login_required
def mark_visited():
    user = users_db[session['user_id']]
    place_id = request.json.get('place_id')

    if place_id in user['visited_places']:
        return jsonify({'success': False, 'message': 'Already visited'}), 409
        
    user['visited_places'].append(place_id)
    user['punya'] += 5
    return jsonify({'success': True, 'punya': user['punya']})

@app.route('/api/complete_seva', methods=['POST'])
@login_required
def complete_seva():
    user = users_db[session['user_id']]
    data = request.json
    seva_id = data.get('seva_id')
    punya_points = data.get('punya', 0)
    badge = data.get('badge')

    if seva_id in user['completed_seva']:
        return jsonify({'success': False, 'message': 'Seva already completed'}), 409

    user['completed_seva'].append(seva_id)
    user['punya'] += punya_points
    if badge and badge not in user['badges']:
        user['badges'].append(badge)
        
    return jsonify({
        'success': True,
        'punya': user['punya'],
        'badge': badge
    })

@app.route('/api/chatbot', methods=['POST'])
def chatbot_api():
    data = request.json
    message = data.get('message', '')
    
    # Simple chatbot responses (replace with actual AI integration)
    responses = {
        'hello': 'Namaste! I am Sangam Sathi. How can I help you plan your Ujjain yatra?',
        'ujjain': 'Ujjain is one of the seven sacred cities of India, known for the Mahakaleshwar Temple.',
        'temple': 'The main temples in Ujjain are Mahakaleshwar, Harsiddhi, and Kal Bhairav.',
        'default': 'I can help you with information about Ujjain temples, travel tips, and pilgrimage guidance.'
    }
    
    message_lower = message.lower()
    response = responses.get('default')
    
    for key in responses:
        if key in message_lower:
            response = responses[key]
            break
    
    return jsonify({'response': response})

@app.route('/api/sos', methods=['POST'])
@login_required
def sos_alert():
    user = users_db[session['user_id']]
    # In a real app, this would send actual SOS alerts
    return jsonify({
        'success': True,
        'message': f'SOS Alert sent for {user["name"]} with current location to emergency contacts and authorities.'
    })

# --- Sanskrti (Landmarks) API Routes ---

@app.route('/api/landmarks')
@login_required
def get_landmarks():
    """Get all landmarks for Sanskrti module"""
    user_email = session['user_id']
    user = users_db.get(user_email)
    visited_places = user.get('visited_places', []) if user else []
    
    # Add visited status to landmarks
    landmarks_with_status = []
    for landmark in LANDMARKS_DATA:
        landmark_copy = landmark.copy()
        landmark_copy['visited'] = landmark['id'] in visited_places
        landmarks_with_status.append(landmark_copy)
    
    return jsonify({
        'success': True,
        'landmarks': landmarks_with_status
    })

@app.route('/api/landmarks/<landmark_id>')
@login_required
def get_landmark_detail(landmark_id):
    """Get detailed information about a specific landmark"""
    landmark = next((l for l in LANDMARKS_DATA if l['id'] == landmark_id), None)
    if not landmark:
        return jsonify({'success': False, 'message': 'Landmark not found'}), 404
    
    user_email = session['user_id']
    user = users_db.get(user_email)
    visited_places = user.get('visited_places', []) if user else []
    
    landmark_detail = landmark.copy()
    landmark_detail['visited'] = landmark_id in visited_places
    
    return jsonify({
        'success': True,
        'landmark': landmark_detail
    })

# --- Seva API Routes ---

@app.route('/api/seva-quests')
@login_required
def get_seva_quests():
    """Get all seva quests"""
    user_email = session['user_id']
    user = users_db.get(user_email)
    completed_seva = user.get('completed_seva', []) if user else []
    
    # Add completion status and web icons to seva quests
    seva_with_status = []
    for quest in SEVA_QUESTS_DATA:
        quest_copy = quest.copy()
        quest_copy['completed'] = quest['id'] in completed_seva
        quest_copy['web_icon'] = ICON_MAPPING.get(quest['icon'], 'fas fa-hands-helping')
        seva_with_status.append(quest_copy)
    
    return jsonify({
        'success': True,
        'seva_quests': seva_with_status,
        'user_punya': user.get('punya', 0) if user else 0
    })

@app.route('/api/seva-quests/<quest_id>/complete', methods=['POST'])
@login_required
def complete_seva_quest(quest_id):
    """Complete a seva quest"""
    user_email = session['user_id']
    user = users_db.get(user_email)
    
    if not user:
        return jsonify({'success': False, 'message': 'User not found'}), 404
    
    # Find the quest
    quest = next((q for q in SEVA_QUESTS_DATA if q['id'] == quest_id), None)
    if not quest:
        return jsonify({'success': False, 'message': 'Seva quest not found'}), 404
    
    # Check if already completed
    if quest_id in user.get('completed_seva', []):
        return jsonify({'success': False, 'message': 'Seva already completed'}), 409
    
    # Complete the seva
    if 'completed_seva' not in user:
        user['completed_seva'] = []
    user['completed_seva'].append(quest_id)
    
    # Add punya points
    user['punya'] = user.get('punya', 0) + quest['punya']
    
    # Add badge
    if 'badges' not in user:
        user['badges'] = []
    if quest['badge'] not in user['badges']:
        user['badges'].append(quest['badge'])
    
    return jsonify({
        'success': True,
        'message': f'Congratulations! You earned {quest["punya"]} punya points and the {quest["badge"]} badge!',
        'punya_earned': quest['punya'],
        'badge_earned': quest['badge'],
        'total_punya': user['punya']
    })


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)
