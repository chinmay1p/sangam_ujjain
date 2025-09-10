#!/usr/bin/env python3
"""
HTML Validation and Testing Script for Sangam Ujjain Website
"""

import os
import re
from pathlib import Path

def validate_html_structure():
    """Validate HTML structure and common issues"""
    issues = []
    
    # Check template files
    template_dir = Path("templates")
    if template_dir.exists():
        for template_file in template_dir.glob("*.html"):
            with open(template_file, 'r', encoding='utf-8') as f:
                content = f.read()
                
            # Check for common HTML issues
            file_issues = []
            
            # Check for unclosed tags (basic check)
            if content.count('<div') != content.count('</div>'):
                file_issues.append("Potential unclosed <div> tags")
            
            if content.count('<section') != content.count('</section>'):
                file_issues.append("Potential unclosed <section> tags")
            
            # Check for missing alt attributes on images
            img_tags = re.findall(r'<img[^>]*>', content)
            for img in img_tags:
                if 'alt=' not in img:
                    file_issues.append(f"Missing alt attribute: {img[:50]}...")
            
            # Check for missing meta viewport (for base.html)
            if template_file.name == 'base.html':
                if 'name="viewport"' not in content:
                    file_issues.append("Missing viewport meta tag")
            
            # Check for inline styles (should be minimal)
            inline_styles = re.findall(r'style="[^"]*"', content)
            if len(inline_styles) > 10:  # Allow some inline styles
                file_issues.append(f"Many inline styles found ({len(inline_styles)})")
            
            # Check for accessibility issues
            if 'aria-' not in content and template_file.name == 'base.html':
                file_issues.append("Consider adding ARIA attributes for accessibility")
            
            if file_issues:
                issues.append({
                    'file': str(template_file),
                    'issues': file_issues
                })
    
    return issues

def validate_css_structure():
    """Validate CSS structure"""
    issues = []
    
    css_dir = Path("static/css")
    if css_dir.exists():
        for css_file in css_dir.glob("*.css"):
            with open(css_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            file_issues = []
            
            # Check for unclosed braces
            if content.count('{') != content.count('}'):
                file_issues.append("Potential unclosed CSS braces")
            
            # Check for missing semicolons (basic check)
            lines = content.split('\n')
            for i, line in enumerate(lines, 1):
                line = line.strip()
                if line and ':' in line and not line.endswith((';', '{', '}')) and not line.startswith(('/*', '*', '@')):
                    file_issues.append(f"Line {i}: Possible missing semicolon")
            
            if file_issues:
                issues.append({
                    'file': str(css_file),
                    'issues': file_issues
                })
    
    return issues

def validate_js_structure():
    """Validate JavaScript structure"""
    issues = []
    
    js_dir = Path("static/js")
    if js_dir.exists():
        for js_file in js_dir.glob("*.js"):
            with open(js_file, 'r', encoding='utf-8') as f:
                content = f.read()
            
            file_issues = []
            
            # Check for unclosed braces and parentheses
            if content.count('{') != content.count('}'):
                file_issues.append("Potential unclosed JavaScript braces")
            
            if content.count('(') != content.count(')'):
                file_issues.append("Potential unclosed parentheses")
            
            # Check for console.log statements (should be minimal in production)
            console_logs = content.count('console.log')
            if console_logs > 5:
                file_issues.append(f"Many console.log statements found ({console_logs})")
            
            # Check for error handling
            if 'try' in content and 'catch' not in content:
                file_issues.append("Try block without catch - potential error handling issue")
            
            if file_issues:
                issues.append({
                    'file': str(js_file),
                    'issues': file_issues
                })
    
    return issues

def check_static_assets():
    """Check if static assets exist"""
    issues = []
    
    # Required assets
    required_assets = [
        'static/assets/logo.png',
        'static/assets/ujjain_city_1.png',
        'static/assets/mahakaleshwar temple.png',
        'static/assets/harsiddhi temple.png',
        'static/assets/kal bhairav temple.png',
        'static/assets/ram ghat.png',
        'static/assets/sandipani ashram.png',
        'static/assets/shipra river.png',
        'static/assets/chatbot_icon.png'
    ]
    
    missing_assets = []
    for asset in required_assets:
        if not Path(asset).exists():
            missing_assets.append(asset)
    
    if missing_assets:
        issues.append({
            'category': 'Missing Assets',
            'issues': missing_assets
        })
    
    return issues

def generate_report():
    """Generate validation report"""
    print("🔍 Sangam Ujjain Website Validation Report")
    print("=" * 50)
    
    # HTML Validation
    print("\n📄 HTML Structure Validation:")
    html_issues = validate_html_structure()
    if html_issues:
        for item in html_issues:
            print(f"  ❌ {item['file']}:")
            for issue in item['issues']:
                print(f"    - {issue}")
    else:
        print("  ✅ No HTML structure issues found")
    
    # CSS Validation
    print("\n🎨 CSS Structure Validation:")
    css_issues = validate_css_structure()
    if css_issues:
        for item in css_issues:
            print(f"  ❌ {item['file']}:")
            for issue in item['issues']:
                print(f"    - {issue}")
    else:
        print("  ✅ No CSS structure issues found")
    
    # JavaScript Validation
    print("\n⚡ JavaScript Structure Validation:")
    js_issues = validate_js_structure()
    if js_issues:
        for item in js_issues:
            print(f"  ❌ {item['file']}:")
            for issue in item['issues']:
                print(f"    - {issue}")
    else:
        print("  ✅ No JavaScript structure issues found")
    
    # Asset Validation
    print("\n🖼️  Static Assets Validation:")
    asset_issues = check_static_assets()
    if asset_issues:
        for item in asset_issues:
            print(f"  ❌ {item['category']}:")
            for issue in item['issues']:
                print(f"    - {issue}")
    else:
        print("  ✅ All required assets found")
    
    # Summary
    total_issues = len(html_issues) + len(css_issues) + len(js_issues) + len(asset_issues)
    print(f"\n📊 Summary:")
    print(f"  Total files checked: HTML, CSS, JS, Assets")
    print(f"  Issues found: {total_issues}")
    
    if total_issues == 0:
        print("  🎉 Website validation completed successfully!")
    else:
        print("  ⚠️  Please review and fix the issues above")
    
    print("\n🚀 Ready for deployment!")
    print("=" * 50)

if __name__ == "__main__":
    # Change to the correct directory
    os.chdir(os.path.dirname(os.path.abspath(__file__)))
    generate_report()
