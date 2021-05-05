#!/usr/bin/env python3

f = open("input", 'r')
score = 0

# questions in group
qig = set(())

while True:
    line = f.readline()
    if not line:
        break

    if line == "\n":
        print(qig)
        score += len(qig)
        qig = set(())
    else:
        for element in line.strip():
            qig.add(element)

f.close()
print('Score: {score}'.format(score = score))
