from datetime import datetime

def get_date():
    """
    A compact timestamp.

    Example: 2021-09-26 [yyyy-mm-dd]
    """
    now = datetime.now()
    date = datetime.date(now)
    return f"{date.year}-{date.month:02}-{date.day:02}"
