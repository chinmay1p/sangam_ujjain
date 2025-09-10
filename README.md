# 🕉️ S.A.N.G.A.M - Spiritual And Navigation Guide for Authentic Mahakumbh

**S.A.N.G.A.M** is a comprehensive digital platform designed to enhance the spiritual journey of pilgrims during the Ujjain Mahakumbh 2028. The project consists of both a Flutter mobile application and a Flask web application, providing seamless access across multiple platforms.

## 🌟 Project Overview

S.A.N.G.A.M serves as a complete digital companion for the Ujjain Mahakumbh, offering spiritual guidance, navigation assistance, community service opportunities, and safety features. The platform integrates traditional spiritual practices with modern technology to create an authentic and enriching pilgrimage experience.

## 📱 Applications

### 1. **sangam_app** - Flutter Mobile Application
- **Platform**: Cross-platform mobile app (Android, iOS, Linux)
- **Technology**: Flutter with Firebase backend
- **Purpose**: Primary mobile experience for pilgrims

### 2. **sangam_web** - Flask Web Application  
- **Platform**: Web-based application
- **Technology**: Flask with Firebase integration
- **Purpose**: Web access and administrative features

## ✨ Key Features

### 🏛️ **Sanskrti Module** - Spiritual Heritage
- **Sacred Landmarks**: Detailed information about 6+ major spiritual sites  
- **Interactive Stories**: Rich narratives about each location's spiritual significance
- **Video Content**: YouTube integration for virtual tours
- **Punya Tracking**: Earn spiritual merit points for visits
- **Visit Tracking**: Mark and track visited sacred places

### 🤝 **Seva Module** - Community Service
- **Badge System**: Earn service badges for completed seva
- **Progress Tracking**: Monitor community service contributions
- **Real-time Updates**: Live seva opportunities and locations

### 🏠 **Home Module**
- **Mahakumbh 2028 Schedule**: Complete event calendar with 9 major events  
- **User Dashboard**: Personal punya points, badges, and progress
- **Quick Access**: Navigation to all major features

### 📖 **Sacred Streams Story Module**
- **Interactive Storytelling**: Animated story about Ujjain Mahakumbh
- **GSAP Animations**: Scroll-based interactive animations
- **Visual Journey**: Immersive storytelling experience
- **Educational Content**: Learn about Ujjain's spiritual significance

### 👤 **Profile Module**
- **User Management**: Complete profile with SANGAM ID
- **Achievement System**: Display earned badges and punya points
- **Visit History**: Track of visited landmarks and completed seva
- **Personal Stats**: Comprehensive spiritual journey metrics

### 🤖 **AI Chatbot - Sangam Sathi**
- **Spiritual Guidance**: AI-powered RAG based assistant for pilgrimage queries
- **Temple Information**: Detailed information about Ujjain temples
- **Travel Tips**: Practical advice for pilgrims
- **24/7 Support**: Always available digital companion

### 🆘 **Safety Features**
- **SOS Alert System**: Emergency assistance with location sharing
- **Family Finder**: Locate family members in crowds
- **Crowd Navigation**: Real-time guidance for managing large gatherings
- **Emergency Contacts**: Quick access to help services

## 🛠️ Technical Architecture

### Mobile App (sangam_app)
- **Framework**: Flutter 3.9.2+
- **State Management**: Provider pattern
- **Backend**: Firebase (Authentication, Firestore, Storage)
- **Key Dependencies**:
  - `firebase_core`, `firebase_auth`, `cloud_firestore`
  - `geolocator`, `permission_handler` (Location services)
  - `youtube_player_flutter` (Video content)
  - `google_fonts` (Typography)
  - `provider` (State management)

### Web App (sangam_web)
- **Framework**: Flask 2.3.3
- **Frontend**: HTML5, CSS3, JavaScript with GSAP animations
- **Backend**: Python with Firebase integration
- **Security**: Werkzeug password hashing, session management
- **Key Dependencies**:
  - `Flask`, `Werkzeug` (Web framework)
  - `firebase-admin` (Firebase integration)
  - `python-dotenv` (Environment management)

## 🚀 Installation & Setup

### Prerequisites
- **For Mobile App**: Flutter SDK 3.9.2+, Android Studio/VS Code
- **For Web App**: Python 3.8+, pip
- **Common**: Firebase project with configured services

### Mobile App Setup (sangam_app)

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd sangam/sangam_app
   ```

2. **Install Flutter dependencies**
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**
   - Add your `google-services.json` (Android) and `GoogleService-Info.plist` (iOS)
   - Update `firebase_options.dart` with your Firebase configuration

4. **Run the application**
   ```bash
   flutter run
   ```

### Web App Setup (sangam_web)

1. **Navigate to web directory**
   ```bash
   cd sangam/sangam_web
   ```

2. **Create virtual environment**
   ```bash
   python -m venv .venv
   source .venv/bin/activate  # On Windows: .venv\Scripts\activate
   ```

3. **Install dependencies**
   ```bash
   pip install -r requirements.txt
   ```

4. **Configure environment variables**
   ```bash
   # Create .env file
   SECRET_KEY=your_secret_key_here
   ```

5. **Set up Firebase**
   - Add your Firebase service account key
   - Update Firebase configuration in the app

6. **Run the application**
   ```bash
   python app.py
   ```

The web application will be available at `http://localhost:5000`

## 🎯 Usage Guide

### For Pilgrims
1. **Registration**: Create account with name, email, mobile, and password
2. **Explore Sanskrti**: Visit sacred landmarks and earn punya points
3. **Participate in Seva**: Join community service activities
4. **Track Progress**: Monitor your spiritual journey through badges and points
5. **Stay Safe**: Use SOS features and family finder when needed
6. **Get Guidance**: Chat with Sangam Sathi AI for assistance

### For Administrators
1. **User Management**: Monitor registered users and their activities
2. **Content Updates**: Manage landmark information and seva opportunities
3. **Analytics**: Track platform usage and engagement metrics

## 🔒 Security Features

- **Password Security**: Werkzeug password hashing
- **Session Management**: Secure session handling
- **Authentication**: Login required decorators for protected routes
- **Data Protection**: User data sanitization and validation
- **Environment Security**: Environment variables for sensitive data


## 🔮 Future Enhancements

- **Real-time Location Tracking**: GPS-based navigation
- **Multilingual Support**: Hindi, English, and regional languages
- **Offline Mode**: Core features available without internet
- **Advanced Analytics**: Detailed insights and recommendations
- **Social Features**: Connect with fellow pilgrims
- **AR Integration**: Augmented reality for landmark information

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

---

**🕉️ May your spiritual journey be blessed with divine grace and technological convenience. Har Har Mahadev! 🕉️**
