#!/usr/bin/env python3
"""Generate 0013_expand_content.sql from the content JSON files."""
import json
import os
import uuid

CONTENT_DIR = "/root/workspace/kpss-akilli/content"
OUT_PATH = "/root/workspace/kpss-akilli/supabase/migrations/0013_expand_content.sql"

FILES = ["turkce", "matematik", "tarih", "cografya", "vatandaslik"]

def esc(s):
    if s is None:
        return "NULL"
    return "'" + str(s).replace("'", "''") + "'"

def main():
    lines = []
    lines.append("-- 0013_expand_content.sql")
    lines.append("-- Adds full lesson content + practice questions for all 21 kpss_lisans topics")
    lines.append("-- (Turkce, Matematik, Tarih, Cografya, Vatandaslik), generated + fact-checked content.")
    lines.append("begin;")
    lines.append("")

    total_topics = 0
    total_questions = 0

    for fname in FILES:
        path = os.path.join(CONTENT_DIR, fname + ".json")
        data = json.load(open(path, encoding="utf-8"))
        lines.append(f"-- ===== {fname} =====")
        for topic in data:
            topic_id = topic["topic_id"]
            tc = topic["topic_content"]
            total_topics += 1

            lines.append(
                "insert into topic_contents (topic_id, summary, content_md, example_question) values ("
                f"{esc(topic_id)}, {esc(tc['summary'])}, {esc(tc['content_md'])}, {esc(tc['example_question'])}"
                ") on conflict (topic_id) do update set "
                "summary = excluded.summary, content_md = excluded.content_md, "
                "example_question = excluded.example_question;"
            )

            for q in topic["questions"]:
                total_questions += 1
                qid = str(uuid.uuid4())
                choices = q["choices"]
                correct_index = q["correct_index"]
                lines.append(
                    f"insert into questions (id, topic_id, difficulty, question_text, kazanim, explanation) values ("
                    f"{esc(qid)}, {esc(topic_id)}, {esc(q['difficulty'])}::difficulty_level, "
                    f"{esc(q['question_text'])}, {esc(q['kazanim'])}, {esc(q['explanation'])});"
                )
                for idx, choice_text in enumerate(choices):
                    lines.append(
                        "insert into question_choices (question_id, choice_text, is_correct, order_index) values ("
                        f"{esc(qid)}, {esc(choice_text)}, {str(idx == correct_index).lower()}, {idx});"
                    )
        lines.append("")

    lines.append("commit;")
    lines.append("")
    lines.append(f"-- Summary: {total_topics} topics (topic_contents upserted), {total_questions} questions inserted, "
                  f"{total_questions * 4} question_choices inserted.")

    os.makedirs(os.path.dirname(OUT_PATH), exist_ok=True)
    with open(OUT_PATH, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    print(f"Wrote {OUT_PATH}")
    print(f"topics={total_topics} questions={total_questions} choices={total_questions*4}")

if __name__ == "__main__":
    main()
