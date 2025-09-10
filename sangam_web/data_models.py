# Data models extracted from sangam_app

# Sanskrti (Landmarks) data from sangam_app
LANDMARKS_DATA = [
    {
        'id': 'ram_ghat',
        'title': 'Ram Ghat',
        'subtitle': 'The Sacred Bathing Ghat',
        'image': 'static/assets/ram ghat.png',
        'video': 'https://youtu.be/9aeeoL011p0?feature=shared',
        'story': 'Ram Ghat is one of the most sacred bathing ghats in Ujjain, where pilgrims come to take a holy dip in the Shipra River. According to legend, Lord Rama himself visited this ghat during his exile. The ghat is believed to have the power to cleanse one\'s sins and purify the soul. Every morning, thousands of devotees gather here to witness the divine sunrise and offer prayers to the sacred river.',
        'significance': 'This ghat is considered one of the 84 ghats mentioned in ancient scriptures and is believed to be blessed by Lord Rama himself.',
        'punya_points': 5,
        'category': 'ghat'
    },
    {
        'id': 'mahakal_temple',
        'title': 'Mahakaleshwar Temple',
        'subtitle': 'The Jyotirlinga of Ujjain',
        'image': 'static/assets/mahakaleshwar temple.png',
        'video': 'https://youtu.be/3P-Xz0MMxw8?feature=shared',
        'story': 'The Mahakaleshwar Temple is one of the 12 Jyotirlingas of Lord Shiva and is considered one of the most powerful temples in India. The temple houses the Swayambhu (self-manifested) lingam of Lord Shiva. According to mythology, the temple was established when Lord Shiva appeared to save the city of Ujjain from the demon Dushana. The temple is known for its unique Bhasma Aarti, performed with sacred ash from the cremation grounds.',
        'significance': 'This is the only Jyotirlinga that faces south, symbolizing the power of Lord Shiva to protect from all directions.',
        'punya_points': 10,
        'category': 'temple'
    },
    {
        'id': 'harsiddhi_temple',
        'title': 'Harsiddhi Temple',
        'subtitle': 'The Shakti Peeth',
        'image': 'static/assets/harsiddhi temple.png',
        'video': 'https://youtu.be/u_TTxtVegcY?feature=shared',
        'story': 'The Harsiddhi Temple is one of the 51 Shakti Peethas, where the elbow of Goddess Sati is believed to have fallen. The temple is dedicated to Goddess Annapurna and is considered extremely powerful for fulfilling wishes. According to legend, King Vikramaditya was blessed by the goddess here, which led to his great prosperity and wisdom. The temple is known for its unique architecture and the presence of two sacred lamps that are said to have been burning continuously for centuries.',
        'significance': 'This temple is believed to grant all wishes and is especially powerful for those seeking prosperity and wisdom.',
        'punya_points': 8,
        'category': 'temple'
    },
    {
        'id': 'kal_bhairav_temple',
        'title': 'Kal Bhairav Temple',
        'subtitle': 'The Guardian of Ujjain',
        'image': 'static/assets/kal bhairav temple.png',
        'video': 'https://youtu.be/VVFHUjWGjvQ?feature=shared',
        'story': 'The Kal Bhairav Temple is dedicated to Lord Bhairav, the fierce form of Lord Shiva and the guardian deity of Ujjain. The temple is known for its unique tradition of offering alcohol to the deity, which is considered a sacred offering. According to legend, Lord Bhairav protects the city of Ujjain from all negative energies and evil forces. The temple is believed to have the power to remove obstacles and provide protection to devotees.',
        'significance': 'Lord Bhairav is considered the Kotwal (guardian) of Ujjain and is believed to protect the city and its devotees.',
        'punya_points': 7,
        'category': 'temple'
    },
    {
        'id': 'sandipani_ashram',
        'title': 'Sandipani Ashram',
        'subtitle': 'The Ancient School of Wisdom',
        'image': 'static/assets/sandipani ashram.png',
        'video': 'https://youtu.be/9aeeoL011p0?feature=shared',
        'story': 'Sandipani Ashram is the ancient school where Lord Krishna, Balarama, and Sudama received their education. The ashram is located on the banks of the Shipra River and is considered one of the most sacred places in Ujjain. According to legend, Lord Krishna learned all 64 arts and sciences here under the guidance of Guru Sandipani. The ashram is known for its peaceful atmosphere and spiritual energy.',
        'significance': 'This ashram is considered the birthplace of divine knowledge and is believed to bless students and seekers with wisdom.',
        'punya_points': 6,
        'category': 'ashram'
    },
    {
        'id': 'shipra_river',
        'title': 'Shipra River',
        'subtitle': 'The Sacred River of Ujjain',
        'image': 'static/assets/shipra river.png',
        'video': 'https://youtu.be/9aeeoL011p0?feature=shared',
        'story': 'The Shipra River is considered one of the most sacred rivers in India and is believed to have the power to cleanse sins and purify the soul. According to mythology, the river was created by Lord Shiva himself and is considered as holy as the Ganges. The river is known for its crystal-clear water and is surrounded by numerous ghats where pilgrims come to take holy dips. The river is especially sacred during the Kumbh Mela when millions of devotees gather to bathe in its waters.',
        'significance': 'The Shipra River is considered as sacred as the Ganges and is believed to have the power to grant moksha (liberation).',
        'punya_points': 5,
        'category': 'river'
    }
]

