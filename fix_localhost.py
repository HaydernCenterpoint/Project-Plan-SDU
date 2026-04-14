import os

src_dir = "./src"

for root, _, files in os.walk(src_dir):
    for f in files:
        if f.endswith(".tsx") or f.endswith(".ts"):
            path = os.path.join(root, f)
            with open(path, "r", encoding="utf-8") as file:
                content = file.read()
            if "http://localhost:8000" in content:
                new_content = content.replace("http://localhost:8000", "")
                with open(path, "w", encoding="utf-8") as file:
                    file.write(new_content)
                print(f"Updated {path}")
