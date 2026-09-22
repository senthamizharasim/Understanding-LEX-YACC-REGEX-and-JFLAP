import re

text = """
Log entry on 2026-09-19: User cooper_s@vitstudent.ac.in submitted lab assignment.
Previous attempt on 2026-08-15 from admin@dept.edu failed.
Invalid entries: test@com, 19-09-2026, user@@vit.ac.in.
"""

date_pattern = r"\b\d{4}-(?:0[1-9]|1[0-2])-(?:0[1-9]|[12]\d|3[01])\b"
email_pattern = r"\b[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.(?:edu|ac\.in)\b"

dates = re.findall(date_pattern, text)
emails = re.findall(email_pattern, text)

print("Valid Dates Found:", dates)
print("Valid Institutional Emails:", emails)