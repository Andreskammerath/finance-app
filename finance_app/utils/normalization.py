import re


def normalize_string(string):
    # Remove multiple spaces between words and replace with a single space
    string = re.sub(r'\s+', ' ', string).strip()

    # Capitalize the first letter of each word
    string = ' '.join(word.capitalize() for word in string.split())

    return string
