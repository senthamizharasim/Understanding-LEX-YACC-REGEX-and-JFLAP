import re

patterns = [
    ("FLOAT", r"^[+-]?\d+\.\d+$"),
    ("INTEGER", r"^[+-]?\d+$"),
    ("IDENTIFIER", r"^[a-zA-Z_][a-zA-Z0-9_]*$"),
]

def classify_token(token):
    for token_type, pattern in patterns:
        if re.match(pattern, token):
            return token_type
    return "INVALID"

test_tokens = ["var_name1", "99total", "3.1415", "-42", "_init", "12.abc"]

print(f"{'Token':<15} | {'Classification'}")
print("-" * 32)
for t in test_tokens:
    print(f"{t:<15} | {classify_token(t)}")