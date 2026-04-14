import re

with open('src/store/useAppStore.ts', 'r', encoding='utf-8') as f:
    content = f.read()

# Replace the first template columns with empty names
def replace_col_name(match):
    # match is the whole match of { id:... name: '...' ... }
    # we replace only the name part
    return re.sub(r"name:\s*'.*?'", "name: ''", match.group(0))

# We want to change columns of tpl-1 only
tpl_1_match = re.search(r"(id:\s*'tpl-1'.*?columns:\s*\[\s*)(.*?)(\s*\])", content, re.DOTALL)
if tpl_1_match:
    columns_str = tpl_1_match.group(2)
    # Replace all names inside this block
    new_columns_str = re.sub(r"\{[^}]*\}", replace_col_name, columns_str)
    content = content[:tpl_1_match.start(2)] + new_columns_str + content[tpl_1_match.end(2):]

with open('src/store/useAppStore.ts', 'w', encoding='utf-8') as f:
    f.write(content)
print("Updated successfully")
