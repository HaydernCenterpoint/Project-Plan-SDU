with open('src/store/useAppStore.ts', 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace(r"\'tpl-1\'", "'tpl-1'")
c = c.replace(r"\'", "'")

with open('src/store/useAppStore.ts', 'w', encoding='utf-8') as f:
    f.write(c)

print("Fixed backslashes")