# Seva Quests data from sangam_app
SEVA_QUESTS_DATA = [
    {
        'id': 'water_service',
        'title': 'Jal Seva - Water Service',
        'description': 'Help serve water to fellow pilgrims at designated water stations',
        'icon': 'water_drop',
        'punya': 10,
        'badge': 'Jal Sevak',
        'color': '#2196F3',  # Blue
        'category': 'service',
        'duration': '2-3 hours',
        'location': 'Various water stations'
    },
    {
        'id': 'cleanup_drive',
        'title': 'Swachh Seva - Cleanup Drive',
        'description': 'Participate in keeping the sacred grounds clean and beautiful',
        'icon': 'cleaning_services',
        'punya': 15,
        'badge': 'Swachh Sevak',
        'color': '#4CAF50',  # Green
        'category': 'environment',
        'duration': '3-4 hours',
        'location': 'Temple premises and ghats'
    },
    {
        'id': 'food_distribution',
        'title': 'Ann Seva - Food Distribution',
        'description': 'Help distribute prasad and food to devotees',
        'icon': 'restaurant',
        'punya': 20,
        'badge': 'Ann Sevak',
        'color': '#FF9800',  # Orange
        'category': 'service',
        'duration': '4-5 hours',
        'location': 'Community kitchens and temples'
    },
    {
        'id': 'crowd_guidance',
        'title': 'Marg Darshan - Crowd Guidance',
        'description': 'Help guide fellow pilgrims and maintain orderly queues',
        'icon': 'directions',
        'punya': 12,
        'badge': 'Marg Darshak',
        'color': '#9C27B0',  # Purple
        'category': 'guidance',
        'duration': '3-4 hours',
        'location': 'Temple entrances and major ghats'
    },
    {
        'id': 'elderly_help',
        'title': 'Vriddha Seva - Elderly Assistance',
        'description': 'Assist elderly pilgrims with their needs and comfort',
        'icon': 'elderly',
        'punya': 25,
        'badge': 'Vriddha Sevak',
        'color': '#F44336',  # Red
        'category': 'care',
        'duration': '2-6 hours',
        'location': 'Rest areas and medical camps'
    },
    {
        'id': 'temple_cleaning',
        'title': 'Mandir Seva - Temple Cleaning',
        'description': 'Help clean and maintain the sacred temple premises',
        'icon': 'temple_hindu',
        'punya': 18,
        'badge': 'Mandir Sevak',
        'color': '#3F51B5',  # Indigo
        'category': 'maintenance',
        'duration': '3-5 hours',
        'location': 'Various temples'
    }
]

# Icon mapping for web display
ICON_MAPPING = {
    'water_drop': 'fas fa-tint',
    'cleaning_services': 'fas fa-broom',
    'restaurant': 'fas fa-utensils',
    'directions': 'fas fa-directions',
    'elderly': 'fas fa-user-friends',
    'temple_hindu': 'fas fa-place-of-worship'
}
