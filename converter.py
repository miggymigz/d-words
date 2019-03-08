import io
import json
import csv
import re
import sys

CSV_FILES = ['lesson1', 'lesson2']

lessons = []
matcher = re.compile(r'^lesson(\d+)$')

for csv_filename in CSV_FILES:
    groups = matcher.match(csv_filename)
    if not groups:
        print('%s is an invalid filename!' % csv_filename)
        sys.exit(1)

    with io.open('assets/%s.csv' % csv_filename, 'r', encoding='utf8') as csv_file:
        csv_reader = csv.reader(csv_file)

        lesson = {
            'order': int(groups[1]),
            'title': '',
            'words': [
            ]
        }

        first = True
        for row in csv_reader:
            if first:
                lesson['title'] = row[0]
                first = False
                continue

            lesson['words'].append({
                'word': row[0],
                'pinyin': row[1],
                'partOfSpeech': row[2],
                'definition': row[3],
            })

        lessons.append(lesson)

with io.open('assets/output.json', 'w', encoding='utf8') as json_file:
    print(json.dumps(lessons), file=json_file)
