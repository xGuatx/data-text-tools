import json

with open("recap.txt", "r", encoding="utf-8") as txt_file, open("recap.jsonl", "w", encoding="utf-8") as jsonl_file:
    for i, line in enumerate(txt_file):
        request_data = {
            "custom_id": f"requete-{i+1}",
            "method": "POST",
            "url": "/v1/chat/completions",
            "body": {
                "model": "gpt-4o",
                "messages": [{"role": "user", "content": line.strip()}],
                "max_tokens": 1000
            }
        }
        jsonl_file.write(json.dumps(request_data) + "\n")
